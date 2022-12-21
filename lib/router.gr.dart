// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;

import 'pages/camera/camera_page.dart' as _i2;
import 'pages/home_page.dart' as _i1;

class AppRouter extends _i3.RootStackRouter {
  AppRouter([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.HomePage(),
      );
    },
    CameraRoute.name: (routeData) {
      final args = routeData.argsAs<CameraRouteArgs>(
          orElse: () => const CameraRouteArgs());
      return _i3.MaterialPageX<_i2.CameraPageResponse?>(
        routeData: routeData,
        child: _i2.CameraPage(
          key: args.key,
          captureMode: args.captureMode,
          maxVideoDuration: args.maxVideoDuration,
        ),
        maintainState: false,
      );
    },
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig(
          HomeRoute.name,
          path: '/',
        ),
        _i3.RouteConfig(
          CameraRoute.name,
          path: '/camera-page',
        ),
      ];
}

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i3.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '/',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i2.CameraPage]
class CameraRoute extends _i3.PageRouteInfo<CameraRouteArgs> {
  CameraRoute({
    _i4.Key? key,
    _i2.CaptureMode captureMode = _i2.CaptureMode.photo,
    Duration? maxVideoDuration,
  }) : super(
          CameraRoute.name,
          path: '/camera-page',
          args: CameraRouteArgs(
            key: key,
            captureMode: captureMode,
            maxVideoDuration: maxVideoDuration,
          ),
        );

  static const String name = 'CameraRoute';
}

class CameraRouteArgs {
  const CameraRouteArgs({
    this.key,
    this.captureMode = _i2.CaptureMode.photo,
    this.maxVideoDuration,
  });

  final _i4.Key? key;

  final _i2.CaptureMode captureMode;

  final Duration? maxVideoDuration;

  @override
  String toString() {
    return 'CameraRouteArgs{key: $key, captureMode: $captureMode, maxVideoDuration: $maxVideoDuration}';
  }
}
