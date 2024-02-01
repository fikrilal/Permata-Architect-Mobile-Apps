import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:permata_architect_mobile_apps/models/proyek_model/list_proyek_model.dart';
import 'package:permata_architect_mobile_apps/views/pages/dashboard/dashboard.dart';
import 'package:permata_architect_mobile_apps/views/pages/intro/splash_screen_page.dart';
import 'package:permata_architect_mobile_apps/views/pages/projects/project_absensi.dart';
import 'package:permata_architect_mobile_apps/views/pages/projects/project_kasbon.dart';
import 'package:permata_architect_mobile_apps/views/pages/projects/project_list.dart';
import 'package:permata_architect_mobile_apps/views/pages/projects/project_tambah_progress.dart';

import '../../views/components/navigation/bottom_navigation.dart';
import '../../views/pages/auth/login_page.dart';
import '../../views/pages/auth/register_page.dart';
import '../../views/pages/projects/project_details.dart';
// import '../../views/pages/projects/project_main.dart';
import '../../views/pages/projects/project_tambah_pemasukan.dart';
import '../../views/pages/projects/project_tambah_pengeluaran.dart';

class NavigationController {
  NavigationController._();

  static String initR =
      '/SplashPage'; //Halaman pertama ketika aplikasi dijalankan

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _rootNavigatorDashboard =
      GlobalKey<NavigatorState>(debugLabel: 'shellDashboard');
  static final _rootNavigatorProject =
      GlobalKey<NavigatorState>(debugLabel: 'shellProject');

  static final GoRouter router = GoRouter(
    initialLocation: initR,
    navigatorKey: _rootNavigatorKey,
    routes: <RouteBase>[
      GoRoute(
        path: '/LoginPage',
        name: 'LoginPage',
        builder: (context, state) {
          return LoginPage(
            key: state.pageKey,
          );
        },
      ),
      GoRoute(
        path: '/RegisterPage',
        name: 'RegisterPage',
        builder: (context, state) {
          return RegisterPage(
            key: state.pageKey,
          );
        },
      ),
      GoRoute(
        path: '/AbsensiPage',
        name: 'AbsensiPage',
        builder: (context, state) {
          return ProjectTambahPemasukan(
            key: state.pageKey,
            listProyek:
                ModalRoute.of(context)?.settings.arguments as ListProyek,
          );
        },
      ),
      GoRoute(
        path: '/KasbonPage',
        name: 'KasbonPage',
        builder: (context, state) {
          return ProjectKasbon(
            key: state.pageKey,
          );
        },
      ),
      GoRoute(
        path: '/SplashPage',
        name: 'SplashPage',
        builder: (context, state) {
          return SplashScreen(
            key: state.pageKey,
          );
        },
      ),
      GoRoute(
        path: '/ProjectDetails',
        name: 'ProjectDetails',
        builder: (context, state) {
          return ProjectDetails(
            key: state.pageKey,
            listProyek:
                ModalRoute.of(context)?.settings.arguments as ListProyek,
          );
        },
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainWrapper(navigationShell: navigationShell);
        },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            navigatorKey: _rootNavigatorDashboard,
            routes: [
              GoRoute(
                path: '/DashboardPage',
                name: 'DashboardPage',
                builder: (context, state) {
                  return DashboardPage(
                    key: state.pageKey,
                  );
                },
                // routes:
              )
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _rootNavigatorProject,
            routes: [
              GoRoute(
                path: '/ProjectListdPage',
                name: 'ProjectListdPage',
                builder: (context, state) {
                  return ProjectList(
                    key: state.pageKey,
                  );
                },
                // routes: [
                //   GoRoute(path: 'AbsensiPage',
                //       name: 'AbsensiPage',
                //       builder: (context, state) {
                //         return ProjectAbsensi(
                //           key: state.pageKey,
                //         );
                //       })
                // ]
              ),
            ],
          ),
        ],
      )
    ],
  );
}
