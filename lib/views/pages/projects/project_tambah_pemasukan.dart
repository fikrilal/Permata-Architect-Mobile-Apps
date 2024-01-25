import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../repository/res/color_libraries.dart';
import '../../components/button/button_primary.dart';
import '../../components/text/header.dart';
import '../../components/textfield/textfield_primary.dart';

class ProjectTambahPemasukan extends StatefulWidget {
  const ProjectTambahPemasukan({super.key});

  @override
  State<ProjectTambahPemasukan> createState() => _ProjectTambahPemasukanState();
}

class _ProjectTambahPemasukanState extends State<ProjectTambahPemasukan> {
  final TextEditingController _controllerPemasukan = TextEditingController();
  final TextEditingController _controllerSumberDana = TextEditingController();
  final TextEditingController _controllerNominal = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
        title: ComponentTextAppBar("Tambah Pemasukan"),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: ListColor.gray200,
            height: 1.0,
          ),
        ),
        surfaceTintColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 20.h),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(color: Colors.white),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                textFieldForm(
                    controller: _controllerPemasukan,
                    header: "Nama Pemasukan",
                    text: "Nama Pemasukan",
                    keyboardType: TextInputType.text),
                textFieldForm(
                    controller: _controllerSumberDana,
                    header: "Sumber Dana",
                    text: "Sumber Dana",
                    keyboardType: TextInputType.text),
                textFieldForm(
                    controller: _controllerNominal,
                    header: "Nominal",
                    text: "Rp",
                    keyboardType: TextInputType.text),
                uploadImages(header: "Nota Pendanaan", text: "Upload Bukti Nota"),
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
        ),
      ),
    );
  }
}