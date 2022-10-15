import 'package:flutter/material.dart';

import '../theme_const.dart';
import 'field.dart';

class PicklisteTextButton extends StatelessWidget {
  final ValueKey<String>? testKey;
  final String caption;
  final int? number;
  final bool enabled;
  final bool primary;
  final bool danger;
  final bool loading;
  final Function()? onPressed;
  final IconData? icon;

  const PicklisteTextButton({
    Key? key,
    this.testKey,
    required this.caption,
    this.number,
    this.enabled = true,
    this.primary = false,
    this.danger = false,
    this.loading = false,
    this.onPressed,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PicklisteField(
      enabled: enabled,
      loading: loading,
      child: Theme(
        data: Theme.of(context).copyWith(visualDensity: const VisualDensity(vertical: -2)),
        child: TextButton(
          key: testKey,
          onPressed: enabled ? onPressed : null,
          style: TextButton.styleFrom(
            padding: EdgeInsets.fromLTRB(number == null ? 8 : 0, 0, 8, 0),
            backgroundColor: _getBackgroundColor(context),
          ),
          child: Row(
            children: [
              Visibility(
                visible: number != null,
                child: SizedBox(width: 48, child: _buildText(number.toString())),
              ),
              Visibility(
                visible: number != null,
                child: const VerticalDivider(indent: 4, endIndent: 4),
              ),
              Visibility(
                visible: icon != null,
                child: SizedBox(width: 32, child: Icon(icon, color: _getColor(), size: 20)),
              ),
              Flexible(child: _buildText(caption)),
            ],
          ),
        ),
      ),
    );
  }

  Color _getColor() {
    if (primary || danger) {
      return Colors.white;
    }

    return enabled ? Colors.black : const Color(kLabelColor);
  }

  Color _getBackgroundColor(BuildContext context) {
    if (primary) {
      return enabled ? Theme.of(context).primaryColor : Theme.of(context).primaryColor.withOpacity(0.5);
    }

    if (danger) {
      return enabled ? Colors.red : Colors.red.shade200;
    }

    return Colors.transparent;
  }

  Widget _buildText(String text) {
    return Center(
      child: Text(
        text,
        maxLines: 2,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: kFontSizeDefault,
          color: _getColor(),
        ),
      ),
    );
  }
}
