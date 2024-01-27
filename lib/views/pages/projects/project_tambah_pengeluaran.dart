import 'package:flutter/material.dart';
import 'package:flutter_hicons/flutter_hicons.dart';
import 'package:permata_architect_mobile_apps/repository/res/font_style.dart';
import 'package:permata_architect_mobile_apps/views/components/button/button_primary.dart';
import 'package:permata_architect_mobile_apps/views/components/textfield/textfield_primary.dart';

import '../../../repository/res/color_libraries.dart';
import '../../components/appbar/custom_appbar.dart';
import '../../components/text/header.dart';

class ProjectTambahPengeluaran extends StatefulWidget {
  const ProjectTambahPengeluaran({super.key});

  @override
  State<ProjectTambahPengeluaran> createState() =>
      _ProjectTambahPengeluaranState();
}

class _ProjectTambahPengeluaranState extends State<ProjectTambahPengeluaran> {
  final TextEditingController _controllerBarang = TextEditingController();
  final TextEditingController _controllerQuantity = TextEditingController();
  final TextEditingController _controllerHargaSatuan = TextEditingController();
  final TextEditingController _controllerVendor = TextEditingController();
  final TextEditingController _controllerSumberDana = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: CustomAppBar(
        title: "Tambah Pengeluaran",
        onBack: () {
          Navigator.of(context).pop();
        },
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textFieldForm(
                    controller: _controllerBarang,
                    header: "Nama Barang",
                    text: "Contoh: Semen 50KG",
                    keyboardType: TextInputType.text),
                textFieldForm(
                    controller: _controllerQuantity,
                    header: "Quantity",
                    text: "Contoh: 5",
                    keyboardType: TextInputType.number),
                textFieldForm(
                    controller: _controllerHargaSatuan,
                    header: "Harga Satuan",
                    text: "Rp.",
                    keyboardType: TextInputType.number),
                textFieldForm(
                    controller: _controllerVendor,
                    header: "Vendor",
                    text: "Vendor",
                    keyboardType: TextInputType.name),
                textFieldForm(
                    controller: _controllerSumberDana,
                    header: "Sumber Dana",
                    text: "Sumber Dana",
                    keyboardType: TextInputType.text),
                uploadImages(header: "Nota", text: "Upload Bukti Nota"),
                const SizedBox(
                  height: 15,
                ),
                primaryButton(
                    text: "Simpan",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        print("Dah Lengkap");
                      } else {
                        print("Lengkapi dahulu");
                      }
                    }),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
