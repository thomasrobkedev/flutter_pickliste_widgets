import 'dart:async';

import 'package:flutter/material.dart';

import '../../enums/mde_notification_type.dart';
import '../../enums/testkey.dart';
import '../../theme/global_theme.dart';
import 'data.dart';
import 'type_info.dart';

enum PicklisteFlushBarType { information, confirmation, question }

enum PicklisteFlushBarReturnValue { userTap, timerExpired, anotherFlushBarStarted, hideRequest, willPopScope, answerOk, answerCancel }

class PicklisteFlushBar {
  final PicklisteFlushBarType _flushBarType;
  final BuildContext _context;
  final String _message;
  final MdeNotificationType _type;
  final int? _autoCloseTimeout;
  final String _okText;
  final String _cancelText;
  final ValueKey<String>? _testKey;

  static Timer? _timer;
  static Function? _onHideCallBack;
  static BuildContext? _activeContext;

  PicklisteFlushBar(this._flushBarType, this._context, this._message, this._type, this._autoCloseTimeout, this._okText, this._cancelText, this._testKey);

  PicklisteFlushBar.information({
    required BuildContext context,
    required String message,
    MdeNotificationType? type,
    int? autoCloseTimeout,
    ValueKey<String>? testKey,
    required String okText,
    required String cancelText,
  }) : this(PicklisteFlushBarType.information, context, message, type ?? MdeNotificationType.info, autoCloseTimeout, okText, cancelText, testKey);

  PicklisteFlushBar.confirmation({
    required BuildContext context,
    required String message,
    MdeNotificationType? type,
    required String okText,
    required String cancelText,
    ValueKey<String>? testKey,
  }) : this(PicklisteFlushBarType.confirmation, context, message, type ?? MdeNotificationType.info, 0, okText, cancelText, testKey);

  PicklisteFlushBar.question({
    required BuildContext context,
    required String message,
    required String yesText,
    required String noText,
    ValueKey<String>? testKey,
  }) : this(PicklisteFlushBarType.question, context, message, MdeNotificationType.question, 0, yesText, noText, testKey);

  PicklisteFlushBar.criticalError({
    required BuildContext context,
    required String message,
    required String yesText,
    required String noText,
    ValueKey<String>? testKey,
  }) : this(PicklisteFlushBarType.question, context, message, MdeNotificationType.error, 0, yesText, noText, testKey);

  PicklisteFlushBar.fromData({
    required BuildContext context,
    required PicklisteFlushBarData data,
  }) : this(data.flushBarType!, context, data.message ?? data.messageCallback!(context), data.type ?? MdeNotificationType.info, data.autoCloseTimeout, data.okText, data.cancelText, data.testKey);

  Future<PicklisteFlushBarReturnValue?> show() async {
    // Hier muss ein Aufruf hin, der dafür sorgt, dass _build(context) (siehe unten) nicht innerhalb eines _build() vom aufrufendem Rendern der Page
    // aufgerufen wird. Die Einfachste Möglichekti die wir gefunden haben war ein "Wait 0"
    await Future.delayed(Duration.zero);

    _reset(PicklisteFlushBarReturnValue.anotherFlushBarStarted);
    _activeContext = _context;

    if (_flushBarType == PicklisteFlushBarType.information) {
      int? seconds;

      if (_autoCloseTimeout == null) {
        seconds = null;
      } else {
        seconds = _autoCloseTimeout! > 0 ? _autoCloseTimeout! : null;
      }

      _timer = seconds == null ? null : Timer(Duration(seconds: seconds), () => _reset(PicklisteFlushBarReturnValue.timerExpired));
    }

    return await showModalBottomSheet<PicklisteFlushBarReturnValue>(
      context: _context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      builder: (BuildContext context) => _build(context), //<- führt zu Fehlern, wenn das synchron innerhalb eines umschließeneden _build() aufgerufen wird
    );
  }

  static void _reset(PicklisteFlushBarReturnValue value) {
    if (_activeContext != null) {
      _timer?.cancel();
      Navigator.pop(_activeContext!, value);
      _activeContext = null;
      if (_onHideCallBack != null) {
        // ignore: avoid_dynamic_calls
        _onHideCallBack!();
        _onHideCallBack = null;
      }
    }
  }

  static void hide() {
    _reset(PicklisteFlushBarReturnValue.hideRequest);
  }

  static bool isActive() {
    return _activeContext != null;
  }

  static void setOnHideCallBack(Function func) {
    _onHideCallBack = func;
  }

  Widget _build(BuildContext context) {
    final color = appFlushBarTypeInfos[_type]!.color;
    final icon = appFlushBarTypeInfos[_type]!.icon;
    final maxHeight = MediaQuery.of(context).size.height * 9 / 16;

    return GestureDetector(
      onTap: _flushBarType == PicklisteFlushBarType.information ? () => _reset(PicklisteFlushBarReturnValue.userTap) : null,
      child: WillPopScope(
        onWillPop: () async {
          _reset(PicklisteFlushBarReturnValue.willPopScope);
          return false;
        },
        child: Container(
          key: _testKey ?? ValueKey(PicklisteTestkey.flushBar.toString()),
          padding: const EdgeInsets.all(12),
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 12, 16, 12),
                        constraints: BoxConstraints(
                          minHeight: 72,
                          maxHeight: maxHeight - (_flushBarType == PicklisteFlushBarType.information ? 0 : 48),
                        ),
                        child: Row(
                          children: [
                            Icon(icon, size: 32, color: color),
                            const SizedBox(width: 20),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Text(_message, style: TextStyle(fontSize: PicklisteThemeCreator.kFontSizeMedium, color: color)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ..._flushBarType == PicklisteFlushBarType.confirmation
                          ? [
                              const Divider(color: Color(PicklisteThemeCreator.kContainerBorderColor)),
                              SizedBox(
                                height: 48,
                                child: Row(
                                  children: [
                                    _buildButton(
                                      context,
                                      _okText,
                                      PicklisteFlushBarReturnValue.answerOk,
                                      PicklisteTestkey.flushBar_ok.toString(),
                                    ),
                                  ],
                                ),
                              ),
                            ]
                          : [],
                      ..._flushBarType == PicklisteFlushBarType.question
                          ? [
                              const Divider(color: Color(PicklisteThemeCreator.kContainerBorderColor)),
                              SizedBox(
                                height: 48,
                                child: Row(
                                  children: [
                                    _buildButton(
                                      context,
                                      _okText,
                                      PicklisteFlushBarReturnValue.answerOk,
                                      PicklisteTestkey.flushBar_ok.toString(),
                                    ),
                                    const VerticalDivider(color: Color(PicklisteThemeCreator.kContainerBorderColor)),
                                    _buildButton(
                                      context,
                                      _cancelText,
                                      PicklisteFlushBarReturnValue.answerCancel,
                                      PicklisteTestkey.flushBar_cancel.toString(),
                                    ),
                                  ],
                                ),
                              ),
                            ]
                          : [],
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String caption, PicklisteFlushBarReturnValue value, String testKey) {
    return Expanded(
      child: TextButton(
        key: ValueKey(testKey),
        onPressed: () => _reset(value),
        child: Text(
          caption,
          style: TextStyle(
            fontSize: PicklisteThemeCreator.kFontSizeMedium,
            color: appFlushBarTypeInfos[MdeNotificationType.question]!.color,
          ),
        ),
      ),
    );
  }
}
