import 'dart:async';
import 'dart:developer' as developer;
import 'package:geocoding/geocoding.dart';

class LocationHelper {
  static const int _maxRetries = 2;
  static const Duration _timeout = Duration(seconds: 5);

  static Future<String> getLocationName(double? lat, double? lng) async {
    if (lat == null || lng == null) return 'Location not specified';

    for (int attempt = 1; attempt <= _maxRetries; attempt++) {
      try {
        final placemarks = await placemarkFromCoordinates(lat, lng)
            .timeout(_timeout);
        return placemarks.firstOrNull?.toReadableString() ??
            _formatCoordinates(lat, lng);
      } catch (_) {
        if (attempt == _maxRetries) {
          developer.log('Geocoding failed after $_maxRetries attempts');
          return _formatCoordinates(lat, lng);
        }
        await Future.delayed(const Duration(milliseconds: 500));
      }
    }
    return _formatCoordinates(lat, lng);
  }

  static String _formatCoordinates(double lat, double lng) =>
      '${lat.toStringAsFixed(5)}, ${lng.toStringAsFixed(5)}';
}

extension PlacemarkExtensions on Placemark {
  String toReadableString() =>
      [locality, subLocality].where((e) => e?.isNotEmpty ?? false).join(', ');
}
