import 'package:flutter/cupertino.dart';

import '../../../core/constants/color_constants.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({this.color = AppColors.white, required this.child, super.key});
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final padding = (width * 0.4).clamp(12.0, 24.0);
    final radius = (width * 0.03).clamp(10.0, 20.0);
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: color,
      ),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: child,
      ),
    );
  }
}
