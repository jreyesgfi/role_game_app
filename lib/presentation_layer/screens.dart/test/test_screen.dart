import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:role_game_app/common_layer/theme/app_theme.dart';
import 'package:role_game_app/presentation_layer/widgets_common/animation/entering_animation.dart';

class TestScreen extends ConsumerWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProviderScope(
      child: _TestScreenContent(),
    );
  }
}

class _TestScreenContent extends ConsumerStatefulWidget {
  @override
  _TestScreenContentState createState() => _TestScreenContentState();
}

class _TestScreenContentState extends ConsumerState<_TestScreenContent>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CustomScrollView(slivers: [
      SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: AppTheme.leftOuterPadding),
        sliver: SliverToBoxAdapter(
          child: EntryTransition(
            position: 2,
            child: Container(
              width: 200,
              height: 100,
              color: theme.primaryColor,
              alignment: Alignment.center,
              child: const Text(
                'TestWidget1',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      )
    ]);
  }
}
