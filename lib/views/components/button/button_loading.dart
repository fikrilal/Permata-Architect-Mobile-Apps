import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget loadingButton({String? text}) {
  return ElevatedButton(
    onPressed: () {},
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF419681),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      minimumSize: Size(double.infinity, 0),
      padding: EdgeInsets.symmetric(vertical: 16.h),
      elevation: 0,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            width: 20.w,
            height: 20.h,
            child: const CircularProgressIndicator(
                strokeWidth: 2.0,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white))),
        SizedBox(
          width: 10.w,
        ),
        Text(
          text!,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontFamily: 'Satoshi',
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}
