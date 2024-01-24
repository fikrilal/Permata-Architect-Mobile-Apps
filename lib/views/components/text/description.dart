import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../repository/res/color_libraries.dart';

class TextDescriptionMain extends StatelessWidget {
  final String? text;

  TextDescriptionMain(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      "${text}",
      style:  TextStyle(
        fontFamily: 'Satoshi',
        fontSize: 18.sp,
        color: ListColor.gray700,
        fontWeight: FontWeight.w500,
        height: 0
      ),
    );
  }
}

class TextDescriptionSmall extends StatelessWidget {
  final String? text;

  TextDescriptionSmall(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      "${text}",
      style:  TextStyle(
          fontFamily: 'Satoshi',
          fontSize: 16.sp,
          color: ListColor.gray400,
          fontWeight: FontWeight.w500,
          height: 0
      ),
    );
  }
}