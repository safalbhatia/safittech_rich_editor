
import 'package:flutter_test/flutter_test.dart';
import 'package:safittech_rich_editor_example/main.dart';

void main() {
  testWidgets('Example app launches', (WidgetTester tester) async {
    await tester.pumpWidget(const EditorExampleApp());

    expect(find.text('Safittech Rich Editor'), findsOneWidget);
  });
}
