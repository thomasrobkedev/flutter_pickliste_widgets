import 'package:flutter/material.dart';

class PicklisteResponsiveCol extends StatelessWidget {
  final Widget child;
  final double? sm; // width factor (percentage as double) on small viewports, e.g. 320
  final double? md; // width factor (percentage as double) on medium viewports, e.g. 568

  const PicklisteResponsiveCol({
    Key? key,
    required this.child,
    this.sm,
    this.md,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final widthFactor = MediaQuery.of(context).orientation == Orientation.portrait ? (sm ?? 1.0) : (md ?? 0.5);

    return FractionallySizedBox(
      widthFactor: widthFactor * 0.9999, // avoid row breaks caused by pixel rounding errors
      child: child,
    );
  }
}
