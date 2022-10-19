import 'package:flutter/material.dart';

import '../../theme/theme_const.dart';

class PicklisteField extends StatelessWidget {
  final Widget child;
  final bool enabled;
  final bool loading;

  const PicklisteField({
    Key? key,
    required this.child,
    this.enabled = true,
    this.loading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      alignment: Alignment.center,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: enabled ? const Color(kTileBackgroundColor) : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(kTileBorderColor)),
      ),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          child,
          SizedBox(
            height: 3,
            child: loading ? const LinearProgressIndicator() : null,
          ),
        ],
      ),
    );
  }
}
