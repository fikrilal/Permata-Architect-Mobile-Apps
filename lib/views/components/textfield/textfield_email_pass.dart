import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../repository/res/color_libraries.dart';

Widget PrimaryTextfield(
    String text,
    String svgIconPath,
    bool isPasswordType,
    TextEditingController controller,
    Color iconColor) {
  return TextFormField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: ListColor.primary,
    style: const TextStyle(
      fontFamily: 'Satoshi',
      fontWeight: FontWeight.w500,
      fontSize: 18,
      color: ListColor.gray700, // Warna teks dalam TextField
    ),
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.all(
          18.0
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(60),
        borderSide: const BorderSide(
          color: ListColor.gray200,
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(60),
        borderSide: const BorderSide(
          color: ListColor.primary,
          width: 1,
        ),
      ),
      prefixIcon: Container(
        width: 54, // Atur lebar Container sesuai kebutuhan
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 18.0), // Sesuaikan jarak di sisi kiri di sini
          child: SvgPicture.asset(
            width: 25.0,
            height: 25.0,
            fit: BoxFit.fill,
            svgIconPath,
            color: iconColor,
          ),
        ),
      ),
      labelText: text,
      labelStyle: const TextStyle(
        fontFamily: 'Satoshi',
        fontWeight: FontWeight.w500,
        fontSize: 18,
        color: ListColor.gray500,
      ),
      filled: false,
      floatingLabelBehavior: FloatingLabelBehavior.never,
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}