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
  final int duration;
  final int showDelay;
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
    this.duration = 350,
    this.showDelay = 100,
    this.autoTimeout,
    this.testKey,
    this.scrollView = true,
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
        /// slide in
        Future.delayed(Duration(milliseconds: widget.showDelay), (() => setState(() => _step = 1)));
      } else if (_step == 1 && widget.autoTimeout != null) {
        /// slide out
        _timer = Timer(Duration(milliseconds: widget.autoTimeout!), () => setState(() => _step = 2));
      }
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
              offset: _step == 1 ? Offset.zero : const Offset(0, -1),
              duration: Duration(milliseconds: widget.duration),
              child: _container(testKey: widget.testKey == null ? null : ValueKey(widget.testKey!.value + (_step == 1 ? '--active' : '--inactive'))),
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
          duration: Duration(milliseconds: widget.duration),
          child: _container(height: _step == 1 ? null : 0),
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
