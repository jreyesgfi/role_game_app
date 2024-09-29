import 'package:flutter/material.dart';

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