import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:role_game_app/common_layer/theme/app_theme.dart';
import 'package:role_game_app/domain_layer/entities/combat_entities.dart';
import 'package:role_game_app/presentation_layer/providers/combat_provider.dart';
import 'package:role_game_app/presentation_layer/providers/scroll_controller_provider.dart';

class CombatScreen extends ConsumerWidget {
  const CombatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final combatState = ref.watch(combatProvider);
    final ScrollController _scrollController = ref.watch(scrollControllerProvider);

    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: AppTheme.leftOuterPadding),
          sliver: SliverToBoxAdapter(
            child: CombatAttributesDisplay(
              title: "Player",
              life: combatState.playerLife,
              attributes: "Player's Stats",
              combatAttributes: ref.watch(combatProvider.notifier).combat.player.combatAttributes,
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: AppTheme.leftOuterPadding),
          sliver: SliverToBoxAdapter(
            child: CombatAttributesDisplay(
              title: "Monster",
              life: combatState.monsterLife,
              attributes: "Monster's Stats",
              combatAttributes: ref.watch(combatProvider.notifier).combat.monster.combatAttributes,
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: AppTheme.leftOuterPadding),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Round ${combatState.round}'),
                Text('Attacker Rolls (${combatState.attackerIsMonster ? 'Monster' : 'Player'}): ${combatState.attackerRolls}'),
                Text('Defender Rolls (${combatState.attackerIsMonster ? 'Player' : 'Monster'}): ${combatState.defenderRolls}'),
                Text('Damage Dealt: ${combatState.hitPoints}'),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: AppTheme.leftOuterPadding),
          sliver: SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    ref.read(combatProvider.notifier).runRound();
                  },
                  child: Text('Continue'),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    ref.read(combatProvider.notifier).surrender();
                  },
                  child: Text('Surrender'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CombatAttributesDisplay extends StatelessWidget {
  final String title;
  final int life;
  final String attributes;
  final CombatAttributes combatAttributes;

  const CombatAttributesDisplay({
    Key? key,
    required this.title,
    required this.life,
    required this.attributes,
    required this.combatAttributes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.bodyLarge),
            Text('Life: $life'),
            SizedBox(height: 8),
            Text('Attack: ${combatAttributes.attack}'),
            Text('Defense: ${combatAttributes.defense}'),
            Text('Speed: ${combatAttributes.speed}'),
            Text('Endurance: ${combatAttributes.endurance}'),
          ],
        ),
      ),
    );
  }
}
