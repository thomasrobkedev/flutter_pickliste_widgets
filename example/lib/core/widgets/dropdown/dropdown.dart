import 'package:flutter/material.dart';

import '../../../../core/enums/testkey.dart';
import '../../../../core/extensions/list_divided.dart';
import 'item.dart';

class Dropdown<T> extends StatefulWidget {
  final String title;
  final List<DropdownItem> items;
  final Function(dynamic) callback;
  final String? doneText;
  final bool multiple;

  const Dropdown({
    super.key,
    required this.title,
    required this.items,
    required this.callback,
    this.doneText,
    this.multiple = false,
  });

  @override
  State<Dropdown<T>> createState() => _DropdownState<T>();
}

class _DropdownState<T> extends State<Dropdown<T>> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ValueKey(Testkey.dropdown.toString()),
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Visibility(
            visible: widget.multiple,
            child: TextButton(
              child: Text(widget.doneText ?? 'Fertig'),
              onPressed: () {
                widget.callback(widget.items.where((item) => item.selected).toList() as List<T>);
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: widget.items
              .map(
                (DropdownItem item) => ListTile(
                  key: ValueKey(Testkey.dropdown_item_.append(item.value)),
                  title: item.title,
                  selected: item.selected,
                  enabled: item.enabled,
                  trailing: item.selected
                      ? Icon(
                          Icons.check,
                          key: ValueKey(Testkey.dropdown_item_icon_.append(item.value)),
                        )
                      : null,
                  onTap: () {
                    if (widget.multiple) {
                      setState(() => item.selected = !item.selected);
                    } else {
                      widget.callback(item.value);
                      Navigator.pop(context);
                    }
                  },
                ),
              )
              .toListDivided(),
        ),
      ),
    );
  }
}
