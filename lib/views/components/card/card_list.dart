import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../repository/res/color_libraries.dart';
import '../text/description.dart';

class CardList extends StatelessWidget {
  final String iconPath;
  final String title;
  final Function()? onTap;

  CardList({
    required this.iconPath,
    required this.title,
    this.onTap,
  });

  static const String arrowIconPath = 'assets/icons/arrow-right.svg';

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1, color: ListColor.gray200),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 24.h, 0, 24.h),
          child: Row(
            children: [
              SvgPicture.asset(
                iconPath,
                width: 24.w,
                height: 24.h,
                color: ListColor.gray700,
              ),
              SizedBox(width: 16.w),
              TextDescriptionMain(title),
              Spacer(),
              SvgPicture.asset(
                arrowIconPath,
                width: 24.w,
                height: 24.h,
                color: ListColor.gray700,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
