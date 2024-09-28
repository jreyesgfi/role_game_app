import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:role_game_app/domain_layer/entities/player_entities.dart';

final playerProvider = StateNotifierProvider<PlayerNotifier, Player>((ref) {
  return PlayerNotifier();
});

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
    int multiplier = disposing ? -1 : 1;
    Attributes effects = object.effects * multiplier;
    Attributes updatedModAttributes = state.modAttributes + effects;
    List<PermanentObject> updatedPermanentObjects = disposing
        ? state.permanentObjects
            .where((obj) => obj.name != object.name)
            .toList()
        : [...state.permanentObjects, object];

    state = Player(
      baseAttributes: state.baseAttributes,
      modAttributes: updatedModAttributes,
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

    Attributes effects = consumable.effects * consumable.quantity;
    Attributes updatedModAttributes = state.modAttributes + effects;

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
      modAttributes: updatedModAttributes,
      permanentObjects: state.permanentObjects,
      consumables: updatedConsumables,
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
}


