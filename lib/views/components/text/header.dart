import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../repository/res/color_libraries.dart';

class ComponentTextAppBar extends StatelessWidget {
  final String? text;

  ComponentTextAppBar(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      "${text}",
      style:  TextStyle(
        fontFamily: 'Satoshi',
        fontSize: 16.sp,
        color: ListColor.gray700,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class TextPoint extends StatelessWidget {
  final String? text;

  TextPoint(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      "${text}",
      style:  TextStyle(
        fontFamily: 'Satoshi',
        fontSize: 22.sp,
        color: ListColor.gray700,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}