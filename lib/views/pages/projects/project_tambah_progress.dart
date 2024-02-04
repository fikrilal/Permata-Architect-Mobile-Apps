import 'package:flutter/material.dart';
import 'package:flutter_hicons/flutter_hicons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permata_architect_mobile_apps/api/api_add_progress.dart';
import 'package:permata_architect_mobile_apps/models/proyek_model/list_proyek_model.dart';
import 'package:permata_architect_mobile_apps/poviders/list_progress_all.dart';
import 'package:permata_architect_mobile_apps/views/components/textfield/textfield_primary.dart';
import 'package:provider/provider.dart';

import '../../../models/image/image_helper.dart';
import '../../../repository/res/color_libraries.dart';
import '../../../repository/res/font_style.dart';
import 'dart:io';
import '../../components/appbar/custom_appbar.dart';

import '../../components/button/button_loading.dart';
import '../../components/button/button_primary.dart';
import '../../components/snackbar/snackbar_custom.dart';
import 'project_details.dart';

class ProjectTambahProgress extends StatefulWidget {
  final ListProyek listProyek;
  const ProjectTambahProgress({super.key, required this.listProyek});

  @override
  State<ProjectTambahProgress> createState() => _ProjectTambahProgressState();
}

class _ProjectTambahProgressState extends State<ProjectTambahProgress> {
  final TextEditingController _controllerNameSueveyor = TextEditingController();
  final TextEditingController _controllerDetailLokasi = TextEditingController();
  final TextEditingController _controllerProgress = TextEditingController();
  final TextEditingController _controllerKeterangan = TextEditingController();

  List<String> progressName = [
    'Bowplank',
    'Urug Lahan',
    'Pondasi - Pekerjaan Strous',
    'Pondasi - Pekerjaan Foot Plate',
    'Pondasi - Pekerjaan pasang Kumbung',
    'Pondasi - Pekerjaan Instalasi paralon air kotor',
    'Pondasi - Pekerjaan Sloof',
    'Pondasi - Pasang Nol Rumah',
    'Pondasi - Urug Pondasi',
    'Pondasi - Rabat lantai',
    'Badan - Pasang Kolom',
    'Badan - Pasangan Dinding',
    'Badan - Pasang Kusen Pintu',
    'Badan - Pasang Kusen Jendela',
    'Badan - Pasang Balok Latei(Sabuk)',
    'Badan - Pasang Ringblak (Ring)',
    'Atap - Pekerjaan Talang',
    'Atap - Pekerjaan Rangka',
    'Atap - Pasang Genteng',
    'Atap - Pekerjaan Wuwung',
    'Atap - Finishing Atap',
    'Finishing - Pasang Jaringan Listrik',
    'Finishing - Plester Dinding',
    'Finishing - Pasang Plafon',
    'Finishing - Pasang Granit/Keramik Lantai',
    'Finishing - Pasang Granit/Keramik KM/WC',
    'Finishing - Pasang Daun Pintu',
    'Finishing - Pasang Daun Jendela',
    'Finishing - Pekerjaan Meja Dapur',
    'Finishing - Pekerjaan Granit/keramik Dinding',
    'Finishing - Pekerjaan Acian',
    'Finishing - Pekerjaan Plamir',
    'Finishing - Pasang Elektrikal',
    'Finishing - Pekerjaan Cat Rumah',
    'Tambahan - Pekerjaan Pagar'
  ];
  List<bool>? _isChecked;
  List<String> selectedProgress = [];
  bool? isSend = false;

  @override
  void initState() {
    super.initState();
    _isChecked = List<bool>.filled(progressName.length, false);

    // var provider =
    //     Provider.of<ListProgressByIdProvider>(context, listen: false);

    // var projectInput =
    //     provider.getInputForProject(widget.listProyek.idProyek.toString());
    // _controllerNameSueveyor =
    //     TextEditingController(text: projectInput['nameSurveyor']);

    // _controllerNameSueveyor.addListener(() {
    //   provider.setInputForProject(widget.listProyek.idProyek.toString(),
    //       'nameSurveyor', _controllerNameSueveyor.text);
    // });
  }

  final _formKey = GlobalKey<FormState>();

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

  Future<void> _addProgress(
      {String? name,
      String? detailLokasi,
      String? progress,
      String? keterangan,
      String? idProyek}) async {
    try {
      setState(() {
        isSend = true;
      });
      await ApiAddProgress.addprogress(
          name: name,
          detailLokasi: detailLokasi,
          progress: progress,
          keteranganProgress: keterangan,
          idProyek: idProyek,
          image: _image);

      print("Pemasukan berhasil ditambahkan");
      // ignore: use_build_context_synchronously
      Provider.of<ListProgressAllProvider>(context, listen: false)
          .fetchGetList();
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
    double screenHeight = MediaQuery.of(context).size.height;
    double topPadding = MediaQuery.of(context).padding.top;
    double appBarHeight = kToolbarHeight;

    double bodyHeight = screenHeight - topPadding - appBarHeight;

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
          child: SingleChildScrollView(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
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
                    textFieldShowBottomSheet(
                        controller: _controllerProgress,
                        text: "Progress Pengerjaan",
                        hightBottomSheet: bodyHeight,
                        header: "Pilih Progress"),
                    textFieldFormParagraph(
                        controller: _controllerKeterangan,
                        text: "Keterangan Progress",
                        header: "Keterangan Progress",
                        keyboardType: TextInputType.multiline),
                    uploadImages(
                      header: "Foto",
                      text: "Upload Foto Progress",
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Pilih Sumber Gambar"),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    leading: const Icon(Icons.photo_library),
                                    title: const Text("Galeri"),
                                    onTap: () {
                                      Navigator.pop(context);
                                      _pickImage(ImageSource.gallery);
                                    },
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.camera_alt),
                                    title: const Text("Kamera"),
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
                                print(
                                    "Data diprint\nname = ${_controllerNameSueveyor.text}\nlokasi = ${_controllerDetailLokasi.text}\nprogress = ${_controllerProgress.text}\nketerangan = ${_controllerKeterangan.text}\nid=${widget.listProyek.idProyek.toString()}");
                                _addProgress(
                                    name: _controllerNameSueveyor.text,
                                    detailLokasi: _controllerDetailLokasi.text,
                                    progress: _controllerProgress.text,
                                    keterangan: _controllerKeterangan.text,
                                    idProyek:
                                        widget.listProyek.idProyek.toString());
                              } else {
                                CustomSnackbar.showFailedSnackbar(
                                    context, "Harap Pastikan semua terisi");
                              }
                            })
                        : loadingButton(text: "Mengirim Data")
                  ],
                )),
          )),
    );
  }

  Widget textFieldShowBottomSheet(
      {TextEditingController? controller,
      String? text,
      String? header,
      double? hightBottomSheet}) {
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
          readOnly: true,
          onTap: () {
            showAction(height: hightBottomSheet);
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Mohon Lengkapi';
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
            contentPadding: const EdgeInsets.all(18.0),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: ListColor.gray200,
                width: 1,
              ),
            ),
            suffixIcon: Container(
              width: 54,
              alignment: Alignment.centerLeft,
              child: const Padding(
                padding: EdgeInsets.only(left: 18.0),
                child: Icon(Hicons.down_2_light_outline),
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
            hintText: text,
            labelStyle: const TextStyle(
              fontFamily: 'Satoshi',
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: ListColor.gray500,
            ),
            filled: false,
            floatingLabelBehavior: FloatingLabelBehavior.never,
          ),
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }

  void showAction({double? height}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              height: height! - 200,
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
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                        'Pilih Progress Pengerjaan',
                        style: headerFontMenu.copyWith(fontSize: 24.sp),
                      ),
                      Text(
                        "Kamu bisa memilih lebih dari 1 progress",
                        style: subHeaderFont.copyWith(fontSize: 18.sp),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      const Divider(),
                      ListView.builder(
                        itemCount: progressName.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Checkbox(
                                    value: _isChecked![index],
                                    onChanged: (value) {
                                      if (_isChecked![index] == false) {
                                        setState(() {
                                          _isChecked![index] = true;
                                          print(
                                              "hasil ture : ${_isChecked![index]} indek ke ${index}");
                                          selectedProgress
                                              .add(progressName[index]);
                                        });
                                      } else {
                                        setState(() {
                                          _isChecked![index] = false;
                                          print(
                                              "hasil false : ${_isChecked![index]} indek ke ${index}");
                                          selectedProgress
                                              .remove(progressName[index]);
                                        });
                                      }
                                      print(
                                          'Selected Progress: $selectedProgress');
                                      // Update the text of the text field
                                      if (selectedProgress.isNotEmpty) {
                                        _controllerProgress.text =
                                            selectedProgress.join(', ');
                                      } else {
                                        _controllerProgress.text =
                                            'Progress Pengerjaan';
                                      }
                                    },
                                    checkColor: Colors.white,
                                    activeColor: ListColor.primary,
                                    visualDensity:
                                        const VisualDensity(horizontal: -4),
                                    side: const BorderSide(
                                        color: ListColor.gray400),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.r)),
                                  ),
                                  SizedBox(
                                    width: 12.w,
                                  ),
                                  Flexible(
                                    child: Text(
                                      "${progressName[index]}",
                                      style:
                                          regularFont.copyWith(fontSize: 18.sp),
                                    ),
                                  )
                                ],
                              ),
                              const Divider()
                            ],
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
