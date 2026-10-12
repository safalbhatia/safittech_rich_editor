
import 'package:flutter/material.dart';

enum EditorFormat { bold, italic, underline }

class _CharacterStyle {
  bool bold;
  bool italic;
  bool underline;
  double? fontSize;
  Color? color;

  _CharacterStyle({
    this.bold = false,
    this.italic = false,
    this.underline = false,
    this.fontSize,
    this.color,
  });

  _CharacterStyle copy() => _CharacterStyle(
    bold: bold,
    italic: italic,
    underline: underline,
    fontSize: fontSize,
    color: color,
  );

  TextStyle toTextStyle() => TextStyle(
    fontWeight: bold ? FontWeight.bold : FontWeight.normal,
    fontStyle: italic ? FontStyle.italic : FontStyle.normal,
    decoration:
    underline ? TextDecoration.underline : TextDecoration.none,
    fontSize: fontSize,
    color: color,
  );

  String get htmlStyle {
    final declarations = <String>[];

    if (fontSize != null) {
      declarations.add('font-size: ${fontSize!.toStringAsFixed(0)}px');
    }

    if (color != null) {
      final hex = color!.toARGB32().toRadixString(16).padLeft(8, '0');
      declarations.add('color: #${hex.substring(2)}');
    }

    return declarations.isEmpty
        ? ''
        : ' style="${declarations.join('; ')}"';
  }

  String get openingHtml {
    final result = StringBuffer();

    if (bold) result.write('<strong>');
    if (italic) result.write('<em>');
    if (underline) result.write('<u>');
    if (htmlStyle.isNotEmpty) result.write('<span$htmlStyle>');

    return result.toString();
  }

  String get closingHtml {
    final result = StringBuffer();

    if (htmlStyle.isNotEmpty) result.write('</span>');
    if (underline) result.write('</u>');
    if (italic) result.write('</em>');
    if (bold) result.write('</strong>');

    return result.toString();
  }

  bool sameAs(_CharacterStyle other) =>
      bold == other.bold &&
          italic == other.italic &&
          underline == other.underline &&
          fontSize == other.fontSize &&
          color == other.color;
}

class _StyledTextController extends TextEditingController {
  List<_CharacterStyle> styles = [];

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    final value = text;

    if (value.isEmpty) {
      return TextSpan(style: style, text: value);
    }

    while (styles.length < value.length) {
      styles.add(_CharacterStyle());
    }

    if (styles.length > value.length) {
      styles = styles.sublist(0, value.length);
    }

    final spans = <InlineSpan>[];
    var start = 0;

    while (start < value.length) {
      var end = start + 1;

      while (end < value.length &&
          styles[end].sameAs(styles[start])) {
        end++;
      }

      spans.add(TextSpan(
        text: value.substring(start, end),
        style: styles[start].toTextStyle(),
      ));

      start = end;
    }

    return TextSpan(style: style, children: spans);
  }
}

class RichEditorController extends ChangeNotifier {
  final _StyledTextController _textController =
  _StyledTextController();

  TextEditingController get textController => _textController;

  String get text => _textController.text;

  String get html {
    final value = text;
    final styles = _textController.styles;
    final buffer = StringBuffer('<p>');
    var start = 0;

    while (start < value.length) {
      if (value[start] == '\n') {
        buffer.write('</p><p>');
        start++;
        continue;
      }

      var end = start + 1;

      while (end < value.length &&
          value[end] != '\n' &&
          styles[end].sameAs(styles[start])) {
        end++;
      }

      final currentStyle = styles[start];
      buffer.write(currentStyle.openingHtml);
      buffer.write(_escapeHtml(value.substring(start, end)));
      buffer.write(currentStyle.closingHtml);

      start = end;
    }

    buffer.write('</p>');
    return buffer.toString();
  }

  void setText(String value) {
    _textController.styles =
        List.generate(value.length, (_) => _CharacterStyle());

    _textController.value = TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(offset: value.length),
    );

    notifyListeners();
  }

  void toggleFormat(EditorFormat format) {
    final selection = _textController.selection;

    if (!selection.isValid || selection.isCollapsed) return;

    final styles = _textController.styles;
    final start = selection.start;
    final end = selection.end;

    final turnOn = styles
        .sublist(start, end)
        .any((s) => switch (format) {
      EditorFormat.bold => !s.bold,
      EditorFormat.italic => !s.italic,
      EditorFormat.underline => !s.underline,
    });

    for (var i = start; i < end; i++) {
      switch (format) {
        case EditorFormat.bold:
          styles[i].bold = turnOn;
        case EditorFormat.italic:
          styles[i].italic = turnOn;
        case EditorFormat.underline:
          styles[i].underline = turnOn;
      }
    }

    _textController.value =
        _textController.value.copyWith(selection: selection);
    notifyListeners();
  }

  void setFontSize(double size) {
    _applyToSelection((style) => style.fontSize = size);
  }

  void setColor(Color color) {
    _applyToSelection((style) => style.color = color);
  }

  void _applyToSelection(void Function(_CharacterStyle) update) {
    final selection = _textController.selection;

    if (!selection.isValid || selection.isCollapsed) return;

    for (var i = selection.start; i < selection.end; i++) {
      update(_textController.styles[i]);
    }

    _textController.value =
        _textController.value.copyWith(selection: selection);
    notifyListeners();
  }

  String _escapeHtml(String value) {
    return value
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&#39;');
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
