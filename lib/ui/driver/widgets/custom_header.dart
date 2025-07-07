import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:halaqat_wasl_driver_app/repo/authentication/auth_gate_scree.dart';
import 'package:halaqat_wasl_driver_app/theme/app_color.dart';
import 'package:halaqat_wasl_driver_app/theme/app_text_style.dart';
import 'package:halaqat_wasl_driver_app/ui/driver/methods/language_method.dart';

class CustomHeader extends StatelessWidget {
  final String name;
  const CustomHeader({super.key, required this.name});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          tr('driver_screen.hello', namedArgs: {'name': name}),
          style: AppTextStyle.sfProW60016,
        ),
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.language_sharp),
              onPressed: () => LanguageMethod.toggleLanguage(context),
            ),
            IconButton(
              onPressed: () => AuthGateScreen.handleLogout(context),
              icon: Icon(Icons.logout, color: AppColor.logoutButtonColor),
            ),
          ],
        ),
      ],
    );
  }
}
