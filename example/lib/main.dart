
import 'package:flutter/material.dart';
import 'package:safittech_rich_editor/safittech_rich_editor.dart';

void main() {
  runApp(const EditorExampleApp());
}

class EditorExampleApp extends StatelessWidget {
  const EditorExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const EditorExampleScreen(),
    );
  }
}

class EditorExampleScreen extends StatefulWidget {
  const EditorExampleScreen({super.key});

  @override
  State<EditorExampleScreen> createState() =>
      _EditorExampleScreenState();
}

class _EditorExampleScreenState extends State<EditorExampleScreen> {
  final controller = RichEditorController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Safittech Rich Editor')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            RichEditor(
              controller: controller,
              height: 300,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                showDialog<void>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Generated HTML'),
                    content: SingleChildScrollView(
                      child: SelectableText(controller.html),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Show HTML'),
            ),
          ],
        ),
      ),
    );
  }
}
