import 'package:flutter/material.dart';
import 'package:role_game_app/common_layer/theme/app_theme.dart';
import 'package:role_game_app/presentation_layer/screens.dart/settings/setting_elements.dart';
import 'package:role_game_app/presentation_layer/screens.dart/settings/setting_group_card.dart';
import 'package:role_game_app/presentation_layer/widgets_common/animation/entering_animation.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding:
              EdgeInsets.symmetric(horizontal: AppTheme.leftOuterPadding),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return EntryTransition(
                  position: index + 1,
                  child:
                      SettingsGroupWidget(settingGroup: settingsGroups[index]),
                );
              },
              childCount: settingsGroups.length,
            ),
          ),
        )
      ],
    );
  }
}
