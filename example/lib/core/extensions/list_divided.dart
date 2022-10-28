import 'package:flutter/material.dart';

extension ListDivided on Iterable {
  List<Widget> toListDivided({
    double indent = 16.0,
    double endIndent = 0.0,
    bool topLine = false,
    bool bottomLine = true,
  }) {
    final entries = toList().asMap().entries;

    Widget divider() {
      return Divider(
        height: 0,
        // color: const Color(PicklisteThemeConstants.kDividerColor),
        indent: indent,
        endIndent: endIndent,
        thickness: 0.5,
      );
    }

    return entries
        .expand<Widget>(
          (entry) => [
            Visibility(visible: entry.key == 0 && topLine, child: divider()),
            entry.value,
            Visibility(visible: entry.key < entries.length - (bottomLine ? 0 : 1), child: divider()),
          ],
        )
        .toList();
  }
}
