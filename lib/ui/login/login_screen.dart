import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halaqat_wasl_driver_app/extensions/screen_size.dart';
import 'package:halaqat_wasl_driver_app/repo/authentication/authentication.dart';
import 'package:halaqat_wasl_driver_app/shared/widgets/gap.dart';
import 'package:halaqat_wasl_driver_app/theme/app_color.dart';
import 'package:halaqat_wasl_driver_app/theme/app_text_style.dart';
import 'package:halaqat_wasl_driver_app/ui/driver/driver_screen.dart';
import 'package:halaqat_wasl_driver_app/ui/login/bloc/login_bloc.dart';
import 'package:halaqat_wasl_driver_app/ui/login/bloc/login_event.dart';
import 'package:halaqat_wasl_driver_app/ui/login/bloc/login_state.dart';
import 'package:halaqat_wasl_driver_app/ui/login/widgets/custom_button.dart';
import 'package:halaqat_wasl_driver_app/ui/login/widgets/custom_snackBar.dart';
import 'package:halaqat_wasl_driver_app/ui/login/widgets/custom_text_Field.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailFocus = FocusNode();
    final passwordFocus = FocusNode();
    return BlocProvider(
      create: (_) => LoginBloc(Authentication()),
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.message != null) {
            CustomSnackBar.show(
              // show feedback
              context: context,
              message: state.message!,
              isSuccess: state.success,
            );
            if (state.success) {
              Future.delayed(const Duration(seconds: 2), () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const DriverScreen(),
                  ), // navigate on success
                );
              });
            }
          }
        },
        builder: (context, state) {
          final bloc = context.read<LoginBloc>();
          return Scaffold(
            backgroundColor: AppColor.appBackgroundLoginColor,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Gap.gapH32,
                    Image.asset(
                      'assets/image/logo-halaqat-wasl.png',
                      height: 70,
                      width: 150,
                    ), // logo
                    Gap.gapH24,
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 24,
                      ),
                      width: context.getWidth(),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tr('log_in_screen.login'),
                            style: AppTextStyle.sfProBold36,
                          ), // title
                          Gap.gapH24,
                          Form(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextField(
                                  focusNode: emailFocus,
                                  label: tr('log_in_screen.email'),
                                  controller: bloc.emailController,
                                ),
                                Gap.gapH16,
                                CustomTextField(
                                  focusNode: passwordFocus,
                                  label: tr('log_in_screen.password'),
                                  controller: bloc.passwordController,
                                  isPassword: true,
                                ),
                              ],
                            ),
                          ),
                          Gap.gapH250,
                          CustomButton(
                            label: tr('log_in_screen.log_in'),
                            width: context.getWidth(),
                            height: context.getHeight(multiplied: 0.055),
                            onPressed: () => context.read<LoginBloc>().add(
                                    LoginSubmitted(),
                                  ),
                            color: AppColor.primaryButtonColor,
                            textColor: AppColor.textWhite,
                            isLoading: state.loading,
                          ),
                          Gap.gapH24,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
