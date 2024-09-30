import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:role_game_app/common_layer/theme/app_colors.dart';
import 'package:role_game_app/common_layer/theme/app_theme.dart';
import 'package:role_game_app/presentation_layer/screens.dart/main/adventure_decision/adventure_decision_row.dart';
import 'package:role_game_app/presentation_layer/widgets_common/animation/animated_elevated_button.dart';
import 'package:role_game_app/presentation_layer/widgets_common/animation/entering_animation.dart';
import 'package:role_game_app/presentation_layer/providers/adventure_provider.dart';

class AdventureDecisionSelector extends ConsumerStatefulWidget {
  const AdventureDecisionSelector({super.key});

  @override
  AdventureDecisionSelectorState createState() =>
      AdventureDecisionSelectorState();
}

class AdventureDecisionSelectorState
    extends ConsumerState<AdventureDecisionSelector> {
  int selectedIndex = -1; // Local state to track the selected option

  @override
  Widget build(BuildContext context) {
    // Watch the current adventure from the provider
    final adventure = ref.watch(adventureProvider);

    // Get the AdventureNotifier to call provider methods
    final notifier = ref.read(adventureProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Render each option as an AdventureDecisionRow
        ...List.generate(adventure.currentOptions.length, (index) {
          final option = adventure.currentOptions[index];
          return EntryTransition(
            position: (index % 5) + 4,
            totalAnimations: 10,
            child: AdventureDecisionRow(
              letter: String.fromCharCode(
                  65 + index), // Convert index to letter (A, B, C, ...)
              title: option.title,
              description: option.body,
              selected: index == selectedIndex,
              onTap: () {
                setState(() {
                  // Toggle selection: deselect if the same item is clicked again
                  selectedIndex = (selectedIndex == index) ? -1 : index;
                });
              },
            ),
          );
        }),

        SizedBox(height: 16),

        EntryTransition(
          position: adventure.currentOptions.length % 5 + 5,
          totalAnimations: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomAnimatedButton(
                onPressed: selectedIndex != -1
                    ? () {
                        notifier.selectOption(selectedIndex);
                      }
                    : null, // Disable if no option is selected
                enabledColor: AppColors.primaryColor,
                enabledTextColor: AppColors.whiteColor,
                disabledColor: AppColors.lightGreyColor,
                disabledTextColor: AppColors.greyColor,
                shape: RoundedRectangleBorder(
                  borderRadius: AppTheme.borderRadius,
                ),
                child: const Text('Continue'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
