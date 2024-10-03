import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:role_game_app/domain_layer/entities/combat_entities.dart';
import 'package:role_game_app/domain_layer/entities/enemies_entities.dart';
import 'package:role_game_app/domain_layer/entities/player_entities.dart';
import 'package:role_game_app/presentation_layer/providers/player_provider.dart';

// Combat provider setup, using PlayerProvider and a test Monster instance
final combatProvider = StateNotifierProvider<CombatNotifier, CombatState>((ref) {
  // Get player from PlayerProvider
  final player = ref.read(playerProvider);

  // Manually create a monster instance for testing
  final monster = Monster(
    name: "Goblin",
    description: "A small, green creature with sharp teeth.",
    type: "Beast",
    life: 50,
    combatAttributes: CombatAttributes(
      attack: 15,
      defense: 5,
      speed: 5,
      endurance: 4,
    ),
    quantity: 1,
  );

  // Initialize CombatNotifier with player and test monster
  return CombatNotifier(player: player, monster: monster);
});

class CombatNotifier extends StateNotifier<CombatState> {
  late Combat combat;
  int round = 0;
  bool isMonsterAttacking = false;

  CombatNotifier({
    required Player player,
    required Monster monster,
  }) : super(CombatState.initial()) {
    combat = Combat(player, monster);
  }

  void startCombat() {
    round = 0;
    state = state.copyWith(
      playerLife: combat.playerRemainingLife,
      monsterLife: combat.monsterRemainingLife,
      remainingMonsters: combat.remainingMonsterQuantity,
    );
  }

  // Handles advancing through combat rounds
  void runRound() {
    round++;
    isMonsterAttacking = !isMonsterAttacking; // Toggle who attacks first each round

    // First offensive step
    combat.offensiveStep(isMonsterAttacking);

    state = state.copyWith(
      playerLife: combat.playerRemainingLife,
      monsterLife: combat.monsterRemainingLife,
      round: round,
      attackerRolls: combat.attackerRolls,
      defenderRolls: combat.defenderRolls,
      hitPoints: combat.hitPoints,
      attackerIsMonster: isMonsterAttacking, // Pass the current attacker to the state
    );

    // Check if combat is finished
    if (combat.playerDefeatedCheck()) {
      endCombat(false); // Player loses
    } else if (combat.monsterDefeatedCheck()) {
      endCombat(true); // Player wins
    }
  }

  void surrender() {
    // Handle surrender logic
    state = state.copyWith(hasSurrendered: true);
    endCombat(false);
  }

  void endCombat(bool success) {
    state = state.copyWith(
      combatEnded: true,
      playerWon: success,
    );
  }
}

class CombatState {
  final int playerLife;
  final int monsterLife;
  final int remainingMonsters;
  final int round;
  final int attackerRolls;
  final int defenderRolls;
  final int hitPoints;
  final bool combatEnded;
  final bool playerWon;
  final bool hasSurrendered;
  final bool attackerIsMonster;

  CombatState({
    required this.playerLife,
    required this.monsterLife,
    required this.remainingMonsters,
    required this.round,
    required this.attackerRolls,
    required this.defenderRolls,
    required this.hitPoints,
    required this.combatEnded,
    required this.playerWon,
    required this.hasSurrendered,
    required this.attackerIsMonster,
  });

  factory CombatState.initial() {
    return CombatState(
      playerLife: 100,
      monsterLife: 100,
      remainingMonsters: 1,
      round: 0,
      attackerRolls: 0,
      defenderRolls: 0,
      hitPoints: 0,
      combatEnded: false,
      playerWon: false,
      hasSurrendered: false,
      attackerIsMonster: false, // Initially set to false, assuming the player attacks first
    );
  }

  CombatState copyWith({
    int? playerLife,
    int? monsterLife,
    int? remainingMonsters,
    int? round,
    int? attackerRolls,
    int? defenderRolls,
    int? hitPoints,
    bool? combatEnded,
    bool? playerWon,
    bool? hasSurrendered,
    bool? attackerIsMonster,
  }) {
    return CombatState(
      playerLife: playerLife ?? this.playerLife,
      monsterLife: monsterLife ?? this.monsterLife,
      remainingMonsters: remainingMonsters ?? this.remainingMonsters,
      round: round ?? this.round,
      attackerRolls: attackerRolls ?? this.attackerRolls,
      defenderRolls: defenderRolls ?? this.defenderRolls,
      hitPoints: hitPoints ?? this.hitPoints,
      combatEnded: combatEnded ?? this.combatEnded,
      playerWon: playerWon ?? this.playerWon,
      hasSurrendered: hasSurrendered ?? this.hasSurrendered,
      attackerIsMonster: attackerIsMonster ?? this.attackerIsMonster,
    );
  }
}
