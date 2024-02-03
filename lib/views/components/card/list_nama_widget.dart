import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permata_architect_mobile_apps/models/proyek_model/absensi_model.dart';
import 'package:permata_architect_mobile_apps/poviders/absensi_provider.dart';
import 'package:permata_architect_mobile_apps/repository/res/font_style.dart';
import 'package:permata_architect_mobile_apps/views/components/snackbar/snackbar_custom.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../models/proyek_model/list_proyek_model.dart';
import '../../../repository/res/color_libraries.dart';

class ListNama extends StatefulWidget {
  final AbsensiModel data;
  final AbsensiProvider addAbsen;
  final ListProyek listProyek;

  const ListNama({
    Key? key,
    required this.data,
    required this.addAbsen,
    required this.listProyek,
  }) : super(key: key);

  @override
  _ListNamaState createState() => _ListNamaState();
}

class _ListNamaState extends State<ListNama> {
  List<String> absensi = ['Masuk', 'Setengah Hari', 'Tidak Masuk'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  widget.data.namaPekerja!,
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
                    value: (widget.data.absensis != null && widget.data.absensis!.isNotEmpty)
                        ? widget.data.absensis!.first.statusAbsensi
                        : null,
                    alignment: Alignment.centerRight,
                    onChanged: (String? newValue) async {
                      // Cek apakah absensis bukan null DAN (isEmpty atau isNotEmpty)
                      if (widget.data.absensis != null && widget.data.absensis!.isEmpty) {
                        print("kosong");
                        // Logika untuk menambahkan absensi baru
                        bool resultAbsen = await widget.addAbsen.addAbsensi(
                            idPekerja: widget.data.idPekerja.toString(),
                            idProyek: widget.listProyek.idProyek.toString(),
                            statusAbsensi: newValue);
                        if (resultAbsen) {
                          CustomSnackbar.showSuccessSnackbar(
                              context, '${widget.data.namaPekerja} Berhasil Absen');
                          var newAbsensi = Absensis(
                              statusAbsensi: newValue, tanggal: DateTime.now().toString());
                          setState(() {
                            widget.data.absensis = [newAbsensi];
                          });
                        }
                      } else if (widget.data.absensis != null && widget.data.absensis!.isNotEmpty) {
                        print("ada");
                        // Logika untuk mengupdate absensi yang sudah ada
                        bool resultAbsen = await widget.addAbsen.addAbsensi(
                            idPekerja: widget.data.idPekerja.toString(),
                            idProyek: widget.listProyek.idProyek.toString(),
                            statusAbsensi: newValue);
                        if (resultAbsen) {
                          CustomSnackbar.showSuccessSnackbar(
                              context, 'Absen ${widget.data.namaPekerja} Telah Diubah');
                          setState(() {
                            widget.data.absensis!.first.statusAbsensi = newValue;
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
