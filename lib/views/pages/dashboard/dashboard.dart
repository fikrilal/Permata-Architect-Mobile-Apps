import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_hicons/flutter_hicons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permata_architect_mobile_apps/models/proyek_model/list_cost_proyek_model.dart';
import 'package:permata_architect_mobile_apps/poviders/auth_provider.dart';
import 'package:permata_architect_mobile_apps/poviders/proyek_provider.dart';
import 'package:permata_architect_mobile_apps/repository/res/color_libraries.dart';
import 'package:permata_architect_mobile_apps/repository/res/font_style.dart';
import 'package:permata_architect_mobile_apps/views/components/text/format_rupiah.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 11) {
      return 'Pagi';
    } else if (hour < 14) {
      return 'Siang';
    } else if (hour < 18) {
      return 'Sore';
    } else {
      return 'Malam';
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: header(
                  greeting: "Selamat ${greeting()}, ${authProvider.user!.name}",
                  urlImage: ""),
            ),
            const Divider(
              color: ListColor.gray100,
              thickness: 5,
            ),
            progressProyek(
                judul: "Urug Lahan",
                lokasi: "Lokasi Proyek 1",
                tanggal: "12 Januari"),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              color: ListColor.gray100,
              thickness: 5,
            ),
            Consumer<ListCostProyekProvider>(
              builder: (context, state, _) {
                if (state.state == ResulState.loading) {
                  return const CircularProgressIndicator();
                } else if (state.state == ResulState.hasData) {
                  return pengeluaranProyek(data: state.listCostProyek);
                } else {
                  if (state.message == '404') {
                    return const Text('Terjadi masalah jaringan');
                  } else {
                    return Text(state.message);
                  }
                }
              },
            ),
            // pengeluaranProyek(
            //     lokasi: "Lokasi Proyek 1", nominal: "Rp. 1.300.000"),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      )),
    );
  }

  //kumpulan widget
  Widget header({String? greeting, String? urlImage}) {
    return ListTile(
      leading: SizedBox(
        width: 56.w,
        height: 56.h,
        child: const CircleAvatar(
          backgroundImage: AssetImage("assets/images/blank_man_picture.png"),
        ),
      ),
      contentPadding: const EdgeInsets.all(0),
      title: Text(
        "$greeting",
        style: headerFontMenu.copyWith(fontSize: 20),
      ),
      subtitle: Text(
        "Ada laporan hari ini?",
        style: subHeaderFont.copyWith(fontSize: 16),
      ),
    );
  }

  Widget progressProyek({String? judul, String? lokasi, String? tanggal}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Progress Proyek",
            style: headerFontMenu.copyWith(fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          ListView.builder(
            itemCount: 5,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ListTile(
                    leading: Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          image: const DecorationImage(
                              image:
                                  AssetImage("assets/images/construction.png")),
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    contentPadding: const EdgeInsets.all(0),
                    title: Text(
                      "$judul",
                      style: headerFontMenu.copyWith(fontSize: 18),
                    ),
                    subtitle: Row(
                      children: [
                        const Icon(
                          Hicons.location_light_outline,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(
                          "$lokasi",
                          style: subHeaderFont.copyWith(fontSize: 16),
                        ),
                      ],
                    ),
                    trailing: Text(
                      "$tanggal",
                      style: regularFont.copyWith(fontSize: 14),
                    ),
                  ),
                  const Divider(),
                ],
              );
            },
          ),
          const SizedBox(
            height: 10,
          ),
          blueText(
            onpressed: () {
              print("Tampilkan Semua Proyek");
            },
          ),
        ],
      ),
    );
  }

  Widget pengeluaranProyek({List<ListCostProyek>? data}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Total Pengeluaran Proyek",
            style: headerFontMenu.copyWith(fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          ListView.builder(
            itemCount: data!.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final proyeks = data[index];
              return Column(
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    title: Text(
                      formatRupiah(
                          int.parse(proyeks.totalPengeluaran.toString())),
                      style: headerFontMenu.copyWith(fontSize: 18),
                    ),
                    subtitle: Row(
                      children: [
                        const Icon(
                          Hicons.location_light_outline,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(
                          proyeks.lokasiProyek!,
                          style: subHeaderFont.copyWith(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                ],
              );
            },
          ),
          const SizedBox(
            height: 10,
          ),
          blueText(
            onpressed: () {
              print("Tampilkan Semua Proyek");
            },
          ),
        ],
      ),
    );
  }

  Widget blueText({VoidCallback? onpressed}) {
    return GestureDetector(
      onTap: onpressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Tampilkan Semua",
            style: textFontBlue.copyWith(fontSize: 16),
          ),
          const SizedBox(
            width: 4,
          ),
          const Icon(
            Hicons.right_1_light_outline,
            color: ListColor.blue600,
          )
        ],
      ),
    );
  }
}
