import 'package:flutter/material.dart';
import 'package:riot_tracker/app/presentations/widgets/text_widget.dart';

import '../../core/constants/color_constants.dart';

class ElevatedButtonWidget extends StatelessWidget {
  const ElevatedButtonWidget({required this.text, required this.onPressesd,super.key});
  final String text;
  final void Function() onPressesd;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressesd();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.red,
      ),
      child: TextWidget(
        text: text,
        color: AppColors.white,
      ),
    );
  }
}
