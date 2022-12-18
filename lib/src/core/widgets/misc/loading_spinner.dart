import 'package:flutter/material.dart';

import '../../theme/global_theme.dart';

class PicklisteLoadingSpinner extends StatelessWidget {
  final Color? color;

  const PicklisteLoadingSpinner({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color ?? const Color(PicklisteThemeCreator.kThemePrimaryColor),
      ),
    );
  }
}
