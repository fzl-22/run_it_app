import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:run_it_app/core/common/transitions/transitions.dart';
import 'package:run_it_app/core/utils/logger.dart';
import 'package:run_it_app/src/map/presentation/views/map_screen.dart';

part 'observer.router.dart';

class AppRouter {
  static final routerConfig = GoRouter(
    debugLogDiagnostics: true,
    observers: [
      RouterObserver(),
    ],
    initialLocation: MapScreen.path,
    routes: [
      GoRoute(
        path: MapScreen.path,
        name: MapScreen.name,
        pageBuilder: (context, state) {
          return SlideUpRouteTransition(
            key: state.pageKey,
            child: const MapScreen(),
          );
        },
      ),
    ],
  );
}
