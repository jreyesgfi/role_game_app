import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:role_game_app/common_layer/theme/app_colors.dart';
import 'package:role_game_app/common_layer/theme/app_theme.dart';
import 'package:role_game_app/presentation_layer/providers/scroll_controller_provider.dart';
import 'package:role_game_app/presentation_layer/widgets_common/top_bottom_bars/bottom_navigation.dart';
import 'package:role_game_app/presentation_layer/widgets_common/top_bottom_bars/new_top_bar.dart';

class ScreenWrapper extends ConsumerStatefulWidget {
  final Widget child;

  const ScreenWrapper({super.key, required this.child});

  @override
  ConsumerState<ScreenWrapper> createState() => _ScreenWrapperState();
}

class _ScreenWrapperState extends ConsumerState<ScreenWrapper> {
  @override
  Widget build(BuildContext context) {
    // Retrieve the scroll controller from the provider
    final ScrollController _scrollController = ref.watch(scrollControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.screenBackgroundColor,
      extendBody: true,
      body: Column(
        children: [
          NewTopBar(controller: _scrollController),
          
          // Expanded to ensure the content fills the available space, allows scrolling within child screens
          Expanded(
            child: Container(
              color: AppColors.screenBackgroundColor,
              padding: EdgeInsets.only(
                top: AppTheme.verticalGapUnit*2,
                bottom: 100,
              ),
              child: widget.child,
            ),
          ),
        ],
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}
