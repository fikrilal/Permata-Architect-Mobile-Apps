import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../components/appbar/custom_appbar.dart';
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

  File? _image;

  void _deleteImage() {
    setState(() {
      _image = null;
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: source);

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
        print("Gambar dipilih dari ${source == ImageSource.gallery ? 'galeri' : 'kamera'}");
      } else {
        print("Tidak ada gambar yang dipilih");
      }
    } catch (e) {
      print("Terjadi kesalahan saat memilih gambar: $e");
    }
  }

  Future<void> uploadImage(File imageFile) async {
    var uri = Uri.parse('https://api.imgbb.com/1/upload');
    var request = http.MultipartRequest('POST', uri)
      ..fields['key'] = '134113064fd64005338a64d3d654c6f9'
      ..files.add(await http.MultipartFile.fromPath('image', imageFile.path));

    var response = await request.send();

    if (response.statusCode == 200) {
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      print('Upload berhasil: $responseString');
    } else {
      print('Upload gagal');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Tambah Pemasukan",
        onBack: () {
          Navigator.of(context).pop();
        },
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
                uploadImages(
                  header: "Nota Pendanaan",
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
                SizedBox(height: 24.h),
                primaryButton(
                    text: "Simpan",
                    onPressed: () {
                      if (_formKey.currentState!.validate() && _image != null) {
                        uploadImage(_image!);
                      } else {
                        print("Lengkapi data dan pilih gambar dahulu");
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
