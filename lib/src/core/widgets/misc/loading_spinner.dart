import 'package:flutter/material.dart';

class PicklisteLoadingSpinner extends StatelessWidget {
  const PicklisteLoadingSpinner({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
