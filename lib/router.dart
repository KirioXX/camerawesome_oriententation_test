import 'package:auto_route/auto_route.dart';

import 'pages/camera/camera_page.dart';
import 'pages/home_page.dart';

// Guards

// Pages

@MaterialAutoRouter(
  replaceInRouteName: 'Page|Dialog,Route',
  routes: <AutoRoute>[
    AutoRoute(
      page: HomePage,
      initial: true,
    ),
    AutoRoute<CameraPageResponse?>(
      maintainState: false,
      page: CameraPage,
    ),
  ],
)
class $AppRouter {}
