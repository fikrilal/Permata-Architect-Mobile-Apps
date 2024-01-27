import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permata_architect_mobile_apps/poviders/auth_provider.dart';
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
