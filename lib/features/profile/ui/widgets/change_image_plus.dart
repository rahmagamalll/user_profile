import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_profile/core/theming/colors.dart';
import 'package:user_profile/core/theming/styles.dart';

class ChangeImagePlus extends StatelessWidget {
  const ChangeImagePlus({super.key, this.choosFromGalleyOnTap});

  final void Function()? choosFromGalleyOnTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: choosFromGalleyOnTap,
      child: CircleAvatar(
        backgroundColor: ColorsManager.primaryColor,
        radius: 15.r,
        child: Text(
          "+",
          style: TextStylesManager.font18Regular(context).copyWith(
          color: ColorsManager.white,
          ),
        ),
      ),
    );
  }
}
