import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_profile/core/theming/colors.dart';
import 'package:user_profile/core/theming/styles.dart';


class TopAppBar extends StatelessWidget {
  const TopAppBar({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Container(
              width: 35.w,
              height: 35.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorsManager.primaryColor,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 11.h, horizontal: 14.w),
                child: Image.asset(
                  'assets/images/arrow_back_icon.png',
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Text(
          title,
          style: TextStylesManager.font18Regular(context),
        ),
        SizedBox(
          width: 35.w,
          height: 33.h,
        ),
      ],
    );
  }
}
