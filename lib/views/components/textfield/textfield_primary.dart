import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hicons/flutter_hicons.dart';
import 'package:permata_architect_mobile_apps/repository/res/color_libraries.dart';
import 'package:permata_architect_mobile_apps/repository/res/font_style.dart';

Widget textFieldForm(
    {TextEditingController? controller,
    String? text,
    String? header,
    TextInputType? keyboardType}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "$header",
        style: headerTextField.copyWith(fontSize: 18),
      ),
      const SizedBox(
        height: 5,
      ),
      TextFormField(
        controller: controller,
        enableSuggestions: true,
        autocorrect: true,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        cursorColor: ListColor.primary,
        style: const TextStyle(
          fontFamily: 'Satoshi',
          fontWeight: FontWeight.w500,
          fontSize: 18,
          color: ListColor.gray700, // Warna teks dalam TextField
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(18.0),
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
      const SizedBox(
        height: 10,
      )
    ],
  );
}

Widget textFieldFormParagraph(
    {TextEditingController? controller,
    String? text,
    String? header,
    TextInputType? keyboardType}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "$header",
        style: headerTextField.copyWith(fontSize: 18),
      ),
      const SizedBox(
        height: 5,
      ),
      TextFormField(
        controller: controller,
        enableSuggestions: true,
        autocorrect: true,
        // textInputAction: TextInputAction.none,
        maxLines: null,
        minLines: 3,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        cursorColor: ListColor.primary,
        style: const TextStyle(
          fontFamily: 'Satoshi',
          fontWeight: FontWeight.w500,
          fontSize: 18,
          color: ListColor.gray700, // Warna teks dalam TextField
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(18),
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
          alignLabelWithHint: true,
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
      const SizedBox(
        height: 10,
      )
    ],
  );
}

Widget uploadImages({String? header, String? text}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "$header",
        style: headerTextField.copyWith(fontSize: 18),
      ),
      const SizedBox(
        height: 5,
      ),
      DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(12),
        dashPattern: [6, 5],
        color: ListColor.gray300,
        borderPadding: const EdgeInsets.all(2),
        padding: const EdgeInsets.all(6),
        strokeCap: StrokeCap.round,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          child: Container(
            height: 112,
            width: double.infinity,
            color: ListColor.gray100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Hicons.document_upload_4_bold,
                  color: ListColor.gray400,
                ),
                Text(
                  "$text",
                  style: headerTextField.copyWith(fontSize: 18),
                ),
                Text(
                  "*JPG, JPEG, PNG",
                  style: regularFont.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: ListColor.gray500),
                )
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
