import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:role_game_app/presentation_layer/providers/animation_provider.dart';
import 'package:role_game_app/presentation_layer/providers/route_provider.dart';
import 'package:role_game_app/presentation_layer/router/routes.dart';

class NavigationUtils {
  static void navigateWithDelay(
      WidgetRef ref, BuildContext context, AppRoute newRoute) async {
    AppRoute previousRoute = ref.watch(routeProvider);
    if (previousRoute == newRoute) return;

    ref.read(animationProvider.notifier).runExitAnimations();

    // Wait for the animation to complete
    await Future.delayed(const Duration(milliseconds: 1000));
    ref.read(routeProvider.notifier).state = newRoute;
    // Use GoRouter to navigate after the delay
    if (context.mounted) {
      context.goNamed(newRoute.name);
    }
  }

  static String getRouteLabel(WidgetRef ref) {
    try{
      AppRoute route = ref.watch(routeProvider);
      return navigationItems[route]!.label;
    }
    catch (e){
      log('Route ${ref.watch(routeProvider).name} has no label');
      return 'Untitled';
    }
  }

  // Clear all previous routes and navigate to the initial route
  static void resetAppNavigation(BuildContext context) {
    context.goNamed(initialRoute.name);
  }

  // // Dynamically create a map from route names to their indices based on AppRoute
  // static final Map<String, int> routeToIndex = {
  //   for (int i = 0; i < navigationItems.length; i++)
  //     navigationItems[i].label : i
  // };

  // // Dynamically create a list that maps indices back to route names
  // static final List<String> indexToRoute = [
  //   for (var route in AppRoute.values) route.name
  // ];

  // // Method to get the index from the route
  // static int indexByRoute(String route) {
  //   return routeToIndex[route] ?? 1; // Default to index 1 (training)
  // }

  // // Method to get the route from the index
  // static String routeByIndex(int index) {
  //   return indexToRoute[index];
  // }
}
