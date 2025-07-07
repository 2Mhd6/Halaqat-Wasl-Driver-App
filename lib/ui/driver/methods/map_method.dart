import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MapMethod {
  static Future<void> openMap(double lat, double long) async {
    final Uri geoUri = Uri.parse('geo:$lat,$long?q=$lat,$long');
    final Uri httpsUri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$lat,$long',
    );

    if (await canLaunchUrl(geoUri)) {
      await launchUrl(geoUri, mode: LaunchMode.externalApplication);
    } else if (await canLaunchUrl(httpsUri)) {
      await launchUrl(httpsUri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('❌ Could not open map. No Maps or Browser installed.');
    }
  }

  static Future<void> makePhoneCall(String phoneNumber) async {
    final cleanNumber = phoneNumber.replaceAll('+', '').replaceAll(' ', '');
    final url = 'tel:$cleanNumber';

    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      debugPrint('❌ Could not launch dialer for $phoneNumber');
    }
  }

  static Future<void> openWhatsApp(String phoneNumber) async {
    final cleanNumber = phoneNumber
        .toString()
        .replaceAll('+', '')
        .replaceAll(' ', '');
    final uri = Uri.parse('https://wa.me/$cleanNumber');

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('❌ Could not launch WhatsApp chat with $phoneNumber');
    }
  }
}
