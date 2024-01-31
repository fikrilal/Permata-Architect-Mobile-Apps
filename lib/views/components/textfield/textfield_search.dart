import 'package:flutter/material.dart';
import 'package:flutter_hicons/flutter_hicons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permata_architect_mobile_apps/repository/res/color_libraries.dart';

class TextFieldSearchWidget extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? text;
  final Function(String)? onSubmiited;
  final Function(String)? onChanged;

  const TextFieldSearchWidget(
      {Key? key,
      this.controller,
      this.keyboardType,
      this.text,
      this.onSubmiited,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: TextFormField(
        controller: controller,
        enableSuggestions: true,
        autocorrect: true,
        onFieldSubmitted: onSubmiited,
        onChanged: onChanged,
        cursorColor: ListColor.primary,
        style: const TextStyle(
          fontFamily: 'Satoshi',
          fontWeight: FontWeight.w500,
          fontSize: 18,
          color: ListColor.gray700,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(16.w),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: ListColor.gray200,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: ListColor.primary,
              width: 1,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: ListColor.primary,
              width: 1,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.redAccent,
              width: 1,
            ),
          ),
          labelText: text,
          prefixIcon: Container(
            width: 54,
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 16.w),
              child: const Icon(Hicons.search_2_light_outline),
            ),
          ),
          labelStyle: const TextStyle(
            fontFamily: 'Satoshi',
            fontWeight: FontWeight.w500,
            fontSize: 18,
            color: ListColor.gray500,
          ),
          filled: false,
          floatingLabelBehavior: FloatingLabelBehavior.never,
        ),
        keyboardType: keyboardType,
      ),
    );
  }
}
