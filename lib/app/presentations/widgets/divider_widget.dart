import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({required this.width, super.key});
  final double width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Divider(
        thickness: 2,
      ),
    );
  }
}
