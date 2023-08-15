
import 'package:flutter/material.dart';
import 'package:dw_barbershop/src/core/ui/constants.dart';

sealed class BarbershopTheme {

  static const _defaltInputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        borderSide: BorderSide(color: ColorsConstants.grey),
      );
  
  static ThemeData themeData = ThemeData(
    useMaterial3: true,
    inputDecorationTheme:  InputDecorationTheme(
      filled: true,
      // cor de fundo input
      fillColor: Colors.white,
      labelStyle: const TextStyle(color: ColorsConstants.grey),
      border: _defaltInputBorder,
      enabledBorder: _defaltInputBorder,
      focusedBorder: _defaltInputBorder,
      errorBorder: _defaltInputBorder.copyWith(
        borderSide: const BorderSide(
          color: ColorsConstants.red
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorsConstants.brow,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    fontFamily: FontConstants.fontFamily,
  );

}