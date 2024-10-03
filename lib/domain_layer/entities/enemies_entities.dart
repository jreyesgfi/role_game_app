import 'package:role_game_app/domain_layer/entities/adventure_entities.dart';
import 'package:role_game_app/domain_layer/entities/combat_entities.dart';
import 'package:role_game_app/domain_layer/entities/player_entities.dart';

class Monster {
  String name;
  String description;
  String type;
  int life;
  CombatAttributes combatAttributes;
  int quantity; // Number of monsters in this mission

  Monster({
    required this.name,
    required this.description,
    required this.type,
    required this.life,
    required this.combatAttributes,
    required this.quantity,
  });
}
