import 'package:flutter/material.dart';

import '../../theme/global_theme.dart';

class PicklisteAppBarTextButton extends StatelessWidget {
  final ValueKey<String>? testKey;
  final String caption;
  final Function() onPressed;
  final bool enabled;

  const PicklisteAppBarTextButton({
    Key? key,
    this.testKey,
    required this.caption,
    required this.onPressed,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 4, 8, 0),
      child: TextButton(
        key: testKey,
        onPressed: enabled ? onPressed : null,
        child: Text(
          caption,
          style: TextStyle(
            color: enabled ? Colors.white : Colors.white38,
            fontSize: PicklisteThemeCreator.kFontSizeMedium,
          ),
        ),
      ),
    );
  }
}
