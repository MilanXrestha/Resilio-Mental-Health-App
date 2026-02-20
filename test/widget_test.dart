import 'package:flutter_test/flutter_test.dart';
import 'package:resilio/core/settings/app_settings.dart';
import 'package:resilio/main.dart';

void main() {
  testWidgets('App renders smoke test', (WidgetTester tester) async {
    final appSettings = AppSettings();
    await appSettings.load();
    
    // Build our app and trigger a frame.
    await tester.pumpWidget(ResilioApp(appSettings: appSettings));
    await tester.pumpAndSettle();

    // Verify that the app renders
    expect(find.byType(ResilioApp), findsOneWidget);
  });
}
