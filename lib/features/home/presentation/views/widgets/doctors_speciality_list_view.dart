import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/helper/spacing.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_images.dart';
import '../../../../../core/utils/app_styles.dart';

class DoctorsSpecialityListView extends StatelessWidget {
  const DoctorsSpecialityListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 8,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsetsDirectional.only(start: index == 0 ? 0 : 24.w),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: AppColors.lightBlue,
                  child: SvgPicture.asset(
                    AppImages.imagesSvgGeneralSpeciality,
                    height: 40.h,
                    width: 40.w,
                  ),
                ),
                verticalSpace(8),
                Text('Alwaleed', style: AppStyles.font12DarkBlueRegular),
              ],
            ),
          );
        },
      ),
    );
  }
}
