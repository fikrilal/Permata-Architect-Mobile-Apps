import 'package:flutter/material.dart';
import 'package:flutter_hicons/flutter_hicons.dart';
import 'package:permata_architect_mobile_apps/views/components/textfield/textfield_primary.dart';

import '../../../repository/res/font_style.dart';

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
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Progress Lokasi Proyek 1",
          style: headerTextField.copyWith(fontSize: 18),
        ),
        leading: IconButton(
            onPressed: () {}, icon: const Icon(Hicons.left_1_light_outline)),
        surfaceTintColor: Colors.white,
      ),
      body: Form(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                  header: "keterangan Progress",
                  keyboardType: TextInputType.multiline),
              uploadImages(header: "Foto", text: "Upload Foto Progress")
            ],
          ),
        ),
      )),
    );
  }
}
