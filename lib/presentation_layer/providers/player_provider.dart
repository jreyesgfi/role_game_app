import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:role_game_app/domain_layer/entities/player_entities.dart';

class PlayerNotifier extends StateNotifier<Player> {
  PlayerNotifier()
      : super(Player(
            baseAttributes: Attributes(
          strength: 10,
          dexterity: 10,
          constitution: 10,
          intelligence: 10,
          charisma: 10,
          luck: 10,
          magicLevel: 1,
        )));

  // Equipament
  void equipPermanentObject(PermanentObject object, bool disposing) {
    int quantity = disposing ? -1 : 1;
    Attributes updatedAttributes =
        _applyAttributes(state.currentAttributes, object.effects, quantity);
    List<PermanentObject> updatedPermanentObjects = disposing
        ? state.permanentObjects
            .where((obj) => obj.name != object.name)
            .toList()
        : [...state.permanentObjects, object];

    state = Player(
      baseAttributes: state.baseAttributes,
      currentAttributes: updatedAttributes,
      permanentObjects: updatedPermanentObjects,
      consumables: state.consumables,
      activeSpells: state.activeSpells,
    );
  }

  // Items
  void consumeItem(Consumable consumable) {
    if (!checkItemsAvailability(consumable)) {
      return;
    }

    Attributes updatedAttributes = _applyAttributes(
        state.currentAttributes, consumable.effects, consumable.quantity);

    List<Consumable> updatedConsumables = state.consumables
        .map((item) {
          if (item.name == consumable.name) {
            int newQuantity = item.quantity - consumable.quantity;
            if (newQuantity > 0) {
              return Consumable(
                  name: item.name,
                  effects: item.effects,
                  quantity: newQuantity);
            } else {
              return null;
            }
          }
          return item;
        })
        .where((item) => item != null)
        .cast<Consumable>()
        .toList();

    state = Player(
      baseAttributes: state.baseAttributes,
      currentAttributes: updatedAttributes,
      permanentObjects: state.permanentObjects,
      consumables: state.consumables
          .where((item) => item.name != consumable.name)
          .toList(),
      activeSpells: state.activeSpells,
    );
  }

  bool checkItemsAvailability(Consumable requestedItem) {
    try {
      var ownedItem = state.consumables.firstWhere(
        (item) => item.name == requestedItem.name,
      );

      return ownedItem.quantity >= requestedItem.quantity;
    } catch (e) {
      // If the item isn't found, return false
      return false;
    }
  }

  // Helper functions
  Attributes _applyAttributes(
      Attributes original, Attributes change, int quantity) {
    Attributes finalChange = _applyEffects(change, quantity);
    return Attributes(
      strength: original.strength + finalChange.strength,
      dexterity: original.dexterity + finalChange.dexterity,
      constitution: original.constitution + finalChange.constitution,
      intelligence: original.intelligence + finalChange.intelligence,
      charisma: original.charisma + finalChange.charisma,
      luck: original.luck + finalChange.luck,
      magicLevel: original.magicLevel + finalChange.magicLevel,
    );
  }

  Attributes _applyEffects(Attributes attributes, int quantity) {
    return Attributes(
      strength: attributes.strength * quantity,
      dexterity: attributes.dexterity * quantity,
      constitution: attributes.constitution * quantity,
      intelligence: attributes.intelligence * quantity,
      charisma: attributes.charisma * quantity,
      luck: attributes.luck * quantity,
      magicLevel: attributes.magicLevel * quantity,
    );
  }
}

// Provider for the player state using Riverpod
final playerProvider = StateNotifierProvider<PlayerNotifier, Player>((ref) {
  return PlayerNotifier();
});
