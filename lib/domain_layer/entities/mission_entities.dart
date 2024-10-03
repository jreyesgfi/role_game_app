import 'package:role_game_app/domain_layer/entities/combat_entities.dart';
import 'package:role_game_app/domain_layer/entities/enemies_entities.dart';
import 'package:role_game_app/domain_layer/entities/player_entities.dart';

enum PriorityLevel { low, medium, high }
enum MissionType { combat, exploration, gathering, rescue }


class Award {
  List<String> objects;     
  List<String> consumables; 
  int experiencePoints;     
  int gold;                 

  Award({
    this.objects = const [],
    this.consumables = const [],
    this.experiencePoints = 0,
    this.gold = 0,
  });
}


class Mission {
  String title;                       
  String description;                 
  PriorityLevel priorityLevel;        
  MissionType type;                   
  Award award;                        

  Mission({
    required this.title,
    required this.description,
    required this.priorityLevel,
    required this.type,
    required this.award,
  });

  
  void completeMission(Player player) {
    print('Mission "$title" completed! Award: ${award.experiencePoints} XP, ${award.gold} gold.');
    return;
  }

  void failMission(Player player) {
    print('Mission "$title" failed.');
    return;
  }

  bool runMission(Player player) {
    print('Mission "$title" started.');
    return false;
  }
}


class MonsterMission extends Mission {
  Monster monster;

  MonsterMission({
    required this.monster,
    required super.title,
    required super.description,
    required super.priorityLevel,
    required super.award,
    super.type = MissionType.combat,
  });

  @override
  runMission(Player player){
    Player copyPlayer = player.copyWith();
    Combat combat = Combat(copyPlayer, monster);
    return combat.runCombat();
  }
}