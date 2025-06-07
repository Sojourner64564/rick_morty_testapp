import 'package:flutter/material.dart';
import 'package:rick_morty_testapp/core/assets/app_colors.dart';

class AppThemeData{
 static ThemeData darkTheme = ThemeData(
   primarySwatch: Colors.pink,
   brightness: Brightness.dark,
   colorScheme: const ColorScheme.dark(
     primary: AppDarkColors.primaryColor,
     primaryContainer:  AppDarkColors.primaryContainerColor,
     secondary: AppDarkColors.secondaryColor,
     tertiary: AppDarkColors.tertiaryColor,
     errorContainer: AppDarkColors.errorContainerColor,
     scrim: AppDarkColors.bottomBarIndicatorColor,
   ),
);

 static ThemeData lightTheme = ThemeData(
   brightness: Brightness.light,
   colorScheme: const ColorScheme.light(
     primary: AppLightColors.primaryColor,
     primaryContainer:  AppLightColors.primaryContainerColor,
     secondary: AppLightColors.secondaryColor,
     tertiary: AppLightColors.tertiaryColor,
     errorContainer: AppLightColors.errorContainerColor,
     scrim: AppLightColors.bottomBarIndicatorColor,
   ),
);
}