import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:role_game_app/presentation_layer/providers/player_provider.dart';
import 'package:role_game_app/presentation_layer/screens.dart/main/player_stats/player_stats_info.dart';
import 'package:role_game_app/presentation_layer/screens.dart/main/player_stats/player_stats_row.dart';

class PlayerStatsWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the playerProvider to get the current player state
    final player = ref.watch(playerProvider);

    // Build the stats UI using the player's baseAttributes and modAttributes
    return Align(
      alignment: Alignment.topLeft,  // Align to the top-left
      child:Column(
      children: [
        StatRow(
          iconPath: statInfo['strength']!['icon']!,
          title: statInfo['strength']!['name']!,
          baseValue: player.baseAttributes.strength,
          modValue: player.modAttributes.strength,
        ),
        StatRow(
          iconPath: statInfo['dexterity']!['icon']!,
          title: statInfo['dexterity']!['name']!,
          baseValue: player.baseAttributes.dexterity,
          modValue: player.modAttributes.dexterity,
        ),
        StatRow(
          iconPath: statInfo['constitution']!['icon']!,
          title: statInfo['constitution']!['name']!,
          baseValue: player.baseAttributes.constitution,
          modValue: player.modAttributes.constitution,
        ),
        StatRow(
          iconPath: statInfo['intelligence']!['icon']!,
          title: statInfo['intelligence']!['name']!,
          baseValue: player.baseAttributes.intelligence,
          modValue: player.modAttributes.intelligence,
        ),
        StatRow(
          iconPath: statInfo['charisma']!['icon']!,
          title: statInfo['charisma']!['name']!,
          baseValue: player.baseAttributes.charisma,
          modValue: player.modAttributes.charisma,
        ),
        StatRow(
          iconPath: statInfo['luck']!['icon']!,
          title: statInfo['luck']!['name']!,
          baseValue: player.baseAttributes.luck,
          modValue: player.modAttributes.luck,
        ),
        StatRow(
          iconPath: statInfo['magicLevel']!['icon']!,
          title: statInfo['magicLevel']!['name']!,
          baseValue: player.baseAttributes.magicLevel,
          modValue: player.modAttributes.magicLevel,
        ),
      ],
    ));
  }
}