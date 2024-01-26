import 'package:flutter/material.dart';
import 'package:flutter_hicons/flutter_hicons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permata_architect_mobile_apps/views/components/textfield/textfield_primary.dart';

import '../../../repository/res/color_libraries.dart';
import '../../../repository/res/font_style.dart';
import '../../components/appbar/custom_appbar.dart';
import '../../components/button/button_primary.dart';
import '../../components/text/header.dart';

class ProjectTambahProgress extends StatefulWidget {
  const ProjectTambahProgress({super.key});

  @override
  State<ProjectTambahProgress> createState() => _ProjectTambahProgressState();
}

class _ProjectTambahProgressState extends State<ProjectTambahProgress> {
  final TextEditingController _controllerNameSueveyor = TextEditingController();
  final TextEditingController _controllerDetailLokasi = TextEditingController();
  final TextEditingController _controllerProgress = TextEditingController();
  final TextEditingController _controllerKeterangan = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: CustomAppBar(
        title: "Progress Lokasi Proyek 1",
        onBack: () {
          Navigator.of(context).pop();
        },
      ),
      body: Form(
          key: _formKey,
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              textFieldForm(
                  controller: _controllerNameSueveyor,
                  text: "Nama Sueveyor",
                  header: "Nama Sueveyor",
                  keyboardType: TextInputType.name),
              textFieldForm(
                  controller: _controllerDetailLokasi,
                  text: "Detail Lokasi",
                  header: "Detail Lokasi",
                  keyboardType: TextInputType.streetAddress),
              textFieldFormParagraph(
                  controller: _controllerKeterangan,
                  text: "Keterangan Progress",
                  header: "Keterangan Progress",
                  keyboardType: TextInputType.multiline),
              uploadImages(header: "Foto", text: "Upload Foto Progress"),
              SizedBox(height: 24.h),
              primaryButton(
                  text: "Simpan",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      print("Dah Lengkap");
                    } else {
                      print("Lengkapi dahulu");
                    }
                  }),
            ],
          ),
        ),
      )),
    );
  }
}
