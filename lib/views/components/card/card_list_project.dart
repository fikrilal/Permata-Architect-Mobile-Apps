import 'package:flutter/material.dart';
import 'package:flutter_hicons/flutter_hicons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permata_architect_mobile_apps/repository/res/font_style.dart';

import '../../../repository/res/color_libraries.dart';

class CardListProject extends StatelessWidget {
  final String? lokasi;
  final String? alamat;
  final String? pemilik;
  final String? status;

  const CardListProject({
    Key? key,
    this.lokasi,
    this.alamat,
    this.pemilik,
    this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: ListView.builder(
        itemCount: 15,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: ListColor.gray200),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$lokasi",
                    style: headerFontMenu.copyWith(fontSize: 20),
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Icon(Hicons.location_light_outline,
                          size: 20.w, color: ListColor.gray500),
                      SizedBox(width: 10.w),
                      Text(
                        "$alamat",
                        style: subHeaderFont.copyWith(fontSize: 18),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Icon(Hicons.profile_1_light_outline,
                          size: 20.w, color: ListColor.gray500),
                      SizedBox(width: 10.w),
                      Text(
                        "$pemilik",
                        style: subHeaderFont.copyWith(fontSize: 18),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  IntrinsicWidth(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10.w, 4.h, 10.w, 4.h),
                      decoration: ShapeDecoration(
                        color: const Color(0x19419681),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Hicons.time_circle_1_bold,
                              size: 16.w, color: ListColor.primary),
                          SizedBox(width: 10.w),
                          Text(
                            "$status",
                            style: textGreen.copyWith(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
