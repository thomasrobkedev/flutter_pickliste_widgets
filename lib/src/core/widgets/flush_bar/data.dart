import 'package:flutter/material.dart';

import '../../enums/mde_notification_type.dart';
import 'flush_bar.dart';

class PicklisteFlushBarData {
  final PicklisteFlushBarType? flushBarType;
  final MdeNotificationType? type;
  final int? autoCloseTimeout;
  final String? message;
  final String Function(BuildContext)? messageCallback;
  final ValueKey<String>? testKey;
  final String okText;
  final String cancelText;

  const PicklisteFlushBarData({
    this.flushBarType = PicklisteFlushBarType.information,
    this.type = MdeNotificationType.info,
    this.autoCloseTimeout,
    this.message,
    this.messageCallback,
    this.testKey,
    required this.okText,
    required this.cancelText,
  });
}
