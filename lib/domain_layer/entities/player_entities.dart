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
    );
  }
}


class PermanentObject {
  String name;
  String type;
  Attributes effects;

  PermanentObject({
    required this.name,
    required this.type,
    required this.effects,
  });
}

class Consumable {
  String name;
  String type;
  Attributes effects;
  int quantity;

  Consumable({
    required this.name,
    required this.type,
    required this.effects,
    required this.quantity,
  });
}

class Player {
  Attributes baseAttributes;
  Attributes modAttributes;
  List<PermanentObject> permanentObjects;
  List<Consumable> consumables;
  List<String> activeSpells;

  Player({
    required this.baseAttributes,
    Attributes? modAttributes, // Allow modAttributes to be optional
    this.permanentObjects = const [],
    this.consumables = const [],
    this.activeSpells = const [],
  }) : modAttributes = modAttributes ?? Attributes(
          strength: 0, 
          dexterity: 0, 
          constitution: 0, 
          intelligence: 0, 
          charisma: 0, 
          luck: 0, 
          magicLevel: 0
        );
}
