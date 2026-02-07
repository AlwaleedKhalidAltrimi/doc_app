import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/app_styles.dart';

class CustomHaveAnAccount extends StatelessWidget {
  final String promptText, linkText;
  final VoidCallback onTap;

  const CustomHaveAnAccount({
    super.key,
    required this.promptText,
    required this.linkText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(text: promptText, style: AppStyles.font13DarkBlueRegular),
          const WidgetSpan(child: SizedBox(width: 3)),
          TextSpan(
            text: linkText,
            style: AppStyles.font13BlueSemiBold,
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }
}
