import 'package:flutter_test/flutter_test.dart';
import 'package:project_uas/main.dart';
import 'package:project_uas/data/local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('NusaFaunaApp initial build test', (WidgetTester tester) async {
    // Mock shared preferences
    SharedPreferences.setMockInitialValues({});
    await LocalStorageService.init();

    // Build our app and trigger a frame.
    await tester.pumpWidget(const NusaFaunaApp());

    // Verify that our login screen elements exist
    expect(find.text('Selamat Datang di Nusafauna'), findsOneWidget);
    expect(find.text('Lestarikan alam melalui pengetahuan.'), findsOneWidget);
  });
}
