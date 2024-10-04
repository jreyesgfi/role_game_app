import 'dart:math';

import 'package:flutter/material.dart';
import 'package:role_game_app/domain_layer/entities/combat_entities.dart';
import 'package:role_game_app/domain_layer/entities/mission_entities.dart';

class Attributes {
  int strength;
  int dexterity;
  int constitution;
  int intelligence;
  int charisma;
  int luck;
  int magicLevel;
  int maxLife;
  int burdenCapacity;

  Attributes({
    required this.strength,
    required this.dexterity,
    required this.constitution,
    required this.intelligence,
    required this.charisma,
    required this.luck,
    required this.magicLevel,
    required this.maxLife,
    required this.burdenCapacity,
  });

  // Multiplication by an int (for scaling effects)
  Attributes operator *(int multiplier) {
    return Attributes(
      strength: strength * multiplier,
      dexterity: dexterity * multiplier,
      constitution: constitution * multiplier,
      intelligence: intelligence * multiplier,
      charisma: charisma * multiplier,
      luck: luck * multiplier,
      magicLevel: magicLevel * multiplier,
      maxLife: maxLife * multiplier,
      burdenCapacity: burdenCapacity * multiplier,
    );
  }

  // Addition (adding two Attributes instances)
  Attributes operator +(Attributes other) {
    return Attributes(
      strength: strength + other.strength,
      dexterity: dexterity + other.dexterity,
      constitution: constitution + other.constitution,
      intelligence: intelligence + other.intelligence,
      charisma: charisma + other.charisma,
      luck: luck + other.luck,
      magicLevel: magicLevel + other.magicLevel,
      maxLife: maxLife + other.maxLife,
      burdenCapacity: burdenCapacity + other.burdenCapacity,
    );
  }
}

final defaultAttributes = Attributes(
  strength: 0,
  dexterity: 0,
  constitution: 0,
  intelligence: 0,
  charisma: 0,
  luck: 0,
  magicLevel: 0,
  maxLife: 0,
  burdenCapacity: 0,
);

class PermanentObject {
  String name;
  String type;
  int weight;
  Attributes effects;
  List<VoidCallback> otherEffects;

  PermanentObject({
    required this.name,
    required this.type,
    required this.weight,
    Attributes? effects,
    this.otherEffects = const [],
  }) : effects = effects ?? defaultAttributes;
}

class Consumable {
  String name;
  String type;
  int lifeEffect;
  Attributes attributesEffects;
  List<VoidCallback> otherEffects;
  int quantity;

  Consumable({
    required this.name,
    required this.type,
    this.lifeEffect = 0,
    Attributes? attributesEffects,
    this.otherEffects = const [],
    required this.quantity,
  }) : attributesEffects = attributesEffects ?? defaultAttributes;

  Consumable? adjustQuantity(int quantityChange) {
    if (quantityChange > 0) {
      return copyWith(quantity: this.quantity + quantityChange);
    }
    if (quantity + quantityChange == 0) {
      return null;
    }
    throw Exception('Cannot have negative quantity');
  }

  Consumable copyWith({
    String? name,
    String? type,
    int? lifeEffect,
    Attributes? attributesEffects,
    List<VoidCallback>? otherEffects,
    int? quantity,
  }) {
    return Consumable(
      name: name ?? this.name,
      type: type ?? this.type,
      lifeEffect: lifeEffect ?? this.lifeEffect,
      attributesEffects: attributesEffects ?? this.attributesEffects,
      otherEffects: otherEffects ?? this.otherEffects,
      quantity: quantity ?? this.quantity,
    );
  }
}

class Player {
  int _life;
  int _experiencePoints;
  Attributes baseAttributes;
  Attributes modAttributes;
  CombatAttributes modCombatAttributes;
  List<PermanentObject> permanentObjects;
  List<Consumable> consumables;
  List<String> activeSpells;

  Player({
    required int life,
    required int experiencePoints,
    required this.baseAttributes,
    Attributes? modAttributes,
    CombatAttributes? modCombatAttributes,
    this.permanentObjects = const [],
    this.consumables = const [],
    this.activeSpells = const [],
  })  : _life = life,
        _experiencePoints = experiencePoints,
        modAttributes = modAttributes ?? defaultAttributes,
        modCombatAttributes = modCombatAttributes ?? defaultCombatAttributes;

  /////////////
  // Setters
  /////////////
  set life(int value) {
    _life = value;
    if (_life <= 0) {
      playerDefeated();
    }
  }

  set experiencePoints(int value) {
    _experiencePoints += value;
    checkLevelUp();
  }


  /////////////
  // Copy
  /////////////

  Player copyWith({
    int? life,
    int? experiencePoints,
    Attributes? baseAttributes,
    Attributes? modAttributes,
    CombatAttributes? modCombatAttributes,
    List<PermanentObject>? permanentObjects,
    List<Consumable>? consumables,
    List<String>? activeSpells,
  }) {
    return Player(
      life: life ?? this.life,
      experiencePoints: experiencePoints ?? this.experiencePoints,
      baseAttributes: baseAttributes ?? this.baseAttributes,
      modAttributes: modAttributes ?? this.modAttributes,
      modCombatAttributes: modCombatAttributes ?? this.modCombatAttributes,
      permanentObjects: permanentObjects ?? this.permanentObjects,
      consumables: consumables ?? this.consumables,
      activeSpells: activeSpells ?? this.activeSpells,
    );
  }

  ///////////////
  // Getters
  ///////////////
  Attributes get totalAttributes => baseAttributes + modAttributes;

  CombatAttributes get combatAttributes => CombatAttributes(
        attack: baseAttributes.strength + modCombatAttributes.attack,
        defense: baseAttributes.constitution + modCombatAttributes.defense,
        speed: baseAttributes.dexterity + modCombatAttributes.speed,
        endurance: baseAttributes.constitution + modCombatAttributes.endurance,
      );


  /////////////
  // Change the player state
  /////////////
  void playerDefeated() {
    print('Player is defeated!');
    // Add logic for handling player defeat (e.g., restarting combat, game over, etc.)
  }

  void checkLevelUp() {
    while (_experiencePoints >= experienceForNextLevel[level]!) {
      _experiencePoints -= experienceForNextLevel[level]!;
      levelUp();
    }
  }

  void levelUp() {
    level++;
    print('Player leveled up to $level!');
    // Additional logic for level-up bonuses can be added here.
  }

  ///////////////
  // Save Resources
  ///////////////

  Player equipPermanentObject(PermanentObject object, bool disposing) {
    int multiplier = disposing ? -1 : 1;
    Attributes updatedModAttributes =
        modAttributes + (object.effects * multiplier);

    List<PermanentObject> updatedPermanentObjects = disposing
        ? permanentObjects.where((obj) => obj.name != object.name).toList()
        : [...permanentObjects, object];

    return copyWith(
      modAttributes: updatedModAttributes,
      permanentObjects: updatedPermanentObjects,
    );
  }

  Player saveConsumable(Consumable consumable) {
    List<Consumable> updatedConsumables = consumables.map((item) {
      if (item.name == consumable.name) {
        return item.adjustQuantity(consumable.quantity)!;
      }
      return item;
    }).toList();

    // If consumable is not in the list, add it
    if (!updatedConsumables.any((item) => item.name == consumable.name)) {
      updatedConsumables.add(consumable);
    }

    return copyWith(consumables: updatedConsumables);
  }

  ///////////////
  // Consume Resources
  ///////////////

  Player consumeItem(Consumable consumable) {
    // stats
    Attributes updatedModAttributes =
        modAttributes + (consumable.attributesEffects * consumable.quantity);

    // life
    int newMaxLife = baseAttributes.maxLife + updatedModAttributes.maxLife;
    int newLife = min(
      newMaxLife,
      life + (consumable.lifeEffect * consumable.quantity),
    );

    // new list of consumables
    List<Consumable> updatedConsumables = consumables
        .map((item) {
          if (item.name == consumable.name) {
            return item.adjustQuantity(-consumable.quantity);
          }
          return item;
        })
        .where((item) => item != null)
        .cast<Consumable>()
        .toList();

    return copyWith(
      life: newLife,
      modAttributes: updatedModAttributes,
      consumables: updatedConsumables,
    );
  }
}
