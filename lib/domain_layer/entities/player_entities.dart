class Attributes {
  int strength;
  int dexterity;
  int constitution;
  int intelligence;
  int charisma;
  int luck;
  int magicLevel;

  Attributes({
    required this.strength,
    required this.dexterity,
    required this.constitution,
    required this.intelligence,
    required this.charisma,
    required this.luck,
    required this.magicLevel,
  });

  Attributes copy() {
    return Attributes(
      strength: strength,
      dexterity: dexterity,
      constitution: constitution,
      intelligence: intelligence,
      charisma: charisma,
      luck: luck,
      magicLevel: magicLevel,
    );
  }
}

class PermanentObject {
  String name;
  Attributes effects;

  PermanentObject({
    required this.name,
    required this.effects,
  });
}

class Consumable {
  String name;
  Attributes effects;
  int quantity;

  Consumable({
    required this.name,
    required this.effects,
    required this.quantity,
  });
}

class Player {
  Attributes baseAttributes;
  Attributes currentAttributes;
  List<PermanentObject> permanentObjects;
  List<Consumable> consumables;
  List<String> activeSpells;

  Player({
    required this.baseAttributes,
    Attributes? currentAttributes,
    this.permanentObjects = const [],
    this.consumables = const [],
    this.activeSpells = const [],
  }) : currentAttributes = currentAttributes ?? baseAttributes.copy();
}