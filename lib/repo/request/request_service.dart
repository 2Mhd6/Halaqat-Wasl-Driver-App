import 'dart:async';
import 'dart:developer' as developer;
import 'package:halaqat_wasl_driver_app/model/request%20model/request_model.dart';
import 'package:halaqat_wasl_driver_app/repo/request/request_process.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
class RequestService {
  final SupabaseClient _client;
  static const Duration _supabaseTimeout = Duration(seconds: 10);

  RequestService(this._client);

  Future<List<RequestModel>> getDriverRequests(String driverId) async {
    try {
      final response = await _client
          .from('requests')
          .select('''
            *,
            user:users(user_id, notification_id, full_name, role, email, phone_number, gender),
            hospital:hospital(hospital_id, hospital_name, hospital_lat, hospital_long)
          ''')
          .eq('driver_id', driverId)
          .not('status', 'in', ['completed', 'canceled'])
          .order('request_date', ascending: false)
          .timeout(_supabaseTimeout);

      final enriched = await RequestProcessor.enrichRequests(
        (response as List).cast<Map<String, dynamic>>(),
        _client,
      );
      return await RequestProcessor.processRequests(enriched);
    } on TimeoutException {
      throw Exception('Request timed out after $_supabaseTimeout');
    } catch (e, stack) {
      developer.log('getDriverRequests failed', error: e, stackTrace: stack);
      throw Exception('Failed to fetch requests: ${e.toString()}');
    }
  }

  Stream<List<RequestModel>> streamDriverRequests(String driverId) {
    return _client
        .from('requests')
        .stream(primaryKey: ['request_id'])
        .eq('driver_id', driverId)
        .order('request_date', ascending: false)
        .asyncMap((requests) async {
          try {
            final requestsList = (requests as List)
                .cast<Map<String, dynamic>>();
            final enriched = await RequestProcessor.enrichRequests(
              requestsList,
              _client,
            );
            final processed = await RequestProcessor.processRequests(enriched);

            final allowedStatuses = {'accepted'};
            return processed
                .where((r) => allowedStatuses.contains(r.status))
                .toList();
          } catch (e, stack) {
            developer.log(
              'streamDriverRequests failed',
              error: e,
              stackTrace: stack,
            );
            return [];
          }
        });
  }

  Future<void> markRequestCompleted(String requestId) async {
    try {
      //  Mark request as completed and get driver_id + charity_id
      final requestResponse = await _client
          .from('requests')
          .update({'status': 'completed'})
          .eq('request_id', requestId)
          .select('driver_id, charity_id')
          .single()
          .timeout(_supabaseTimeout);

      developer.log('Request updated: $requestResponse');

      final driverId = requestResponse['driver_id'];
      final charityId = requestResponse['charity_id'];

      if (driverId == null) {
        throw Exception('Driver ID is null for request $requestId');
      }

      if (charityId == null) {
        throw Exception('Charity ID is null for request $requestId');
      }

      // Get driver's current total_services
      final driverResponse = await _client
          .from('driver')
          .select('total_services')
          .eq('driver_id', driverId)
          .single()
          .timeout(_supabaseTimeout);

      final currentDriverTotal = (driverResponse['total_services'] ?? 0) as int;

      // Update driver's total_services
      await _client
          .from('driver')
          .update({'total_services': currentDriverTotal + 1})
          .eq('driver_id', driverId)
          .timeout(_supabaseTimeout);

      developer.log(
        'Driver total_services updated to ${currentDriverTotal + 1}',
      );

      //Also mark driver as available
      await _client
          .from('driver')
          .update({'status': 'available'})
          .eq('driver_id', driverId)
          .timeout(_supabaseTimeout);

      developer.log(' Driver $driverId marked as available');

      //  charity's current total_services
      final charityResponse = await _client
          .from('charity')
          .select('total_services')
          .eq('charity_id', charityId)
          .single()
          .timeout(_supabaseTimeout);

      final currentCharityTotal =
          (charityResponse['total_services'] ?? 0) as int;

      //Update charity's total_services
      await _client
          .from('charity')
          .update({'total_services': currentCharityTotal + 1})
          .eq('charity_id', charityId)
          .timeout(_supabaseTimeout);

      developer.log(
        'Charity total_services updated to ${currentCharityTotal + 1}',
      );
    } on TimeoutException {
      developer.log('⏱️ markRequestCompleted timed out');
      throw Exception('Operation timed out after $_supabaseTimeout');
    } catch (e, stack) {
      developer.log(
        'markRequestCompleted failed',
        name: 'RequestService',
        error: e,
        stackTrace: stack,
      );
      rethrow;
    }
  }

  Future<void> markRequestStarted(String requestId) async {
    try {
      // STEP 1: Get driver_id from the request
      final request = await _client
          .from('requests')
          .select('driver_id')
          .eq('request_id', requestId)
          .single()
          .timeout(_supabaseTimeout);

      final driverId = request['driver_id'];
      if (driverId == null) {
        throw Exception('No driver found for request $requestId');
      }

      // Update driver's status to "on trip"
      await _client
          .from('driver')
          .update({'status': 'on trip'})
          .eq('driver_id', driverId)
          .timeout(_supabaseTimeout);

      developer.log('Driver $driverId marked as on trip');
    } on TimeoutException {
      developer.log('⏱️ markRequestStarted timed out');
      throw Exception('Request timed out after $_supabaseTimeout');
    } catch (e, stack) {
      developer.log('markRequestStarted failed', error: e, stackTrace: stack);
      throw Exception(
        'Failed to start trip for request $requestId: ${e.toString()}',
      );
    }
  }
}
