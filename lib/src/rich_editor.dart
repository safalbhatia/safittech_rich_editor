
import 'package:flutter/material.dart';
import 'rich_editor_controller.dart';

class RichEditor extends StatefulWidget {
  const RichEditor({
    super.key,
    required this.controller,
    this.height = 300,
    this.hintText = 'Write something...',
  });

  final RichEditorController controller;
  final double height;
  final String hintText;

  @override
  State<RichEditor> createState() => _RichEditorState();
}

class _RichEditorState extends State<RichEditor> {
  static const List<double> _fontSizes = [
    12, 14, 16, 18, 20, 24, 28, 32
  ];

  static const List<Color> _colors = [
    Colors.black,
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.pink,
    Colors.brown,
  ];

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_refresh);
  }

  @override
  void didUpdateWidget(covariant RichEditor oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_refresh);
      widget.controller.addListener(_refresh);
    }
  }

  void _refresh() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    widget.controller.removeListener(_refresh);
    super.dispose();
  }

  Widget _formatButton({
    required IconData icon,
    required EditorFormat format,
    required String tooltip,
  }) {
    return IconButton(
      visualDensity: VisualDensity.compact,
      tooltip: tooltip,
      icon: Icon(icon),
      onPressed: () => widget.controller.toggleFormat(format),
    );
  }

  Widget _fontSizeDropdown() {
    return PopupMenuButton<double>(
      tooltip: 'Font size',
      onSelected: widget.controller.setFontSize,
      itemBuilder: (context) => _fontSizes
          .map(
            (size) => PopupMenuItem<double>(
          value: size,
          child: Text('${size.toInt()} px'),
        ),
      )
          .toList(),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.format_size),
            SizedBox(width: 4),
            Text('Size'),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }

  Widget _colorPicker() {
    return PopupMenuButton<Color>(
      tooltip: 'Text color',
      onSelected: widget.controller.setColor,
      itemBuilder: (context) => [
        PopupMenuItem<Color>(
          enabled: false,
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _colors.map((color) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  widget.controller.setColor(color);
                },
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: Icon(Icons.format_color_text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _formatButton(
                  icon: Icons.format_bold,
                  format: EditorFormat.bold,
                  tooltip: 'Bold',
                ),
                _formatButton(
                  icon: Icons.format_italic,
                  format: EditorFormat.italic,
                  tooltip: 'Italic',
                ),
                _formatButton(
                  icon: Icons.format_underline,
                  format: EditorFormat.underline,
                  tooltip: 'Underline',
                ),
                _fontSizeDropdown(),
                _colorPicker(),
              ],
            ),
          ),
          Divider(height: 1, color: Colors.grey.shade300),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: TextField(
                controller: widget.controller.textController,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
