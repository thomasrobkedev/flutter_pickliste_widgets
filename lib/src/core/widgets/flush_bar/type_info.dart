import 'package:flutter/material.dart';

import '../../enums/mde_notification_type.dart';

class PicklisteFlushBarTypeInfo {
  final Color color;
  final IconData icon;

  const PicklisteFlushBarTypeInfo(
    this.color,
    this.icon,
  );
}

const appFlushBarTypeInfos = <MdeNotificationType, PicklisteFlushBarTypeInfo>{
  MdeNotificationType.info: PicklisteFlushBarTypeInfo(
    Colors.blue,
    Icons.info_outlined,
  ),
  MdeNotificationType.warning: PicklisteFlushBarTypeInfo(
    Colors.orange,
    Icons.warning_amber,
  ),
  MdeNotificationType.error: PicklisteFlushBarTypeInfo(
    Colors.red,
    Icons.cancel_outlined,
  ),
  MdeNotificationType.success: PicklisteFlushBarTypeInfo(
    Colors.green,
    Icons.check_circle_outline,
  ),
  MdeNotificationType.question: PicklisteFlushBarTypeInfo(
    Colors.black87,
    Icons.help_outline,
  ),
};
