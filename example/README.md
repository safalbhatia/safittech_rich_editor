# Safittech Rich Editor

A customizable rich text editor for Flutter applications with **Bold, Italic, Underline, Font Size, Text Color, and HTML Export** support.

## Features

- **Bold Text** — Apply bold formatting.
- *Italic Text* — Apply italic formatting.
- Underline — Underline selected text.
- **Font Size** — Customize text size.
- **Text Color** — Change text color.
- **HTML Export** — Retrieve formatted content as HTML using `RichEditorController`.
- **Custom Controller** — Manage editor text and formatting.
- **Example App** — Explore the package in the included example project.

## Getting Started

Add the package to your Flutter project.

```bash
flutter pub add safittech_rich_editor
```

Alternatively, add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  safittech_rich_editor: ^0.1.0
```

Then run:

```bash
flutter pub get
```

## Usage

Import the package:

```dart
import 'package:safittech_rich_editor/safittech_rich_editor.dart';
```

Create a controller and use the editor in your widget:

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
      appBar: AppBar(
        title: const Text('Rich Text Editor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: RichEditor(
          controller: controller,
        ),
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

The example above demonstrates the basic editor setup and HTML export. Check the example application for additional usage details.

## HTML Export

Use the controller's HTML getter to retrieve the formatted content:

```dart
final htmlContent = controller.html;
debugPrint(htmlContent);
```

You can use the resulting HTML string wherever your application needs formatted content, such as an HTML preview or an API request.

## Example Application

The package includes an example Flutter application in the `example/` directory.

To run it:

```bash
cd example
flutter pub get
flutter run
```

## Requirements

- Flutter SDK
- Dart SDK compatible with the package's declared SDK constraints

## Repository

GitHub: https://github.com/safalbhatia/safittech_rich_editor

## Issues and Contributions

If you encounter a bug or have a feature request, please open an issue in the GitHub repository.

Contributions are welcome through pull requests.

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for version history.

## License

This project is distributed under the license included in the [LICENSE](LICENSE) file.
