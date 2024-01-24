import 'package:flutter/material.dart';
import 'package:flutter_hicons/flutter_hicons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permata_architect_mobile_apps/repository/res/color_libraries.dart';
import 'package:permata_architect_mobile_apps/repository/res/font_style.dart';
import 'package:permata_architect_mobile_apps/views/components/button/button_primary.dart';
import 'package:permata_architect_mobile_apps/views/components/textfield/textfield_primary.dart';

import '../../components/text/header.dart';

class ProjectKasbon extends StatefulWidget {
  const ProjectKasbon({super.key});

  @override
  State<ProjectKasbon> createState() => _ProjectKasbonState();
}

class _ProjectKasbonState extends State<ProjectKasbon> {
  final TextEditingController _controllerHarga = TextEditingController();
  final TextEditingController _controllerSearchName = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ListColor.gray500),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: ComponentTextAppBar("Kasbon"),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.h),
          child: Container(
            color: ListColor.gray200,
            height: 1.0,
          ),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 24.h, 0, 24.h),
          child: Column(children: [
            textFieldSearch(
                controller: _controllerSearchName,
                keyboardType: TextInputType.name,
                text: "Cari Pekerja.."),
            const SizedBox(
              height: 15,
            ),
            ListView.builder(
              itemCount: 20,
              shrinkWrap: true,
              controller: _scrollController,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return lisKasbon(
                    name: "Muhammad Al-kahfi", kasbonPrice: "28.000");
              },
            ),
          ]),
        ),
      )),
    );
  }

  Widget lisKasbon({String? name, String? kasbonPrice}) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            showAction();
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1, color: ListColor.gray200),
              ),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 0),
              title: Text(
                "$name",
                style: headerTextField.copyWith(fontSize: 20),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 4.h),
                  Text(
                    "Kasbon: Rp. $kasbonPrice",
                    style: subHeaderFont.copyWith(fontSize: 18),
                  ),
                ],
              ),
              trailing: SvgPicture.asset(
                'assets/icons/arrow-right.svg',
                width: 24.w,
                height: 24.h,
                color: ListColor.gray700,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget textFieldSearch(
      {TextEditingController? controller,
      TextInputType? keyboardType,
      String? text}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: TextFormField(
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

  void showAction() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return IntrinsicHeight(
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 20.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 40.w,
                        height: 3.h,
                        decoration: BoxDecoration(
                          color: ListColor.gray200,
                          borderRadius: BorderRadius.circular(200),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Text(
                    'Kurangi Kasbon',
                    style: headerFontMenu.copyWith(fontSize: 24),
                  ),
                  Text(
                    "Kurangi nominal kasbon untuk Mohammad Al-Kahfi",
                    style: subHeaderFont.copyWith(fontSize: 18),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  textFieldForm(
                    controller: _controllerHarga,
                    text: "Rp. ",
                    header: "Nominal",
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  primaryButton(text: "Simpan", onPressed: () {}),
                ],
              ),
            ),
          ),
        );
      },
    );

  }
}
