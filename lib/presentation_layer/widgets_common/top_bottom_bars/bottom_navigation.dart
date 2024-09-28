import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:role_game_app/common_layer/theme/app_colors.dart';
import 'package:role_game_app/presentation_layer/router/navitation_utils.dart';
import 'package:role_game_app/presentation_layer/router/routes.dart';

class BottomNavigation extends ConsumerStatefulWidget {
  const BottomNavigation({super.key});

  @override
  ConsumerState<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends ConsumerState<BottomNavigation> {
  int _selectedIndex = displayedRoutes.contains(initialRoute)?
    displayedRoutes.indexOf(initialRoute):0;


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    NavigationUtils.navigateWithDelay(ref, context, displayedRoutes[index]);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final displayedNavigationItems = displayedRoutes.map((route) {
      final NavigationDestinationItem item = navigationItems[route]!;
      return NavigationDestination(
        icon: SizedBox(
          width: 28, // Normal icon size
          height: 28,
          child: item.iconPath != null
              ? SvgPicture.asset(
                  item.iconPath!,
                  colorFilter:
                      ColorFilter.mode(theme.primaryColorDark, BlendMode.srcIn),
                )
              : Icon(item.icon, size: 24),
        ),
        selectedIcon: SizedBox(
          width: 40,
          height: 40,
          child: item.iconPath != null
              ? SvgPicture.asset(
                  item.selectedIconPath!,
                  colorFilter:
                      ColorFilter.mode(theme.primaryColor, BlendMode.srcIn),
                )
              : Icon(
                  item.selectedIcon,
                  color: theme.primaryColor,
                  size: 36,
                ),
        ),
        label: item.label,
      );
    }).toList();
    return Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.elliptical(100, 30),
              topRight: Radius.elliptical(100, 30)),
          color: AppColors.bottomBarColor,
        ),
        child: NavigationBar(
          shadowColor: Colors.transparent,
          overlayColor: WidgetStateColor.transparent,
          surfaceTintColor: Colors.transparent,
          selectedIndex: _selectedIndex,
          onDestinationSelected: _onItemTapped,
          destinations: displayedNavigationItems,
          backgroundColor: Colors.transparent,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          indicatorColor: Colors.transparent,
        ));
  }
}
