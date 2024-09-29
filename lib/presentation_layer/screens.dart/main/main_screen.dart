import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:role_game_app/common_layer/theme/app_theme.dart';
import 'package:role_game_app/presentation_layer/providers/scroll_controller_provider.dart';
import 'package:role_game_app/presentation_layer/screens.dart/main/adventure_decision/adventure_decision_selector.dart';
import 'package:role_game_app/presentation_layer/screens.dart/main/player_stats/player_stats_widget.dart';
import 'package:role_game_app/presentation_layer/widgets_common/animation/entering_animation.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final ScrollController _scrollController =
        ref.watch(scrollControllerProvider);
    return CustomScrollView(controller: _scrollController, slivers: [
      SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: AppTheme.leftOuterPadding),
        sliver: SliverToBoxAdapter(
          child: EntryTransition(
            position: 2,
            child: PlayerStatsWidget(),
          ),
        ),
      ),
      SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: AppTheme.leftOuterPadding),
        sliver: const SliverToBoxAdapter(
          child: AdventureDecisionSelector(),
        ),
      ),
    ]);
  }
}
