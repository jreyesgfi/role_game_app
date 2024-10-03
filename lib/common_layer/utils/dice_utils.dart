import 'dart:math';

int rollDiceTotal(int rolls) {
    int total = 0;
    for (int i = 0; i < rolls; i++) {
      total += Random().nextInt(6) + 1;
    }
    return total;
}