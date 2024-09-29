import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:role_game_app/domain_layer/entities/adventure_entities.dart';

final adventureProvider =
    StateNotifierProvider<AdventureNotifier, Adventure>((ref) {
  return AdventureNotifier();
});

class Adventure {
  List<AdventureOption> currentOptions;
  List<AdventureOption> historyOfSelections = [];

  Adventure({
    required this.currentOptions,
  });
}

class AdventureNotifier extends StateNotifier<Adventure> {
  AdventureNotifier() : super(Adventure(currentOptions: _initialOptions()));

  // Handle option selection based on the index
  void selectOption(int index) {
    if (index >= 0 && index < state.currentOptions.length) {
      final selectedOption = state.currentOptions[index];

      // Trigger the actions associated with the selected option
      for (final action in selectedOption.actions) {
        action();
      }

      // Add the selected option to the history
      state.historyOfSelections.add(selectedOption);

      // Optionally, update the state to the next options if needed
      // state = Adventure(currentOptions: _nextOptions());
    }
  }

  // Example initial options
  static List<AdventureOption> _initialOptions() {
    return [
      AdventureOption(
        title: 'Explore the Forest',
        body:
            'You head deep into the dark, misty forest. The trees tower overhead, and the forest floor is covered in thick underbrush, making your journey slow and cautious.',
        actions: [() => print('Exploring the forest')],
      ),
      AdventureOption(
        title: 'Climb the Mountain of Endless Heights',
        body:
            'You decide to scale the tall, snow-covered mountain. The journey is long and arduous, with icy winds cutting through your clothing, and the higher you go, the thinner the air becomes.',
        actions: [() => print('Climbing the mountain')],
      ),
      AdventureOption(
        title: 'Swim across the River',
        body:
            'You prepare yourself to swim across the cold, rushing river, knowing that the current is strong and the water icy cold. The river stretches far beyond what you can see.',
        actions: [() => print('Swimming across the river')],
      ),
    ];
  }
}
