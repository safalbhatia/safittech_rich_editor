# Safittech Rich Editor

Safittech Rich Editor is a customizable rich text editor for Flutter applications. It provides formatting controls for bold, italic, underline, font size, and text color, with HTML export through `RichEditorController`.

## Features

- Bold text formatting
- Italic text formatting
- Underline formatting
- Font size selection
- Text color selection
- HTML export using `RichEditorController`
- Example Flutter application

## Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  safittech_rich_editor: ^0.1.0
```

Then run:

```bash
flutter pub get
```

## Import

```dart
import 'package:safittech_rich_editor/safittech_rich_editor.dart';
```

## Basic Usage

Create a controller and add the editor to your widget tree:

```dart
import 'package:flutter/material.dart';
import 'package:safittech_rich_editor/safittech_rich_editor.dart';

class EditorExample extends StatefulWidget {
  const EditorExample({super.key});

  @override
  State<EditorExample> createState() => _EditorExampleState();
}

class _EditorExampleState extends State<EditorExample> {
  late final RichEditorController controller;

  @override
  void initState() {
    super.initState();
    controller = RichEditorController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rich Text Editor')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: RichEditor(controller: controller),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint(controller.html);
        },
        child: const Icon(Icons.code),
      ),
    );
  }
}
```

## HTML Export

Retrieve the editor's HTML string with:

```dart
final htmlContent = controller.html;
```

Use the resulting string in your application wherever HTML content is needed.

## Example App

An example application is available in the `example/` directory.

Run it with:

```bash
cd example
flutter pub get
flutter run
```

## Requirements

- Flutter SDK
- A Dart SDK compatible with this package's SDK constraints

## Repository

[GitHub Repository](https://github.com/safalbhatia/safittech_rich_editor)

## Issues and Contributions

For bug reports, feature requests, or contributions, visit the GitHub repository and open an issue or pull request.

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for release history.

## License

See the [LICENSE](LICENSE) file for licensing terms.
