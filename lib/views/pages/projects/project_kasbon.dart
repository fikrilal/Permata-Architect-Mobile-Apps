import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permata_architect_mobile_apps/repository/api/api_update_kasbon.dart';
import 'package:permata_architect_mobile_apps/repository/res/color_libraries.dart';
import 'package:permata_architect_mobile_apps/repository/res/font_style.dart';
import 'package:permata_architect_mobile_apps/views/components/button/button_primary.dart';
import 'package:permata_architect_mobile_apps/views/components/textfield/textfield_primary.dart';

import '../../../models/proyek_model/list_proyek_model.dart';
import '../../../repository/api/api_kasbon.dart';
import '../../components/appbar/custom_appbar.dart';
import '../../components/card/empty_state.dart';
import '../../components/textfield/textfield_search.dart';

class ProjectKasbon extends StatefulWidget {
  final ListProyek listProyek;

  const ProjectKasbon({super.key, required this.listProyek});

  @override
  State<ProjectKasbon> createState() => _ProjectKasbonState();
}

class _ProjectKasbonState extends State<ProjectKasbon> {
  late Future<List<KasbonData>> futureKasbons;
  List<KasbonData> allKasbons = []; // Untuk menyimpan semua kasbon
  List<KasbonData> filteredKasbons = []; // Untuk menyimpan kasbon yang difilter
  final TextEditingController _controllerHarga = TextEditingController();
  final TextEditingController _controllerSearchName = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadKasbons();

    _controllerSearchName.addListener(_filterKasbons);
  }

  void _loadKasbons() {
    ApiKasbon.getKasbons(widget.listProyek.idProyek).then((kasbons) {
      setState(() {
        allKasbons = kasbons;
        filteredKasbons = kasbons;
      });
    }).catchError((error) {
      print("Error loading kasbons: $error");
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _controllerSearchName.dispose();
    super.dispose();
  }

  void _filterKasbons() {
    final query = _controllerSearchName.text.toLowerCase();

    setState(() {
      filteredKasbons = allKasbons.where((kasbon) {
        return kasbon.namaPekerja.toLowerCase().contains(query);
      }).toList();
    });
  }

  void updateKasbons(
      String idPekerja, String idProyek, String jumlahKasbon) async {
    final result = await ApiUpdateKasbon.updateKasbons(
      idPekerja: idPekerja,
      idProyek: idProyek,
      jumlahKasbon: jumlahKasbon,
    );

    if (result['success']) {
      _controllerHarga.clear();
      _loadKasbons();
    } else {
      // Handle failure
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Kasbon",
        onBack: () {
          Navigator.of(context).pop();
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 24.h, 0, 24.h),
            child: Column(
              children: [
                TextFieldSearchWidget(
                  controller: _controllerSearchName,
                  keyboardType: TextInputType.name,
                  text: "Cari Pekerja..",
                ),
                const SizedBox(height: 15),
                filteredKasbons.isNotEmpty
                    ? ListView.builder(
                  itemCount: filteredKasbons.length,
                  shrinkWrap: true,
                  controller: _scrollController,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final kasbon = filteredKasbons[index];
                    return listKasbon(
                      name: kasbon.namaPekerja,
                      kasbonPrice: kasbon.jumlahKasbon,
                      idPekerja: kasbon.idPekerja.toString(),
                    );
                  },
                )
                    : buildEmptyState('Belum ada data kasbon pekerja di proyek ini'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget listKasbon(
      {required String name,
      required String kasbonPrice,
      required String idPekerja}) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            showAction(name, idPekerja);
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1, color: ListColor.gray200),
              ),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 0),
              title: Text(
                "$name",
                style: headerTextField.copyWith(fontSize: 20),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 4.h),
                  Text(
                    "Kasbon: Rp. $kasbonPrice",
                    style: subHeaderFont.copyWith(fontSize: 18),
                  ),
                ],
              ),
              trailing: SvgPicture.asset(
                'assets/icons/arrow-right.svg',
                width: 24.w,
                height: 24.h,
                color: ListColor.gray700,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void showAction(String name, String idPekerja) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return IntrinsicHeight(
          child: Container(
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
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
                    'Kurangi Kasbon',
                    style: headerFontMenu.copyWith(fontSize: 24),
                  ),
                  Text(
                    "Kurangi nominal kasbon untuk $name",
                    style: subHeaderFont.copyWith(fontSize: 18),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  textFieldForm(
                    controller: _controllerHarga,
                    text: "Rp. ",
                    header: "Nominal",
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  primaryButton(
                    text: "Simpan",
                    onPressed: () {
                      // Call the updateKasbons function here
                      updateKasbons(
                          idPekerja,
                          widget.listProyek.idProyek.toString(),
                          _controllerHarga.text);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}