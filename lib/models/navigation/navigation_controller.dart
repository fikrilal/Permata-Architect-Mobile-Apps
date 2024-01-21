import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:permata_architect_mobile_apps/views/pages/dashboard/dashboard.dart';

import '../../views/components/navigation/bottom_navigation.dart';
import '../../views/pages/auth/login_page.dart';
import '../../views/pages/projects/project_main.dart';

class NavigationController {
  NavigationController._();

  static String initR =
      '/LoginPage'; //Halaman pertama ketika aplikasi dijalankan

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
                path: '/ProjectMain',
                name: 'ProjectMain',
                builder: (context, state) {
                  return ProjectMain(
                    key: state.pageKey,
                  );
                },
                // routes: [
                //   GoRoute(path: 'NewSchedulePage',
                //       name: 'NewSchedulePage',
                //       builder: (context, state) {
                //         return NewSchedulePage(
                //           key: state.pageKey,
                //         );
                //       })
                // ]
              )
            ],
          ),
        ],
      )
    ],
  );
}
