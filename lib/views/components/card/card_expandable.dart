import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../text/description.dart';
import '../text/header.dart';

class ExpandableCard extends StatelessWidget {
  final String description;
  final String amount;

  ExpandableCard({required this.description, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: Color(0xFFE5E7EB)),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextDescriptionSmall(description),
          SizedBox(height: 16.h),
          TextPoint(amount),
        ],
      ),
    );
  }
}