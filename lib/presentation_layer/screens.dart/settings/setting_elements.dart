import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingItem {
  final IconData icon;
  final String label;
  final Function(BuildContext) onTap;

  SettingItem({required this.icon, required this.label, required this.onTap});
}

class SettingGroup {
  final String title;
  final List<SettingItem> items;

  SettingGroup({required this.title, required this.items});
}

final List<SettingGroup> settingsGroups = [
  SettingGroup(
    title: 'Cuenta',
    items: [
      SettingItem(
        icon: Icons.account_circle,
        label: 'Información de la cuenta',
        onTap: (context) {
          // Navigation or action
        },
      ),
      SettingItem(
        icon: Icons.group,
        label: 'Comparte',
        onTap: (context) {
          // Navigation or action
        },
      ),
      SettingItem(
        icon: Icons.backup,
        label: 'Resincronizar',
        onTap: (context) {
          
        },
      ),
      SettingItem(
        icon: Icons.exit_to_app,
        label: 'Cerrar Sesión',
        onTap: (context) {
          
        },
      ),
    ],
  ),
  SettingGroup(
    title: 'Preferencias',
    items: [
      SettingItem(
        icon: Icons.date_range,
        label: 'La semana comienza en',
        onTap: (context) {
          // Navigation or action
        },
      ),
    ],
  ),
];
