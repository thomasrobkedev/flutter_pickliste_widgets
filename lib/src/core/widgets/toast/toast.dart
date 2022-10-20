import 'dart:async';

import 'package:flutter/material.dart';

import '../../theme/theme_const.dart';

class PicklisteToast extends StatefulWidget {
  final ValueKey<String>? testKey;
  final String? textLarge;
  final String? textMedium;
  final String? textDefault;
  final Color color;
  final bool active;
  final int animationDuration;
  final int animationReverseDuration;
  final int? autoTimeout;
  final bool scrollView;
  final Widget child;

  const PicklisteToast({
    Key? key,
    this.textLarge,
    this.textMedium,
    this.textDefault,
    required this.color,
    this.active = true,
    this.animationDuration = 350,
    this.animationReverseDuration = 350,
    this.autoTimeout,
    this.testKey,
    this.scrollView = true,
    required this.child,
  }) : super(key: key);

  @override
  State<PicklisteToast> createState() => _PicklisteToastState();
}

class _PicklisteToastState extends State<PicklisteToast> {
  bool _hideByTimeout = false;
  Timer? timer;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isVisible = widget.active && !_hideByTimeout;

    if (widget.autoTimeout != null && !_hideByTimeout) {
      timer = Timer(Duration(milliseconds: widget.autoTimeout!), () => setState(() => _hideByTimeout = true));
    }

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Positioned.fill(
          child: widget.scrollView //
              ? SingleChildScrollView(child: _content())
              : _content(),
        ),
        Column(
          children: [
            AnimatedSlide(
              offset: isVisible ? Offset.zero : const Offset(0, -1),
              duration: Duration(milliseconds: widget.animationReverseDuration),
              child: _container(testKey: widget.testKey == null ? null : ValueKey(widget.testKey!.value + (isVisible ? '--active' : '--inactive'))),
            ),
          ],
        ),
      ],
    );
  }

  Widget _content() {
    return Column(
      children: [
        AnimatedSize(
          duration: Duration(milliseconds: widget.animationReverseDuration),
          child: _container(height: widget.active && !_hideByTimeout ? null : 0),
        ),
        widget.child,
      ],
    );
  }

  Container _container({double? height, ValueKey<String>? testKey}) {
    return Container(
      key: testKey,
      width: double.infinity,
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: widget.color,
        border: const Border(bottom: BorderSide(color: Color(PicklisteThemeConstants.kContainerBorderColor))),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _text(widget.textLarge, PicklisteThemeConstants.kFontSizeLarge, '_large'),
          _text(widget.textMedium, PicklisteThemeConstants.kFontSizeMedium, '_medium'),
          _text(widget.textDefault, PicklisteThemeConstants.kFontSizeDefault, '_default'),
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
