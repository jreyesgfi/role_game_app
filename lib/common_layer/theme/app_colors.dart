import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
  // colors
  static const primaryColor = Color(0xFF103E5E);
  static const secondaryColor = Color(0xFFF1EDB7);
  static const accentColor = Color.fromARGB(255, 241, 225, 0);
  
  // dark
  static const darkColor = Color(0xFF103E5E);
  static const textColor = Color(0xFF103E5E);

  // light
  static Color lightColor = const Color(0xFFF1EDB7);
  static Color greyColor = fadeColor(darkColor);
  static Color lightGreyColor = fadeColor(greyColor);
  static const whiteColor = Color(0xffffffff);
  static const primaryColorLight = Color.fromARGB(237, 244, 245, 255);
  static Color primaryColorFaded = fadeColor(primaryColor);
  static Color secondaryColorFaded = fadeColor(secondaryColor);

  // good bad
  static Color goodColor = const Color.fromARGB(255, 32, 155, 106);
  static Color badColor = const Color.fromARGB(255, 192, 29, 17);


  // transparent
  static Color primaryColorTransparent = transparentColor(primaryColor);
  static Color secondaryColorTransparent = transparentColor(secondaryColor);

  // widgets
  static Color screenBackgroundColor = primaryColorLight;
  static Color widgetBackgroundColor = whiteColor;
  static Color bottomBarColor = widgetBackgroundColor;



  // Method to lighten a color
  static Color fadeColor(Color color) {
    //assert(amount >= 0 && amount <= 1, 'amount must be between 0 and 1');
    final hsl = HSLColor.fromColor(color);
    final lightenedHsl = hsl.withLightness((hsl.lightness + 0.25).clamp(0.0, 1.0));
    return lightenedHsl.toColor();
  }

  // Method to adjust opacity
  static Color transparentColor(Color color) {
    return color.withOpacity((color.opacity * 0.4).clamp(0.0, 1.0));
  }

}