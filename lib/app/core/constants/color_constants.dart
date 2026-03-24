import 'package:flutter/material.dart';

class AppColors {
  static const Color white = Color(0xFFF3F3F3);
  static const Color yellow = Color(0xFFF3D897);
  static const Color black = Color(0xFF1E2022);
  static const Color red = Color(0xFFCE3424);
  static const Color grey = Color(0xFFBCBEBE);
  static const Color blue = Color(0xFF1D7696);

  static const LinearGradient lightGradient = LinearGradient(
    colors: [white, yellow],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkGradient = LinearGradient(
    colors: [grey, black],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
