import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:role_game_app/presentation_layer/router/routes.dart';
import 'package:role_game_app/presentation_layer/screens.dart/screen_wrapper.dart';
import 'package:role_game_app/presentation_layer/screens.dart/settings/settings_screen.dart';
import 'package:role_game_app/presentation_layer/screens.dart/test/test_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/${initialRoute.name}',
  routes: [
    ShellRoute(
      navigatorKey: GlobalKey<NavigatorState>(),
      builder: customShellRouteBuilder,
      routes: [
        GoRoute(
          path: '/${AppRoute.settings.name}',
          name: '${AppRoute.settings.name}',
          pageBuilder: (context, state) =>
              NoAnimationPage(key: state.pageKey, child: SettingsScreen()),
        ),
        GoRoute(
          path: '/${AppRoute.page1.name}',
          name: AppRoute.page1.name,
          pageBuilder: (context, state) =>
              NoAnimationPage(key: state.pageKey, child: TestScreen())
        ),
        GoRoute(
          path: '/${AppRoute.page2.name}',
          name: AppRoute.page2.name,
          pageBuilder: (context, state) =>
              NoAnimationPage(key: state.pageKey, child: TestScreen())
        ),
        GoRoute(
          path: '/${AppRoute.page3.name}',
          name: AppRoute.page3.name,
          pageBuilder: (context, state) =>
              NoAnimationPage(key: state.pageKey, child: TestScreen())
        ),
      ],
    ),
  ],
);

Widget customShellRouteBuilder(
    BuildContext context, GoRouterState state, Widget child) {
  return ProviderScope(
    child: ScreenWrapper(child: child),
  );
}

class NoAnimationPage<T> extends Page<T> {
  final Widget child;

  NoAnimationPage({required this.child, LocalKey? key}) : super(key: key);

  @override
  Route<T> createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (_, __, ___) => child,
      transitionDuration: Duration.zero,
    );
  }
}