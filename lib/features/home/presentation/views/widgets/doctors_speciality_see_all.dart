import 'package:flutter/material.dart';
import '../../../../../core/utils/app_styles.dart';

class DoctorsSpecialitySeeAll extends StatelessWidget {
  const DoctorsSpecialitySeeAll({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Doctors Speciality', style: AppStyles.font18DarkBlueSemiBold),
        const Spacer(),
        Text('See All', style: AppStyles.font12BlueRegular),
      ],
    );
  }
}
