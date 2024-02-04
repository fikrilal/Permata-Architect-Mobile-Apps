import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hicons/flutter_hicons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permata_architect_mobile_apps/models/proyek_model/absensi_model.dart';
import 'package:permata_architect_mobile_apps/models/proyek_model/list_proyek_model.dart';
import 'package:permata_architect_mobile_apps/poviders/absensi_provider.dart';
import 'package:permata_architect_mobile_apps/repository/res/font_style.dart';
import 'package:permata_architect_mobile_apps/views/components/snackbar/snackbar_custom.dart';
import 'package:provider/provider.dart';

import '../../../repository/res/color_libraries.dart';
import '../../components/appbar/custom_appbar.dart';
import '../../components/card/empty_state.dart';

class ProjectAbsensi extends StatefulWidget {
  final ListProyek listProyek;

  const ProjectAbsensi({super.key, required this.listProyek});

  @override
  State<ProjectAbsensi> createState() => _ProjectAbsensiState();
}

class _ProjectAbsensiState extends State<ProjectAbsensi> {
  String? initialValue;
  List<String> absensi = ['Masuk', 'Setengah Hari', 'Tidak Masuk'];
  List<Absensis> absensiKehadiran = [];

  @override
  void initState() {
    // TODO: implement initState
    final provider = Provider.of<AbsensiProvider>(context, listen: false);
    provider.fetchGetListAbsensi(
        idProyek: widget.listProyek.idProyek.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: "Absensi",
          onBack: () {
            Navigator.of(context).pop();
          },
        ),
        body: Consumer<AbsensiProvider>(
          builder: (context, state, _) {
            if (state.state == ResultAbsensi.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.state == ResultAbsensi.hasData) {
              return ListView.builder(
                itemCount: state.absensilist.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  var data = state.absensilist[index];
                  return listNama(data: data, addAbsen: state);
                },
              );
            } else {
              if (state.message == '404') {
                return noInternetConnection();
              } else if (state.message == 'Empthy Data') {
                return buildEmptyState('Belum ada data pekerja di proyek ini');
              } else {
                return Text(state.message);
              }
            }
          },
        ));
  }

  Widget listNama({AbsensiModel? data, AbsensiProvider? addAbsen}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  data!.namaPekerja!,
                  style: regularFont,
                ),
              ),
              Flexible(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint: const Text(
                      'Kehadiran',
                      style: regularFont,
                    ),
                    items: absensi
                        .map((String item) => DropdownMenuItem<String>(
                              value: item,
                              alignment: Alignment.centerRight,
                              child: Text(
                                item,
                                textAlign: TextAlign.end,
                                style: regularFont,
                              ),
                            ))
                        .toList(),
                    value: (data.absensis != null && data.absensis!.isNotEmpty)
                        ? data.absensis!.first.statusAbsensi
                        : null,
                    alignment: Alignment.centerRight,
                    onChanged: (String? newValue) async {
                      if (data.absensis != null && data.absensis!.isNotEmpty) {
                        print("ada");
                        bool resultAbsen = await addAbsen!.addAbsensi(
                            idPekerja: data.idPekerja.toString(),
                            idProyek: widget.listProyek.idProyek.toString(),
                            statusAbsensi: newValue);
                        if (resultAbsen) {
                          // ignore: use_build_context_synchronously
                          CustomSnackbar.showSuccessSnackbar(context,
                              'Absen ${data.namaPekerja} Telah Diubah');
                        }
                        setState(() {
                          data.absensis!.first.statusAbsensi = newValue;
                        });
                      } else {
                        // Anda bisa memutuskan apakah ingin menambahkan absensi baru di sini
                        print("kosong");
                        bool resultAbsen = await addAbsen!.addAbsensi(
                            idPekerja: data.idPekerja.toString(),
                            idProyek: widget.listProyek.idProyek.toString(),
                            statusAbsensi: newValue);
                        if (resultAbsen) {
                          // ignore: use_build_context_synchronously
                          CustomSnackbar.showSuccessSnackbar(
                              context, '${data.namaPekerja} Berhasil Absen');
                          var newAbsensi = Absensis(
                              statusAbsensi: newValue,
                              tanggal: DateTime.now().toString());

                          setState(() {
                            data.absensis = [newAbsensi];
                          });
                        }
                      }
                    },
                    buttonStyleData: ButtonStyleData(
                      elevation: 0,
                      padding: EdgeInsets.fromLTRB(0.w, 16.h, 0.w, 16.h),
                    ),
                    iconStyleData: IconStyleData(
                      icon: SvgPicture.asset(
                        'assets/icons/arrow-down.svg',
                        width: 20.w,
                        height: 20.h,
                        color: ListColor.gray700,
                      ),
                    ),
                    dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black38.withOpacity(0.2),
                              spreadRadius: -10,
                              blurRadius: 23,
                              offset: const Offset(2, 3), // changes position of shadow
                            ),
                          ],
                          color: ListColor.gray300,
                          borderRadius: BorderRadius.circular(10.w),
                        ),
                        direction: DropdownDirection.right),
                    menuItemStyleData: const MenuItemStyleData(),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(
          color: ListColor.gray300,
        )
      ],
    );
  }
}
