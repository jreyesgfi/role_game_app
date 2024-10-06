import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:role_game_app/domain_layer/entities/player_entities.dart';

final playerProvider = StateNotifierProvider<PlayerNotifier, Player>((ref) {
  return PlayerNotifier();
});

class PlayerNotifier extends StateNotifier<Player> {
  PlayerNotifier()
      : super(Player(
          life: 10,
          level: 0,
          experiencePoints: 0,
          baseAttributes: Attributes(
          strength: 10,
          dexterity: 10,
          constitution: 10,
          intelligence: 10,
          charisma: 10,
          luck: 10,
          magicLevel: 1,
          maxLife: 10,
          burdenCapacity: 5,
        )));


  // Save Resources

  bool equipPermanentObject(PermanentObject object) {
    if (!checkBurdenCapacity(object.weight)){
      return false;
    }
    state = state.equipPermanentObject(object, false);
    applySideEffects(object.otherEffects);
    return true;
  }

  bool saveConsumable(Consumable consumable) {
    if (!checkBurdenCapacity(consumable.quantity)){
      return false;
    }
    state = state.saveConsumable(consumable);
    return true;
  }


  // Consume Resources
  bool disposePermanentObject(PermanentObject object) {
    if(!checkPermanentObjectAvailability(object)){
      return false;
    }
    state = state.equipPermanentObject(object, true);
    return true;
  }

  bool consumeItem(Consumable consumable) {
    if (!checkConsumablesAvailability(consumable)) {
      return false;
    }
    state = state.consumeItem(consumable);
    applySideEffects(consumable.otherEffects);
    return true;
  }



  // Check Resources Methods
  bool checkConsumablesAvailability(Consumable requestedItem) {
    try {
      var ownedItem = state.consumables.firstWhere(
        (item) => item.name == requestedItem.name,
      );

      return ownedItem.quantity >= requestedItem.quantity;
    } catch (e) {
      return false;
    }
  }
  
  bool checkPermanentObjectAvailability(PermanentObject requestedObject) {
    return state.permanentObjects.any((obj) => obj.name == requestedObject.name);
  }

  bool checkBurdenCapacity(int requestedBurden) {
    int totalCapacity = state.baseAttributes.burdenCapacity +
        state.modAttributes.burdenCapacity;
    return totalCapacity >= requestedBurden;
  }



  // Apply side effects
  void applySideEffects(List<VoidCallback> sideEffects) {
    for (int i =0; i < sideEffects.length; i++) {
      sideEffects[i]();
    }
  }
}


