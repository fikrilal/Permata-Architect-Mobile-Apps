import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permata_architect_mobile_apps/models/proyek_model/list_proyek_model.dart';
import 'package:permata_architect_mobile_apps/repository/api/api_tambah_pengeluaran.dart';
import 'package:permata_architect_mobile_apps/views/components/button/button_loading.dart';
import 'package:permata_architect_mobile_apps/views/components/button/button_primary.dart';
import 'package:permata_architect_mobile_apps/views/components/textfield/textfield_primary.dart';
import 'package:permata_architect_mobile_apps/views/pages/projects/project_details.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/image/image_helper.dart';
import '../../../poviders/proyek_provider.dart';
import '../../components/appbar/custom_appbar.dart';
import 'dart:io';

import '../../components/snackbar/snackbar_custom.dart';

class ProjectTambahPengeluaran extends StatefulWidget {
  final ListProyek listProyek;
  const ProjectTambahPengeluaran({super.key, required this.listProyek});

  @override
  State<ProjectTambahPengeluaran> createState() =>
      _ProjectTambahPengeluaranState();
}

class _ProjectTambahPengeluaranState extends State<ProjectTambahPengeluaran> {
  final TextEditingController _controllerNamaBarang = TextEditingController();
  final TextEditingController _controllerKeterangan = TextEditingController();
  final TextEditingController _controllerSumberDana = TextEditingController();
  final TextEditingController _controllerSatuan = TextEditingController();
  final TextEditingController _controllerQuantity = TextEditingController();
  final TextEditingController _controllerVendor = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final ApiTambahPengeluaran _apiTambahPengeluaran = ApiTambahPengeluaran();
  bool? isSend = false;

  File? _image;
  ImageHelper _imageHelper = ImageHelper();

  void _deleteImage() {
    setState(() {
      _image = null;
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    File? pickedImage = await _imageHelper.pickImage(source);

    if (pickedImage != null) {
      setState(() {
        _image = pickedImage;
      });
      print(
          "Gambar dipilih dari ${source == ImageSource.gallery ? 'galeri' : 'kamera'}");
    } else {
      print("Tidak ada gambar yang dipilih");
    }
  }

  Future<void> _addPengeluaran() async {
    BuildContext currentContext = context;
    try {
      setState(() {
        isSend = true;
      });
      final prefs = await SharedPreferences.getInstance();
      int idUser = int.parse(prefs.getString('userId').toString());
      print("user idnya adalah = $idUser");
      await _apiTambahPengeluaran.addPengeluaran(
        judulPengeluaran: _controllerNamaBarang.text,
        keterangan: _controllerKeterangan.text,
        sumberDana: _controllerSumberDana.text,
        id: idUser,
        idProyek: int.parse(widget.listProyek.idProyek.toString()),
        satuan: _controllerSatuan.text,
        quantity: int.parse(_controllerQuantity.text),
        hargaSatuan: int.parse(_controllerSatuan.text),
        vendor: _controllerVendor.text,
        image: _image!,
      );
      print("Pemasukan berhasil ditambahkan");
      Provider.of<ListCostProyekProvider>(context, listen: false)
          .fetchTotalProyek();
      CustomSnackbar.showSuccessSnackbar(context, 'Data berhasil ditambahkan!');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProjectDetails(
            listProyek: widget.listProyek,
          ),
        ),
      );
    } catch (error) {
      setState(() {
        isSend = false;
      });
      print("Error: $error");
      CustomSnackbar.showFailedSnackbar(context, 'Gagal menambahkan data');
    }
  }

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
                    controller: _controllerNamaBarang,
                    header: "Nama Barang",
                    text: "Contoh: Semen 50KG",
                    keyboardType: TextInputType.text),
                textFieldForm(
                    controller: _controllerKeterangan,
                    header: "Keterangan",
                    text: "Keterangan",
                    keyboardType: TextInputType.text),
                textFieldForm(
                    controller: _controllerQuantity,
                    header: "Quantity",
                    text: "Contoh: 5",
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number),
                textFieldForm(
                    controller: _controllerSatuan,
                    header: "Harga Satuan",
                    text: "Rp.",
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                uploadImages(
                  header: "Nota",
                  text: "Upload Bukti Nota",
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Pilih Sumber Gambar"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                leading: Icon(Icons.photo_library),
                                title: Text("Galeri"),
                                onTap: () {
                                  Navigator.pop(context);
                                  _pickImage(ImageSource.gallery);
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.camera_alt),
                                title: Text("Kamera"),
                                onTap: () {
                                  Navigator.pop(context);
                                  _pickImage(ImageSource.camera);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  imageFile: _image,
                  onDelete: _deleteImage,
                ),
                const SizedBox(
                  height: 15,
                ),
                isSend == false
                    ? primaryButton(
                        text: "Simpan",
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _addPengeluaran();
                          } else {
                            print("Lengkapi dahulu");
                          }
                        })
                    : loadingButton(text: "Mengirim Data"),
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
