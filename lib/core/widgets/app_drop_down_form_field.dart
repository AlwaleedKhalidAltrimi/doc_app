import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_colors.dart';
import '../utils/app_styles.dart';

class AppDropdownFormField<T> extends StatelessWidget {
  final String hintText;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final Function(T?) onChanged;
  final String? Function(T?) validator;
  final EdgeInsetsGeometry? contentPadding;

  const AppDropdownFormField({
    super.key,
    required this.hintText,
    required this.items,
    required this.onChanged,
    required this.validator,
    this.value,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      initialValue: value,
      items: items,
      onChanged: onChanged,
      validator: validator,
      icon: const Icon(Icons.keyboard_arrow_down),
      style: AppStyles.font14DarkBlueMedium,
      dropdownColor: AppColors.moreLightGray,
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
      borderSide: BorderSide(color: AppColors.red, width: 1.3),
    );

    return InputDecoration(
      isDense: true,
      filled: true,
      fillColor: AppColors.moreLightGray,

      hintText: hintText,
      hintStyle: AppStyles.font14LightGrayRegular,
      contentPadding:
          contentPadding ??
          EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
      enabledBorder: defaultBorder,
      focusedBorder: defaultBorder.copyWith(
        borderSide: BorderSide(color: AppColors.primaryColor, width: 1.3),
      ),
      errorBorder: errorBorderStyle,
      focusedErrorBorder: errorBorderStyle,
    );
  }
}
