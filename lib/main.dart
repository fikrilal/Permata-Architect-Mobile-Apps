import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permata_architect_mobile_apps/api/api_list_progress.dart';
import 'package:permata_architect_mobile_apps/api/api_total_biaya_proyek.dart';
import 'package:permata_architect_mobile_apps/api/list_cost_proyek_api.dart';
import 'package:permata_architect_mobile_apps/api/list_proyek_api.dart';
import 'package:permata_architect_mobile_apps/poviders/auth_provider.dart';
import 'package:permata_architect_mobile_apps/poviders/list_progress_all.dart';
import 'package:permata_architect_mobile_apps/poviders/list_proyek.dart';
import 'package:permata_architect_mobile_apps/poviders/proyek_provider.dart';
import 'package:permata_architect_mobile_apps/poviders/search_list_proyek.dart';
import 'package:permata_architect_mobile_apps/poviders/total_biaya_proyek.dart';
import 'package:provider/provider.dart';

import 'models/navigation/navigation_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => AuthProvider(),
            ),
            ChangeNotifierProvider(
              create: (context) => ListCostProyekProvider(
                  getListCostProyekService: GetListCostProyekService()),
            ),
            ChangeNotifierProvider(
              create: (context) => ListProyekProvider(
                  getListProyekService: GetListProyekService()),
            ),
            ChangeNotifierProvider(
              create: (context) => ListProgressAllProvider(
                  getListProgressService: GetListProgressService()),
            ),
            ChangeNotifierProvider(
              create: (context) => SearchListProyek(
                  getListProyekService: GetListProyekService()),
            ),
            ChangeNotifierProvider(
              create: (context) => TotalBiayaProyekProvider(
                  totalBiayaProyekService: TotalBiayaProyekService()),
            )
          ],
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(fontFamily: 'Satoshi'),
            routerConfig: NavigationController.router,
          ),
        );
      },
    );
  }
}
