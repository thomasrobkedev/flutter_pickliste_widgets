import 'package:flutter/material.dart';

class PicklisteAppBarIconButton extends StatelessWidget {
  final ValueKey<String>? testKey;
  final IconData icon;
  final Function() onPressed;
  final bool enabled;

  const PicklisteAppBarIconButton({
    Key? key,
    this.testKey,
    required this.icon,
    required this.onPressed,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      key: testKey,
      padding: const EdgeInsets.only(right: 8),
      onPressed: enabled ? onPressed : null,
      icon: Icon(
        icon,
        size: 20,
        color: enabled ? Colors.white : Colors.white38,
      ),
    );
  }
}
