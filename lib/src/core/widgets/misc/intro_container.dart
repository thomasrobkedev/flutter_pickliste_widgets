import 'package:flutter/material.dart';

import '../../theme/theme_const.dart';

class PicklisteIntroContainer extends StatelessWidget {
  final ValueKey<String>? testKey;
  final Widget child;
  final EdgeInsets? padding;

  const PicklisteIntroContainer({
    required this.child,
    this.padding,
    this.testKey,
    Key? key,
  }) : super(key: key);

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
            style: const TextStyle(fontSize: kFontSizeMedium),
          ),
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Color(kMenuBackgroundColor),
        border: Border(bottom: BorderSide(color: Color(kContainerBorderColor))),
      ),
      child: child,
    );
  }
}
