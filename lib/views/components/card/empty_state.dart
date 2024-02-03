import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permata_architect_mobile_apps/repository/res/font_style.dart';

Widget buildEmptyState(String emptyText) {
  return Center(
    child: Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/empty-state.svg',
            // Change this path based on your actual asset path
            width: 150.w,
            height: 150.h,
          ),
          Text(
            emptyText,
            style: subHeaderFont.copyWith(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}
