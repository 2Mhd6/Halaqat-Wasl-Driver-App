import 'dart:developer' as developer;
import 'package:halaqat_wasl_driver_app/model/request%20model/request_model.dart';
import 'package:halaqat_wasl_driver_app/repo/request/location_helper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RequestProcessor {
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
          user = await client
              .from('users')
              .select('user_id, notification_id, full_name, role, email, phone_number, gender')
              .eq('user_id', userId)
              .single()
              .maybeSingle();
        }

        Map<String, dynamic>? hospital;
        if (hospitalId != null) {
          hospital = await client
              .from('hospital')
              .select('hospital_id, hospital_name, hospital_lat, hospital_long')
              .eq('hospital_id', hospitalId)
              .single()
              .maybeSingle();
        }

        return {
          ...request,
          'user': user,
          'hospital': hospital,
        };
      }),
    );
  }

  static Future<List<RequestModel>> processRequests(
    List<Map<String, dynamic>> requests,
  ) async {
    final results = <RequestModel>[];

    for (final request in requests) {
      try {
        final userData = request['user'] as Map<String, dynamic>?;
        final hospitalData = request['hospital'] as Map<String, dynamic>?;

        final pickupName = await LocationHelper.getLocationName(
          (request['pick_up_lat'] as num?)?.toDouble(),
          (request['pick_up_long'] as num?)?.toDouble(),
        );

        final destinationName = await LocationHelper.getLocationName(
          (request['destination_lat'] as num?)?.toDouble(),
          (request['destination_long'] as num?)?.toDouble(),
        );

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
