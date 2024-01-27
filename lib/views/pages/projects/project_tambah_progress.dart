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

  List<String> progressName = [
    'Bowplank',
    'Urug Lahan',
    'Pondasi - Pekerjaan Strous',
    'Pondasi - Pekerjaan Foot Plate',
    'Pondasi - Pekerjaan pasang Kumbung',
    'Pondasi - Pekerjaan Instalasi paralon air kotor',
    'Pondasi - Pekerjaan Sloof'
  ];
  List<bool>? _isChecked;
  List<String> selectedProgress = [];

  @override
  void initState() {
    super.initState();
    _isChecked = List<bool>.filled(progressName.length, false);
    // Inisialisasi Map dengan semua item disetel ke false
    // for (var itemName in progressName) {
    //   checkedItems[itemName] = false;
    // }
  }

  final _formKey = GlobalKey<FormState>();

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
                      onPressed: () {},
                    ),
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
                padding: const EdgeInsets.only(left: 18.0),
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
                                        VisualDensity(horizontal: -4),
                                    side: BorderSide(color: ListColor.gray400),
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
