import 'dart:async';

import 'package:flutter/material.dart';

import '../../theme/global_theme.dart';

class PicklisteToast extends StatefulWidget {
  final ValueKey<String>? testKey;
  final String? textLarge;
  final String? textMedium;
  final String? textDefault;
  final Color color;
  final bool active;
  final int animationDuration;
  final bool startAnimation;
  final int? autoTimeout;
  final Widget child;

  const PicklisteToast({
    Key? key,
    this.textLarge,
    this.textMedium,
    this.textDefault,
    required this.color,
    this.active = true,
    this.animationDuration = 350,
    this.startAnimation = false,
    this.autoTimeout,
    this.testKey,
    required this.child,
  }) : super(key: key);

  @override
  State<PicklisteToast> createState() => _PicklisteToastState();
}

class _PicklisteToastState extends State<PicklisteToast> {
  int _step = 0;
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.active) {
      if (_step == 0) {
        if (widget.startAnimation) {
          WidgetsBinding.instance.addPostFrameCallback((_) => setState(() => _step = 1));
        } else {
          setState(() => _step = 1);
        }
      }

      if (_step == 1 && widget.autoTimeout != null) {
        final timeout = widget.autoTimeout! + (widget.startAnimation ? widget.animationDuration : 0);
        _timer = Timer(Duration(milliseconds: timeout), () => setState(() => _step = 2));
      }
    }

    return Stack(
      children: [
        Column(
          children: [
            // placeholder: schiebt den content der Seite nach unten, um Platz für den Toast zu schaffen
            AnimatedSize(
              duration: Duration(milliseconds: widget.animationDuration),
              child: _container(height: _step == 1 ? null : 0),
            ),
            // content der Seite
            Expanded(child: widget.child),
          ],
        ),
        Column(
          children: [
            // Toast
            AnimatedSlide(
              offset: _step == 1 ? Offset.zero : const Offset(0, -1),
              duration: Duration(milliseconds: widget.animationDuration),
              child: _container(testKey: widget.testKey == null ? null : ValueKey(widget.testKey!.value + (_step == 1 ? '--active' : '--inactive'))),
            ),
          ],
        ),
      ],
    );
  }

  Widget _container({double? height, ValueKey<String>? testKey}) {
    return Container(
      key: testKey,
      width: double.infinity,
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: widget.color,
        border: const Border(bottom: BorderSide(color: Color(PicklisteThemeCreator.kContainerBorderColor))),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _text(widget.textLarge, PicklisteThemeCreator.kFontSizeLarge, '_large'),
          _text(widget.textMedium, PicklisteThemeCreator.kFontSizeMedium, '_medium'),
          _text(widget.textDefault, PicklisteThemeCreator.kFontSizeDefault, '_default'),
        ],
      ),
    );
  }

  Widget _text(String? text, double fontSize, String size) {
    return Visibility(
      visible: text != null,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Text(
          text ?? '',
          key: widget.testKey == null ? null : ValueKey(widget.testKey!.value + size),
          style: TextStyle(fontSize: fontSize),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
