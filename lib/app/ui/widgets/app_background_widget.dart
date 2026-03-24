import 'package:flutter/cupertino.dart';
import 'package:riot_tracker/app/core/constants/color_constants.dart';

class AppBackground extends StatelessWidget {
  final Widget child;
  final Gradient? gradient;

  const AppBackground({super.key, required this.child, this.gradient});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient
      ),
      child: child,
    );
  }
}
