import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hicons/flutter_hicons.dart';
import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permata_architect_mobile_apps/repository/res/color_libraries.dart';
import 'package:permata_architect_mobile_apps/repository/res/font_style.dart';
import 'package:path/path.dart' as path;

Widget textFieldForm(
    {TextEditingController? controller,
    String? text,
    String? header,
    List<TextInputFormatter>? inputFormatters,
    TextInputType? keyboardType}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "$header",
        style: headerTextField.copyWith(fontSize: 18),
      ),
      const SizedBox(
        height: 8,
      ),
      TextFormField(
        controller: controller,
        enableSuggestions: true,
        autocorrect: true,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Form wajib diisi';
          }
          return null;
        },
        cursorColor: ListColor.primary,
        inputFormatters: inputFormatters,
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
        height: 20,
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
        height: 8,
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

Widget uploadImages(
    {String? header,
    String? text,
    VoidCallback? onPressed,
    File? imageFile,
    VoidCallback? onDelete}) {
  String fileName =
      imageFile != null ? path.basename(imageFile.path) : 'Tidak ada file';
  String fileSize = imageFile != null
      ? '${(imageFile.lengthSync() / 1024).toStringAsFixed(2)} KB'
      : 'Ukuran tidak diketahui';

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "$header",
        style: headerTextField.copyWith(fontSize: 18),
      ),
      const SizedBox(
        height: 8,
      ),
      imageFile == null
          ? DottedBorder(
              borderType: BorderType.RRect,
              radius: const Radius.circular(8),
              dashPattern: [6, 5],
              color: ListColor.gray300,
              borderPadding: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(6),
              strokeCap: StrokeCap.round,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: InkWell(
                  onTap: onPressed,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    width: double.infinity,
                    color: ListColor.gray100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Hicons.document_upload_4_bold,
                          color: ListColor.gray400,
                          size: 24,
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          "$text",
                          style: headerTextField.copyWith(fontSize: 18),
                        ),
                        SizedBox(height: 2.h),
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
            )
          : Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                border: Border.all(color: ListColor.gray300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      border: Border.all(color: ListColor.gray200),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(imageFile, fit: BoxFit.cover),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          fileName,
                          style: regularFont.copyWith(fontSize: 16.sp),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Text(
                          fileSize,
                          style: subHeaderFont.copyWith(fontSize: 13.sp),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16.w),
                  InkWell(
                    onTap: onDelete,
                    child: Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: ShapeDecoration(
                        color: ListColor.gray200,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      child: SvgPicture.asset(
                        'assets/icons/delete.svg',
                        width: 20.w,
                        height: 20.h,
                        color: ListColor.gray400,
                      ),
                    ),
                  ),
                ],
              ))
    ],
  );
}
