
import 'package:flutter_test/flutter_test.dart';
import 'package:safittech_rich_editor/safittech_rich_editor.dart';

void main() {
  test('RichEditorController converts text to HTML', () {
    final controller = RichEditorController();

    controller.setText('Hello World');

    expect(controller.html, '<p>Hello World</p>');

    controller.dispose();
  });
}
