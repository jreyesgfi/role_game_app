import 'dart:math';

import 'package:role_game_app/common_layer/utils/dice_utils.dart';
import 'package:role_game_app/domain_layer/entities/adventure_entities.dart';
import 'package:role_game_app/domain_layer/entities/enemies_entities.dart';
import 'package:role_game_app/domain_layer/entities/mission_entities.dart';
import 'package:role_game_app/domain_layer/entities/player_entities.dart';


CombatAttributes defaultCombatAttributes = CombatAttributes(
         attack: 0,
         defense: 0,
         speed: 0,
         endurance: 0,
);
class CombatAttributes {
  final int attack;
  final int defense;
  final int speed;
  final int endurance;

  CombatAttributes({
    required this.attack,
    required this.defense,
    required this.speed,
    required this.endurance,
  });

  // Multiply operator to scale combat attributes, except endurance
  CombatAttributes operator *(int multiplier) {
    return CombatAttributes(
      attack: attack * multiplier,
      defense: defense * multiplier,
      speed: speed * multiplier,
      endurance: endurance,
    );
  }
}

class Combat {
  Player player;
  Monster monster;
  int monsterRemainingLife;
  int playerRemainingLife;
  int remainingMonsterQuantity;

  Combat(this.player, this.monster)
      : monsterRemainingLife = monster.life,
        playerRemainingLife = player.life,
        remainingMonsterQuantity = monster.quantity;

  // Simulate an offensive step (either player or monster attacks)
  void offensiveStep(bool monsterAttack) {
    // Determine who is attacking and who is defending based on the monsterAttack flag
    CombatAttributes attackerAttributes = monsterAttack
        ? (monster.combatAttributes * monster.quantity)
        : player.combatAttributes;
    CombatAttributes defenderAttributes = monsterAttack
        ? player.combatAttributes
        : (monster.combatAttributes * monster.quantity);

    // Roll dice equal to speed for both attacker and defender
    int attackerRolls = rollDiceTotal(attackerAttributes.speed);
    int defenderRolls = rollDiceTotal(defenderAttributes.speed);

    // Check if the offensive is successful
    if (attackerRolls > defenderRolls) {
      int hitPoints;

      // Check for critical hit
      if (attackerRolls >= 2 * defenderRolls) {
        hitPoints = attackerAttributes.attack;
      } else {
        // Regular hit
        hitPoints =
            max(attackerAttributes.attack - defenderAttributes.defense, 0) + 1;
      }

      // Apply damage to either player or monster
      if (monsterAttack) {
        playerRemainingLife -= hitPoints;
        print(
            'Monster hit Player for $hitPoints damage! Player life: $playerRemainingLife');
      } else {
        monsterRemainingLife -= hitPoints;
        print(
            'Player hit Monster for $hitPoints damage! Monster life: $monsterRemainingLife');

        // If monster's life is reduced to zero, reduce the number of monsters
        if (monsterRemainingLife <= 0) {
          remainingMonsterQuantity--;
          monsterRemainingLife =
              monster.life; // Reset life for the next monster
          print(
              'One monster is defeated! Remaining monsters: $remainingMonsterQuantity');
        }
      }
    } else {
      print(monsterAttack
          ? "Monster's attack missed!"
          : "Player's attack missed!");
    }
  }

  // Simulate the combat rounds
  bool runCombat() {
    // Combat lasts for the max endurance between player and monster
    int rounds = max(
        player.combatAttributes.endurance, monster.combatAttributes.endurance);

    for (int round = 0; round < rounds; round++) {
      bool monsterAttackFirst =
          monster.combatAttributes.speed * monster.quantity >= player.combatAttributes.speed;

      // First attack
      offensiveStep(monsterAttackFirst);
      if (monsterDefeatedCheck()) {
        return true;
      }
      if (playerDefeatedCheck()) {
        return false;
      }

      // Second attack
      offensiveStep(!monsterAttackFirst);
      if (monsterDefeatedCheck()) {
        return true;
      }
      if (playerDefeatedCheck()) {
        return false;
      }
    }
    // Combat ends when rounds are over, player loses if monsters are still alive
    return false;
  }

  // Checks
  bool monsterDefeatedCheck() {
    if (remainingMonsterQuantity == 0) {
      print('All monsters are defeated!');
    }
    return remainingMonsterQuantity == 0;
  }

  bool playerDefeatedCheck() {
    if (playerRemainingLife <= 0) {
      print('Player is defeated!');
    }
    return playerRemainingLife <= 0;
  }
}
