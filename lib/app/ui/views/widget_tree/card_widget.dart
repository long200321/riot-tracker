import 'package:flutter/cupertino.dart';

import '../../../core/constants/color_constants.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({this.color = AppColors.white, required this.child, super.key});
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: color,
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: child
      ),
    );
  }
}
