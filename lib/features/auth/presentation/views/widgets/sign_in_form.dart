import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/helper/app_regex.dart';
import '../../../../../core/helper/spacing.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/widgets/app_text_form_field.dart';
import '../../providers/log_in_provider.dart';
import 'password_validations.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, loginProvider, child) {
        return Form(
          key: loginProvider.formKey,
          child: Column(
            children: [
              // Email Field
              AppTextFormField(
                hintText: 'Email',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      !AppRegex.isEmailValid(value)) {
                    return 'Please enter a valid email';
                  }
                },
                controller: loginProvider.emailController,
              ),
              verticalSpace(18),

              // Password Field
              AppTextFormField(
                controller: loginProvider.passwordController,
                hintText: 'Password',
                isObscureText: loginProvider.isObscureText,
                suffixIcon: TextButton(
                  onPressed: () {
                    loginProvider.togglePasswordVisibility();
                  },
                  child: Icon(
                    color: AppColors.black,
                    loginProvider.isObscureText
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid password';
                  }
                },
              ),
              verticalSpace(24),
              PasswordValidations(
                hasLowerCase: loginProvider.hasLowercase,
                hasUpperCase: loginProvider.hasUppercase,
                hasSpecialCharacters: loginProvider.hasSpecialCharacters,
                hasNumber: loginProvider.hasNumber,
                hasMinLength: loginProvider.hasMinLength,
              ),
            ],
          ),
        );
      },
    );
  }
}
