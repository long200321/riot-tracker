import 'package:flutter/cupertino.dart';

const SizedBox height10 = SizedBox(height: 10,);
const SizedBox height20 = SizedBox(height: 20,);

enum AppTextSize {
  body_small,
  body_medium,
  body_large,
  heading_small,
  heading_medium,
  heading_large
}

extension AppTextSizeExtension on AppTextSize {
  double get value {
    switch (this) {
      case AppTextSize.body_small:
        return 12;
      case AppTextSize.body_medium:
        return 16;
      case AppTextSize.body_large:
        return 24;
      case AppTextSize.heading_small:
        return 32;
      case AppTextSize.heading_medium:
        return 48;
      case AppTextSize.heading_large:
        return 56;
    }
  }
}
