import 'dart:developer' as developer;
import 'package:halaqat_wasl_driver_app/model/request%20model/request_model.dart';
import 'package:halaqat_wasl_driver_app/repo/request/location_helper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RequestProcessor {
  // Enrich each request with full user and hospital data from DB
  static Future<List<Map<String, dynamic>>> enrichRequests(
    List<Map<String, dynamic>> requests,
    SupabaseClient client,
  ) async {
    return await Future.wait(
      requests.map((request) async {
        final userId = request['user_id'] as String?;
        final hospitalId = request['hospital_id'] as String?;

        Map<String, dynamic>? user;
        if (userId != null) {
          // Fetch user details by userId
          user = await client
              .from('users')
              .select('user_id, notification_id, full_name, role, email, phone_number, gender')
              .eq('user_id', userId)
              .single()
              .maybeSingle();
        }

        Map<String, dynamic>? hospital;
        if (hospitalId != null) {
          // Fetch hospital details by hospitalId
          hospital = await client
              .from('hospital')
              .select('hospital_id, hospital_name, hospital_lat, hospital_long')
              .eq('hospital_id', hospitalId)
              .single()
              .maybeSingle();
        }

        // Return request with added user and hospital info
        return {
          ...request,
          'user': user,
          'hospital': hospital,
        };
      }),
    );
  }

  // Process enriched requests into RequestModel instances with resolved location names
  static Future<List<RequestModel>> processRequests(
    List<Map<String, dynamic>> requests,
  ) async {
    final results = <RequestModel>[];

    for (final request in requests) {
      try {
        final userData = request['user'] as Map<String, dynamic>?;
        final hospitalData = request['hospital'] as Map<String, dynamic>?;

        // Resolve pickup location name from coordinates
        final pickupName = await LocationHelper.getLocationName(
          (request['pick_up_lat'] as num?)?.toDouble(),
          (request['pick_up_long'] as num?)?.toDouble(),
        );

        // Resolve destination location name from coordinates
        final destinationName = await LocationHelper.getLocationName(
          (request['destination_lat'] as num?)?.toDouble(),
          (request['destination_long'] as num?)?.toDouble(),
        );

        // Build RequestModel instance from enriched data
        results.add(
          RequestModel.fromSupabase({
            ...request,
            'user': userData != null
                ? {
                    'user_id': request['user_id'].toString(),
                    'notification_id': userData['notification_id'],
                    'full_name': userData['full_name'] ?? '',
                    'role': userData['role'] ?? 'user',
                    'email': userData['email'] ?? '',
                    'phone_number': userData['phone_number'] ?? '',
                    'gender': userData['gender'] ?? 'unknown',
                  }
                : null,
            'hospital': hospitalData != null
                ? {
                    'hospital_id': request['hospital_id'],
                    'name': hospitalData['hospital_name'] ?? 'Unknown Hospital',
                    'hospital_lat': hospitalData['hospital_lat'] ?? 0.0,
                    'hospital_long': hospitalData['hospital_long'] ?? 0.0,
                  }
                : null,
            'pickup_name': pickupName,
            'destination_name': destinationName,
          }),
        );
      } catch (e, stack) {
        developer.log(
          'Failed to process request ${request['request_id']}',
          error: e,
          stackTrace: stack,
        );
      }
    }

    return results;
  }
}
