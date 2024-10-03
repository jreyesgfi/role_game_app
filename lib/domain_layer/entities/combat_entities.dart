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
  final Player player;
  final Monster monster;
  int monsterRemainingLife;
  int playerRemainingLife;
  int remainingMonsterQuantity;

  // Track rolls and hit points for reporting purposes
  int _attackerRolls = 0;
  int _defenderRolls = 0;
  int _hitPoints = 0;

  Combat(this.player, this.monster)
      : monsterRemainingLife = monster.life,
        playerRemainingLife = player.life,
        remainingMonsterQuantity = monster.quantity;

  // Public getters for combat results, useful for UI
  int get attackerRolls => _attackerRolls;
  int get defenderRolls => _defenderRolls;
  int get hitPoints => _hitPoints;

  // Simulate an offensive step (either player or monster attacks)
  void offensiveStep(bool monsterAttack) {
    // Determine attacker and defender attributes based on the attack flag
    CombatAttributes attackerAttributes = monsterAttack
        ? (monster.combatAttributes * remainingMonsterQuantity)
        : player.combatAttributes;
    CombatAttributes defenderAttributes = monsterAttack
        ? player.combatAttributes
        : (monster.combatAttributes * remainingMonsterQuantity);

    // Roll dice equal to speed for both attacker and defender
    _attackerRolls = rollDiceTotal(attackerAttributes.speed);
    _defenderRolls = rollDiceTotal(defenderAttributes.speed);

    // Check if the offensive is successful
    if (_attackerRolls > _defenderRolls) {
      // Calculate hit points based on critical hit or regular hit
      if (_attackerRolls >= 2 * _defenderRolls) {
        _hitPoints = attackerAttributes.attack;
      } else {
        _hitPoints =
            max(attackerAttributes.attack - defenderAttributes.defense, 0) + 1;
      }

      // Apply damage to the respective party
      if (monsterAttack) {
        playerRemainingLife -= _hitPoints;
        print(
            'Monster hit Player for $_hitPoints damage! Player life: $playerRemainingLife');
      } else {
        monsterRemainingLife -= _hitPoints;
        print(
            'Player hit Monster for $_hitPoints damage! Monster life: $monsterRemainingLife');

        // If monster's life is reduced to zero, reduce monster quantity
        if (monsterRemainingLife <= 0) {
          remainingMonsterQuantity--;
          monsterRemainingLife = monster.life; // Reset life for next monster
          print(
              'One monster is defeated! Remaining monsters: $remainingMonsterQuantity');
        }
      }
    } else {
      _hitPoints = 0;
      print(monsterAttack
          ? "Monster's attack missed!"
          : "Player's attack missed!");
    }
  }

  // Run a single round of combat
  bool runRound(bool monsterAttackFirst) {
    offensiveStep(monsterAttackFirst);
    if (monsterDefeatedCheck()) {
      return true;
    }
    if (playerDefeatedCheck()) {
      return false;
    }

    // Second attack if combat hasn't ended
    offensiveStep(!monsterAttackFirst);
    return monsterDefeatedCheck() || playerDefeatedCheck();
  }

  // Checks if the monster is defeated
  bool monsterDefeatedCheck() {
    if (remainingMonsterQuantity == 0) {
      print('All monsters are defeated!');
    }
    return remainingMonsterQuantity == 0;
  }

  // Checks if the player is defeated
  bool playerDefeatedCheck() {
    if (playerRemainingLife <= 0) {
      print('Player is defeated!');
    }
    return playerRemainingLife <= 0;
  }
}
