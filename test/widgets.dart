import 'package:flutter/widgets.dart';

/// Wrapper widget to supply default localization and directionality
class TestWrapper extends StatelessWidget {
  const TestWrapper({Key key, @required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Localizations(
      locale: const Locale('en', 'US'),
      delegates: <LocalizationsDelegate<dynamic>>[
        DefaultWidgetsLocalizations.delegate,
        // DefaultMaterialLocalizations.delegate,
      ],
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: child,
      ),
    );
  }
}
