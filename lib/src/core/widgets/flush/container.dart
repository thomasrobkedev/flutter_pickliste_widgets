import 'package:flutter/material.dart';

class PicklisteFlushContainer extends StatelessWidget {
  final BuildContext context;
  final void Function()? onTap;
  final Future<bool> Function()? onWillPop;
  final ValueKey<String>? testKey;
  final Widget child;

  const PicklisteFlushContainer({
    required this.context,
    this.onTap,
    this.onWillPop,
    this.testKey,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: WillPopScope(
        onWillPop: onWillPop ?? () async => false,
        child: Container(
          color: Colors.transparent,
          padding: EdgeInsets.fromLTRB(12, 12, 12, 12 + MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                key: testKey,
                alignment: Alignment.bottomCenter,
                color: Colors.white,
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
