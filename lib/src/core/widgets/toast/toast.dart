import 'package:flutter/material.dart';

import '../theme_const.dart';

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
  }) : super(key: key);

  @override
  State<PicklisteToast> createState() => _PicklisteToastState();
}

class _PicklisteToastState extends State<PicklisteToast> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  bool _hideByTimeout = false;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.animationDuration),
      reverseDuration: Duration(milliseconds: widget.animationReverseDuration),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isActive = widget.active && !_hideByTimeout;

    if (widget.autoTimeout != null && !_hideByTimeout) {
      Future.delayed(Duration(milliseconds: widget.autoTimeout!), () {
        setState(() => _hideByTimeout = true);
      });
    }

    isActive ? _animationController.forward() : _animationController.reverse();

    return SizeTransition(
      sizeFactor: _animationController,
      child: Container(
        key: widget.testKey == null ? null : ValueKey(widget.testKey!.value + (isActive ? '--active' : '--inactive')),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: widget.color,
          border: const Border(bottom: BorderSide(color: Color(kContainerBorderColor))),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildText(context, widget.textLarge, kFontSizeLarge, '_large'),
            _buildText(context, widget.textMedium, kFontSizeMedium, '_medium'),
            _buildText(context, widget.textDefault, kFontSizeDefault, '_default'),
          ],
        ),
      ),
    );
  }

  Widget _buildText(BuildContext context, String? text, double fontSize, String size) {
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
