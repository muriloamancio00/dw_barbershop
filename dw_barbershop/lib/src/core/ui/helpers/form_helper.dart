import 'package:flutter/material.dart';

void unfocus(BuildContext context) => FocusScope.of(context).unfocus();

extension UnFocusExtension on BuildContext{
  void unfocus() => Focus.of(this).unfocus();
}