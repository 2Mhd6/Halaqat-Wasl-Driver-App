import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:halaqat_wasl_driver_app/theme/app_color.dart';
import 'package:halaqat_wasl_driver_app/theme/app_text_style.dart';
import 'package:halaqat_wasl_driver_app/ui/login/login_screen.dart';

class CustomHeader extends StatelessWidget {
  final String name;

  const CustomHeader({super.key, required this.name});

  void _toggleLanguage(BuildContext context) {
    final currentLocale = context.locale;
    if (currentLocale.languageCode == 'en') {
      context.setLocale(const Locale('ar'));
    } else {
      context.setLocale(const Locale('en'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          tr('dashboard.hello', namedArgs: {'name': name}),
          style: AppTextStyle.sfProW60016,
        ),

        Row(
          children: [
            // Language toggle button
            IconButton(
              icon: Icon(Icons.language, color: AppColor.primaryButtonColor),
              tooltip: tr('Change Language'),
              onPressed: () => _toggleLanguage(context),
            ),

            // Logout button
            IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LogInScreen()),
                );
              },
              icon: Icon(Icons.logout, color: AppColor.logoutButtonColor),
            ),
          ],
        ),
      ],
    );
  }
}
