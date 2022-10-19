import 'package:flutter/material.dart';

import '../theme/theme_const.dart';

extension ListDivided on Iterable {
  List<Widget> toListDivided({double indent = 0.0, double endIndent = 0.0, bool withLastLine = false}) {
    final entries = toList().asMap().entries;

    return entries
        .expand<Widget>(
          (entry) => [
            entry.value,
            Visibility(
              visible: entry.key < entries.length - (withLastLine ? 0 : 1),
              child: Divider(
                height: 0,
                color: const Color(kDividerColor),
                indent: indent,
                endIndent: endIndent,
                thickness: 0.5,
              ),
            ),
          ],
        )
        .toList();
  }
}
