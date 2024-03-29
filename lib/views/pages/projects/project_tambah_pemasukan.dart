import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:permata_architect_mobile_apps/models/proyek_model/list_proyek_model.dart';
import 'package:permata_architect_mobile_apps/views/components/button/button_loading.dart';
import 'package:permata_architect_mobile_apps/views/pages/projects/project_details.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/image/image_helper.dart';
import '../../../poviders/auth_provider.dart';
import '../../../repository/api/api_tambah_pemasukan.dart';
import '../../components/appbar/custom_appbar.dart';
import '../../components/button/button_primary.dart';
import '../../components/snackbar/snackbar_custom.dart';
import '../../components/textfield/textfield_primary.dart';

class ProjectTambahPemasukan extends StatefulWidget {
  final ListProyek listProyek;
  const ProjectTambahPemasukan({super.key, required this.listProyek});

  @override
  State<ProjectTambahPemasukan> createState() => _ProjectTambahPemasukanState();
}

class _ProjectTambahPemasukanState extends State<ProjectTambahPemasukan> {
  final TextEditingController _controllerPemasukan = TextEditingController();
  final TextEditingController _controllerSumberDana = TextEditingController();
  final TextEditingController _controllerNominal = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final ApiTambahPemasukan _apiTambahPemasukan = ApiTambahPemasukan();

  File? _image;
  ImageHelper _imageHelper = ImageHelper();
  bool? isSend = false;

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

  Future<void> _addPemasukan() async {
    BuildContext currentContext = context;
    try {
      //ID USER
      setState(() {
        isSend = true;
      });
      final prefs = await SharedPreferences.getInstance();
      int idUser = int.parse(prefs.getString('userId').toString());
      print("user idnya adalah = $idUser");

      await _apiTambahPemasukan.addPemasukan(
        jumlahPemasukan: int.parse(_controllerNominal.text),
        keterangan: _controllerPemasukan.text,
        sumberDana: _controllerSumberDana.text,
        id: idUser,
        id_proyek: int.parse(widget.listProyek.idProyek.toString()),
        image: _image!,
      );
      print("Pemasukan berhasil ditambahkan");
      CustomSnackbar.showSuccessSnackbar(context, 'Data berhasil ditambahkan!');
      Navigator.pushReplacement(
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
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
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
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    text: "Rp",
                    keyboardType: TextInputType.number),
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
                isSend == false
                    ? primaryButton(
                        text: "Simpan",
                        onPressed: () {
                          if (_formKey.currentState!.validate() &&
                              _image != null) {
                            _addPemasukan();
                          } else {
                            print("Lengkapi data dan pilih gambar dahulu");
                          }
                        })
                    : loadingButton(text: "Mengirim Data"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
