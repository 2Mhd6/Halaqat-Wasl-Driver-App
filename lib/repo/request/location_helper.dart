import 'dart:async';
import 'dart:developer' as developer;
import 'package:geocoding/geocoding.dart';

class LocationHelper {
  static const int _maxRetries = 2; // Number of retry attempts for geocoding

  // Converts latitude and longitude to a human-readable location name
  static Future<String> getLocationName(double? lat, double? lng) async {
    if (lat == null || lng == null) return 'Location not specified';

    for (int attempt = 1; attempt <= _maxRetries; attempt++) {
      try {
        // Try to get placemarks using coordinates
        final placemarks = await placemarkFromCoordinates(lat, lng);
        return placemarks.firstOrNull?.toReadableString() ??
            _formatCoordinates(lat, lng);
      } catch (_) {
        // On final failure, return raw coordinates
        if (attempt == _maxRetries) {
          developer.log('Geocoding failed after $_maxRetries attempts');
          return _formatCoordinates(lat, lng);
        }
        // Wait before retrying
        await Future.delayed(const Duration(milliseconds: 500));
      }
    }

    return _formatCoordinates(lat, lng);
  }

  // Formats coordinates as a fallback string
  static String _formatCoordinates(double lat, double lng) =>
      '${lat.toStringAsFixed(5)}, ${lng.toStringAsFixed(5)}';
}

// Extension to convert Placemark to a readable string like "City, Area"
extension PlacemarkExtensions on Placemark {
  String toReadableString() =>
      [locality, subLocality].where((e) => e?.isNotEmpty ?? false).join(', ');
}
