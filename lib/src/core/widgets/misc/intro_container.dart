import 'package:flutter/material.dart';

import '../../theme/global_theme.dart';
import '../responsive/row.dart';

class PicklisteIntroContainer extends StatelessWidget {
  final ValueKey<String>? testKey;
  final Widget child;
  final EdgeInsets? padding;

  const PicklisteIntroContainer({
    required this.child,
    this.padding,
    this.testKey,
    super.key,
  });

  PicklisteIntroContainer.withResponsiveCols({
    required List<Widget> children,
    Key? key,
  }) : this(
          key: key,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: PicklisteResponsiveRow(children: children),
        );

  PicklisteIntroContainer.withTextOnly({
    required String text,
    ValueKey<String>? testKey,
    Key? key,
  }) : this(
          key: key,
          child: Text(
            text,
            key: testKey,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: PicklisteThemeCreator.kFontSizeMedium),
          ),
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Color(PicklisteThemeCreator.kMenuBackgroundColor),
        border: Border(bottom: BorderSide(color: Color(PicklisteThemeCreator.kContainerBorderColor))),
      ),
      child: child,
    );
  }
}
