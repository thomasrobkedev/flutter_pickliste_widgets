import 'package:flutter/material.dart';

import '../theme/theme_const.dart';

extension ListDivided on Iterable {
  List<Widget> toListDivided({bool withLastLine = false}) {
    return toList()
        .asMap()
        .entries
        .expand<Widget>(
          (entry) => [
            ...entry.key == 0 && !withLastLine ? [] : [const Divider(height: 0, color: Color(kDividerColor), indent: 0, thickness: 0.5)],
            entry.value,
          ],
        )
        .toList();
  }
}
