import 'package:flutter/material.dart';

import '../../core/constants/color_constants.dart';
import '../../core/constants/size_constant.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final AppTextSize size;
  final Color color;
  final FontWeight fontWeight;
  final double letterSpacing;

  const TextWidget({
    required this.text,
    this.size = AppTextSize.body_small,
    this.color = AppColors.black,
    this.fontWeight = FontWeight.normal,
    this.letterSpacing = 0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      overflow: TextOverflow.ellipsis,
      text,
      maxLines: 1,
      softWrap: true,
      style: TextStyle(
        letterSpacing: letterSpacing,
        fontFamily: "FrizQuadrata",
        fontSize: size.value,
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }
}

