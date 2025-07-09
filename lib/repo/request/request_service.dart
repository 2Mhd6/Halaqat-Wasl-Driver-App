import 'dart:async';
import 'dart:developer' as developer;
import 'package:halaqat_wasl_driver_app/model/request%20model/request_model.dart';
import 'package:halaqat_wasl_driver_app/repo/request/request_process.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RequestService {
  final SupabaseClient _client;

  RequestService(this._client);
  // Fetch active requests assigned to a driver (excluding completed/canceled)
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
          .order('request_date', ascending: false);

      final enriched = await RequestProcessor.enrichRequests(
        (response as List).cast<Map<String, dynamic>>(),
        _client,
      );
      return await RequestProcessor.processRequests(enriched);
    } catch (e) {
      developer.log('getDriverRequests failed');
      throw Exception('Failed to fetch requests');
    }
  }

  // Stream live updates of driver's requests filtered by status 'accepted'
  Stream<List<RequestModel>> streamDriverRequests(String driverId) {
    return _client
        .from('requests')
        .stream(primaryKey: ['request_id'])
        .eq('driver_id', driverId)
        .order('request_date', ascending: true)
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

  // Mark request as completed and update related driver and charity stats/status
  Future<void> markRequestCompleted(String requestId) async {
    try {
      final requestResponse = await _client
          .from('requests')
          .update({'status': 'completed'})
          .eq('request_id', requestId)
          .select('driver_id, charity_id')
          .single();

      developer.log('Request updated: $requestResponse');

      final driverId = requestResponse['driver_id'];
      final charityId = requestResponse['charity_id'];

      if (driverId == null)
        throw Exception('Driver ID is null for request $requestId');
      if (charityId == null)
        throw Exception('Charity ID is null for request $requestId');

      // Update driver's total_services count
      final driverResponse = await _client
          .from('driver')
          .select('total_services')
          .eq('driver_id', driverId)
          .single();

      final currentDriverTotal = (driverResponse['total_services'] ?? 0) as int;

      await _client
          .from('driver')
          .update({'total_services': currentDriverTotal + 1})
          .eq('driver_id', driverId);

      developer.log(
        'Driver total_services updated to ${currentDriverTotal + 1}',
      );

      // Mark driver as available again
      await _client
          .from('driver')
          .update({'status': 'available'})
          .eq('driver_id', driverId);

      developer.log('Driver $driverId marked as available');

      // Update charity's total_services count
      final charityResponse = await _client
          .from('charity')
          .select('total_services')
          .eq('charity_id', charityId)
          .single();

      final currentCharityTotal =
          (charityResponse['total_services'] ?? 0) as int;

      await _client
          .from('charity')
          .update({'total_services': currentCharityTotal + 1})
          .eq('charity_id', charityId);

      developer.log(
        'Charity total_services updated to ${currentCharityTotal + 1}',
      );
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

  // Mark request as started and update driver status to 'on trip'
  Future<void> markRequestStarted(String requestId) async {
    try {
      final request = await _client
          .from('requests')
          .select('driver_id')
          .eq('request_id', requestId)
          .single();

      final driverId = request['driver_id'];
      if (driverId == null)
        throw Exception('No driver found for request $requestId');

      await _client
          .from('driver')
          .update({'status': 'on trip'})
          .eq('driver_id', driverId);

      developer.log('Driver $driverId marked as on trip');
    } catch (e) {
      developer.log('markRequestStarted failed');
      throw Exception('Failed to start trip for request $requestId');
    }
  }
}
