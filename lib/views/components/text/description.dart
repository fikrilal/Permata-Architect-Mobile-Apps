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
      style: TextStyle(
          fontFamily: 'Satoshi',
          fontSize: 18.sp,
          color: ListColor.gray700,
          fontWeight: FontWeight.w500,
          height: 0),
    );
  }
}

class TextDescriptionPrimary extends StatelessWidget {
  final String? text;

  TextDescriptionPrimary(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      "${text}",
      style: TextStyle(
          fontFamily: 'Satoshi',
          fontSize: 18.sp,
          color: ListColor.primary,
          fontWeight: FontWeight.w500,
          height: 0,
          overflow: TextOverflow.ellipsis),
      maxLines: 1,
    );
  }
}

class TextDescriptionWarning extends StatelessWidget {
  final String? text;

  TextDescriptionWarning(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      "${text}",
      style: TextStyle(
          fontFamily: 'Satoshi',
          fontSize: 18.sp,
          color: ListColor.red,
          fontWeight: FontWeight.w500,
          height: 0,
          overflow: TextOverflow.ellipsis),
      maxLines: 1,
    );
  }
}

class TextDescriptionMainOver extends StatelessWidget {
  final String? text;

  TextDescriptionMainOver(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      "${text}",
      style: TextStyle(
          fontFamily: 'Satoshi',
          fontSize: 18.sp,
          color: ListColor.gray700,
          fontWeight: FontWeight.w500,
          height: 0,
          overflow: TextOverflow.ellipsis),
      maxLines: 1,
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
      style: TextStyle(
          fontFamily: 'Satoshi',
          fontSize: 16.sp,
          color: ListColor.gray400,
          fontWeight: FontWeight.w500,
          height: 0),
    );
  }
}
