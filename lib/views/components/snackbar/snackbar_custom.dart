import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../repository/res/color_libraries.dart';
import '../text/description.dart';

class CustomSnackbar {
  static void showSuccessSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        content: Container(
          padding: EdgeInsets.all(16.w),
          decoration: ShapeDecoration(
            color: const Color(0x3D419681),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/icons/success.svg',
                width: 32.w,
                height: 32.h,
                color: ListColor.primary,
              ),
              SizedBox(width: 10.w),
              TextDescriptionPrimary(message),
            ],
          ),
        ),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.transparent,
      ),
    );
  }

  static void showFailedSnackbar(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        content: Container(
          padding: EdgeInsets.all(16.w),
          margin: EdgeInsets.only(bottom: 40.h),
          decoration: ShapeDecoration(
            color: const Color(0x3DEB5757),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/icons/failed.svg',
                width: 32.w,
                height: 32.h,
                color: ListColor.red,
              ),
              SizedBox(width: 10.w),
              TextDescriptionWarning(error),
            ],
          ),
        ),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
