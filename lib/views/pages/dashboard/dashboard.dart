import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hicons/flutter_hicons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permata_architect_mobile_apps/models/proyek_model/list_cost_proyek_model.dart';
import 'package:permata_architect_mobile_apps/poviders/list_progress_all.dart';
import 'package:permata_architect_mobile_apps/poviders/proyek_provider.dart';
import 'package:permata_architect_mobile_apps/repository/api/api_config.dart';
import 'package:permata_architect_mobile_apps/repository/res/color_libraries.dart';
import 'package:permata_architect_mobile_apps/repository/res/font_style.dart';
import 'package:permata_architect_mobile_apps/views/components/text/format_date.dart';
import 'package:permata_architect_mobile_apps/views/components/text/format_rupiah.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/card/card_list_pengeluaran_proyek.dart';
import '../../components/card/card_progress_proyek.dart';
import '../../components/card/empty_state.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String nameUser = 'Loading...';

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    getUserName();
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 11) {
      return 'Pagi';
    } else if (hour < 15) {
      return 'Siang';
    } else if (hour < 18) {
      return 'Sore';
    } else {
      return 'Malam';
    }
  }

  Future<String> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return nameUser = prefs.getString('userName') ?? 'No Name';
  }

  @override
  Widget build(BuildContext context) {
    // AuthProvider authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 10.0.h),
              child: FutureBuilder<String>(
                future: getUserName(),
                // This should return a Future<String>
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else {
                    String nameUser = snapshot.data ?? 'No Name';
                    return header(
                      greeting: "Selamat ${greeting()}, $nameUser",
                      urlImage: "",
                    );
                  }
                },
              ),
            ),
            const Divider(
              color: ListColor.gray100,
              thickness: 5,
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 10.0.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Progress Proyek",
                    style: headerFontMenu.copyWith(fontSize: 20.sp),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Consumer<ListProgressAllProvider>(
                    builder: (context, state, _) {
                      if (state.state == ResultListProgress.loading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state.state == ResultListProgress.hasData) {
                        return Column(
                          children: [
                            progressProyek(state),
                            SizedBox(
                              height: 10.h,
                            ),
                            if (state.listprogress.isNotEmpty)
                              blueText(
                                onpressed: () {
                                  print("Tampilkan Semua Proyek");
                                },
                              ),
                          ],
                        );
                      } else {
                        if (state.message == '404') {
                          return noInternetConnection();
                        } else {
                          return buildEmptyState(
                              'Nampaknya belum ada progress proyek apapun');
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            const Divider(
              color: ListColor.gray100,
              thickness: 5,
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 10.0.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total Pengeluaran Proyek",
                    style: headerFontMenu.copyWith(fontSize: 20.sp),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Consumer<ListCostProyekProvider>(
                    builder: (context, state, _) {
                      if (state.state == ResulState.loading) {
                        return const CircularProgressIndicator();
                      } else if (state.state == ResulState.hasData) {
                        return Column(
                          children: [
                            pengeluaranProyek(data: state.listCostProyek),
                            SizedBox(
                              height: 10.h,
                            ),
                            if (state.listCostProyek.isNotEmpty)
                              blueText(
                                onpressed: () {
                                  print("Tampilkan Semua Proyek");
                                },
                              ),
                          ],
                        );
                      } else {
                        if (state.message == '404') {
                          return noInternetConnection();
                        } else {
                          return buildEmptyState(
                              'Belum ada pengeluaran apapun');
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
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
        style: headerFontMenu.copyWith(fontSize: 20.sp),
      ),
      subtitle: Text(
        "Ada laporan hari ini?",
        style: subHeaderFont.copyWith(fontSize: 16.sp),
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
            style: textFontBlue.copyWith(fontSize: 16.sp),
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
