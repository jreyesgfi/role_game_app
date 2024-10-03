import 'package:flutter/material.dart';
import 'package:role_game_app/domain_layer/entities/enemies_entities.dart';
import 'package:role_game_app/domain_layer/entities/mission_entities.dart';

class AdventureOption {
  final String title;
  final String body;
  final List<VoidCallback> actions;

  AdventureOption({
    required this.title,
    required this.body,
    required this.actions,
  });
}

class Adventure {
  List<AdventureOption> currentOptions;
  List<AdventureOption> historyOfSelections = [];

  Adventure({
    required this.currentOptions,
  });
}

class MonsterMission {
  Monster monster;
  
  
  MonsterMission({
    required this.monster,
  });
}

