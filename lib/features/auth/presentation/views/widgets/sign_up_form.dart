import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/helper/app_regex.dart';
import '../../../../../core/helper/spacing.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/widgets/app_drop_down_form_field.dart';
import '../../../../../core/widgets/app_text_form_field.dart';
import '../../providers/sign_up_provider.dart';
import 'password_validations.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SignupProvider>(
      builder: (context, signupProvider, child) {
        return Form(
          key: signupProvider.formKey,
          child: Column(
            children: [
              // Name Field
              AppTextFormField(
                hintText: 'Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid name';
                  }
                },
                controller: signupProvider.nameController,
              ),
              verticalSpace(18),

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
                controller: signupProvider.emailController,
              ),
              verticalSpace(18),

              // Phone Field
              AppTextFormField(
                hintText: 'Phone number',
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      !AppRegex.isPhoneNumberValid(value)) {
                    return 'Please enter a valid phone number';
                  }
                },
                controller: signupProvider.phoneController,
              ),
              verticalSpace(18),

              // Password Field
              AppTextFormField(
                controller: signupProvider.passwordController,
                hintText: 'Password',
                isObscureText: signupProvider.isObscureText,
                suffixIcon: TextButton(
                  onPressed: () {
                    signupProvider.togglePasswordVisibility();
                  },
                  child: Icon(
                    color: AppColors.black,
                    signupProvider.isObscureText
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
              verticalSpace(18),

              // Password Confirmation Field
              AppTextFormField(
                controller: signupProvider.passwordConfirmationController,
                hintText: 'Password Confirmation',
                isObscureText: signupProvider.isObscureText,
                suffixIcon: TextButton(
                  onPressed: () {
                    signupProvider.togglePasswordVisibility();
                  },
                  child: Icon(
                    color: AppColors.black,
                    signupProvider.isObscureText
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid password';
                  }
                  if (value != signupProvider.passwordController.text) {
                    return "The password confirmation does not match";
                  }
                  return null;
                },
              ),
              verticalSpace(24),
              PasswordValidations(
                hasLowerCase: signupProvider.hasLowercase,
                hasUpperCase: signupProvider.hasUppercase,
                hasSpecialCharacters: signupProvider.hasSpecialCharacters,
                hasNumber: signupProvider.hasNumber,
                hasMinLength: signupProvider.hasMinLength,
              ),
              verticalSpace(18),

              // Gender Selection
              AppDropdownFormField<int>(
                hintText: 'Gender',

                value: signupProvider.selectedGender == 0
                    ? null
                    : signupProvider.selectedGender,
                items: const [
                  DropdownMenuItem(value: 1, child: Text('Male')),
                  DropdownMenuItem(value: 2, child: Text('Female')),
                ],
                onChanged: (value) {
                  signupProvider.selectGender(value!);
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select your gender';
                  }
                  return null;
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
