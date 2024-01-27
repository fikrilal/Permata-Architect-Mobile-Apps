import 'package:flutter/material.dart';
import 'package:flutter_hicons/flutter_hicons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permata_architect_mobile_apps/repository/res/font_style.dart';

import '../../../repository/res/color_libraries.dart';
import '../../components/card/card_list_project.dart';
import '../../components/textfield/textfield_search.dart';

class ProjectList extends StatefulWidget {
  const ProjectList({super.key});

  @override
  State<ProjectList> createState() => _ProjectListState();
}

class _ProjectListState extends State<ProjectList> {
  final TextEditingController _controllerSearchName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Lokasi Proyek",
          style: headerFontMenu,
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: ListColor.gray200,
            height: 1.0,
          ),
        ),
        surfaceTintColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 16.h),
              TextFieldSearchWidget(
                  controller: _controllerSearchName,
                  keyboardType: TextInputType.name,
                  text: "Cari Proyek.."),
              const CardListProject(
                alamat: "Jl. Suparjan Mangun Wijaya",
                lokasi: "Lokasi Proyek 1",
                pemilik: "Ayub Bahrudin",
                status: "On Progress",
              )
            ],
          ),
        ),
      ),
    );
  }
}
