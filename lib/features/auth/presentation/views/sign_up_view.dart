import 'package:doc_app/core/extension/navigation.dart';
import 'package:doc_app/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../core/helper/spacing.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../providers/sign_up_provider.dart';
import 'widgets/custom_have_an_account.dart';
import 'widgets/sign_up_form.dart';
import 'widgets/terms_and_conditions_text.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

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
                Text('Create Account', style: AppStyles.font24BlueBold),
                verticalSpace(8),
                Text(
                  'Sign up now and start exploring all that our app has to offer. We\'re excited to welcome you to our community!',
                  style: AppStyles.font14GrayRegular,
                ),
                verticalSpace(36),
                Column(
                  children: [
                    const SignUpForm(),
                    verticalSpace(40),
                    Consumer<SignupProvider>(
                      builder: (context, signupProvider, child) {
                        if (signupProvider.isLoading) {
                          return CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          );
                        }
                        return CustomButton(
                          text: 'Create Account',
                          onPressed: () {
                            signupProvider.signup(context);
                          },
                        );
                      },
                    ),
                    verticalSpace(16),
                    const TermsAndConditionsText(),
                    verticalSpace(30),
                    CustomHaveAnAccount(
                      promptText: 'Already have an account?',
                      linkText: 'Sign In',
                      onTap: () {
                        context.pushReplacementNamed(Routes.logInView);
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
