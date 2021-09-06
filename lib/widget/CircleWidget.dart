import 'package:flutter/material.dart';

class CircleWidget extends StatelessWidget {
  final color;
  final diameter;
  final margin;

  const CircleWidget({
    Key? key,
    @required this.color,
    @required this.diameter,
    this.margin: EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: this.margin,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: SizedBox(
        height: diameter.toDouble(),
        width: diameter.toDouble(),
      ),
    );
  }
}
