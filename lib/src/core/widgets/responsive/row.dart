import 'package:flutter/material.dart';

class PicklisteResponsiveRow extends StatelessWidget {
  final List<Widget> children;

  const PicklisteResponsiveRow({
    Key? key,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Wrap(
        children: children,
      ),
    );
  }
}
