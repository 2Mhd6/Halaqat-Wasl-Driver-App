import 'package:flutter/material.dart';
import 'package:halaqat_wasl_driver_app/shared/widgets/gap.dart';
import 'package:halaqat_wasl_driver_app/theme/app_color.dart';
import 'package:halaqat_wasl_driver_app/theme/app_text_style.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    this.isPassword = false,
    this.focusNode,
    this.passwordVisibleNotifier,
  });

  final String label;
  final TextEditingController controller;
  final bool isPassword;
  final FocusNode? focusNode;
  final ValueNotifier<bool>? passwordVisibleNotifier;

  @override
  Widget build(BuildContext context) {
    final borderColor = (focusNode?.hasFocus ?? false)
        ? AppColor.primaryButtonColor
        : AppColor.borderTextColor;

    // Listen to focus changes to rebuild when focus changes
    if (focusNode != null) {
      focusNode!.addListener(() {
        // ignore: invalid_use_of_protected_member
        (context as Element).markNeedsBuild();
      });
    }

    final ValueNotifier<bool> visibilityNotifier =
        passwordVisibleNotifier ?? ValueNotifier(false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyle.sfProW60014),
        Gap.gapH8,
        Container(
          decoration: BoxDecoration(
            color: AppColor.textWhite,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderColor, width: 2),
            boxShadow: [
              BoxShadow(
                color: AppColor.boxBorder,
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: SizedBox(
            height: 40,
            width: double.infinity,
            child: ValueListenableBuilder<bool>(
              valueListenable: visibilityNotifier,
              builder: (_, visible, __) {
                return TextField(
                  focusNode: focusNode,
                  controller: controller,
                  obscureText: isPassword ? !visible : false,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                    border: InputBorder.none,
                    suffixIcon: isPassword
                        ? IconButton(
                            splashRadius: 16,
                            icon: Icon(
                              visible ? Icons.visibility : Icons.visibility_off,
                              size: 20,
                              color: AppColor.thirdButtonColor,
                            ),
                            onPressed: () {
                              visibilityNotifier.value = !visible;
                            },
                          )
                        : null,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
