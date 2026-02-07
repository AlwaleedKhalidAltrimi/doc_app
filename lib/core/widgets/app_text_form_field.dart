import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_colors.dart';
import '../utils/app_styles.dart';

class AppTextFormField extends StatelessWidget {
  final String hintText;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final bool? isObscureText;
  final Widget? suffixIcon;
  final Color? backgroundColor;
  final TextEditingController? controller;
  final Function(String?) validator;
  final TextInputType keyboardType;

  const AppTextFormField({
    super.key,
    required this.hintText,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.inputTextStyle,
    this.hintStyle,
    this.isObscureText,
    this.suffixIcon,
    this.backgroundColor,
    this.controller,
    required this.validator,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isObscureText ?? false,
      keyboardType: keyboardType,
      validator: (value) {
        return validator(value);
      },
      cursorColor: AppColors.primaryColor,
      style: inputTextStyle ?? AppStyles.font14DarkBlueMedium,
      decoration: _buildInputDecoration(),
    );
  }

  InputDecoration _buildInputDecoration() {
    final defaultBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: AppColors.lighterGray, width: 1.3),
    );
    final errorBorderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: Colors.red, width: 1.3),
    );

    return InputDecoration(
      isDense: true,
      filled: true,
      fillColor: backgroundColor ?? AppColors.moreLightGray,
      hintText: hintText,
      hintStyle: hintStyle ?? AppStyles.font14LightGrayRegular,
      suffixIcon: suffixIcon,
      contentPadding:
          contentPadding ??
          EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
      enabledBorder: enabledBorder ?? defaultBorder,
      focusedBorder:
          focusedBorder ??
          defaultBorder.copyWith(
            borderSide: BorderSide(color: AppColors.primaryColor, width: 1.3),
          ),
      errorBorder: errorBorderStyle,
      focusedErrorBorder: errorBorderStyle,
    );
  }
}
