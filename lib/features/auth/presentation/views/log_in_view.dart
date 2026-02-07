import 'package:doc_app/core/extension/navigation.dart';
import 'package:doc_app/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../core/helper/spacing.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../providers/log_in_provider.dart';
import 'widgets/custom_have_an_account.dart';
import 'widgets/sign_in_form.dart';
import 'widgets/terms_and_conditions_text.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Welcome Back', style: AppStyles.font24BlueBold),
                verticalSpace(8),
                Text(
                  'We\'re excited to have you back, can\'t wait to see what you\'ve been up to since you last logged in.',
                  style: AppStyles.font14GrayRegular,
                ),
                verticalSpace(36),
                Column(
                  children: [
                    const SignInForm(),
                    verticalSpace(24),
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Text(
                        'Forgot Password?',
                        style: AppStyles.font13BlueRegular,
                      ),
                    ),
                    verticalSpace(40),
                    Consumer<LoginProvider>(
                      builder: (context, loginProvider, child) {
                        if (loginProvider.isLoading) {
                          return CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          );
                        }
                        return CustomButton(
                          text: 'Login',
                          onPressed: () {
                            loginProvider.login(context);
                          },
                        );
                      },
                    ),
                    verticalSpace(16),
                    const TermsAndConditionsText(),
                    verticalSpace(60),
                    CustomHaveAnAccount(
                      promptText: 'Don\'t have an account?',
                      linkText: 'Sign Up',
                      onTap: () {
                        context.pushReplacementNamed(Routes.signUpView);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
