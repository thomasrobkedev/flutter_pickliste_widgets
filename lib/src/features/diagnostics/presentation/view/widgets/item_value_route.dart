import 'package:flutter/material.dart';

import '../../../../../core/theme/global_theme.dart';

class PicklisteDiagnosticsItemValueRoute extends StatelessWidget {
  const PicklisteDiagnosticsItemValueRoute({
    super.key,
    required this.destination,
    required this.gateway,
    required this.flexDestination,
    required this.flexGateway,
  });

  final String destination;
  final String gateway;
  final int flexDestination;
  final int flexGateway;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            flex: flexDestination + 2,
            child: Text(
              destination,
              textAlign: TextAlign.right,
              style: const TextStyle(height: 0.9),
            ),
          ),
          const SizedBox(
            width: 28,
            child: Text(
              '➔',
              textAlign: TextAlign.center,
              style: TextStyle(
                height: 0.9 * PicklisteThemeCreator.kFontSizeDefault / PicklisteThemeCreator.kFontSizeSmall,
                fontSize: PicklisteThemeCreator.kFontSizeSmall,
              ),
            ),
          ),
          Expanded(
            flex: flexGateway,
            child: Text(
              gateway,
              style: const TextStyle(height: 0.9),
            ),
          ),
        ],
      ),
    );
  }
}
