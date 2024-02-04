import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget primaryButton({
  required String text,
  required VoidCallback onPressed,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF419681),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      minimumSize: Size(double.infinity, 0),
      padding: EdgeInsets.symmetric(vertical: 16.h),
      elevation: 0,
    ),
    child: Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 18.sp,
        fontFamily: 'Satoshi',
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
