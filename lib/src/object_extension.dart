import 'dart:convert';
import 'dart:typed_data';

/// Extension providing utility methods for [Object] instances.
extension ObjectExtension on Object {

  /// Converts this object to a structured string representation.
  ///
  /// Supports nested [Map], [List], [Set], and custom objects
  /// that implement a `toMap()` method.
  ///
  /// Parameters:
  ///   - [stringQuote]: Characters used to wrap string values. Defaults to `"'"`.
  ///   - [keyQuote]: Characters used to wrap map keys. Defaults to `''` (no quotes).
  ///   - [withTypes]: Whether to prepend the runtime type to each value. Defaults to `false`.
  ///   - [tabWidth]: Number of spaces per indentation level. Defaults to `2`.
  String toStructuredString({
    String stringQuote = "'",
    String keyQuote = '',
    bool withTypes = false,
    int tabWidth = 2
  }) => _toStructuredString(
      value: this,
      parentIsSimpleList: false,
      stringQuote: stringQuote,
      keyQuote: keyQuote,
      withTypes: withTypes,
      tabWidth: tabWidth,
      level: 0
  );

  /// Recursively converts a value into a structured string.
  String _toStructuredString({
    required Object? value,
    required bool parentIsSimpleList,
    required String stringQuote,
    required String keyQuote,
    required bool withTypes,
    required tabWidth,
    required int level
  }) {

    final type = value.runtimeType.toString();
    final showType = withTypes && !parentIsSimpleList ? '$type ' : '';

    // Handle null values
    if (value == null) {
      return '${showType}null';
    }
    // Handle String values
    if (value is String) {
      return showType + stringQuote + value + stringQuote;
    }
    // Handle primitive numeric and boolean types
    if (value is bool || value is int || value is double || value is num) {
      return showType + value.toString();
    }
    // Handle Map types
    if (value is Map) {
      return showType + _mapToStructuredString(
          map: value,
          stringQuote: stringQuote,
          keyQuote: keyQuote,
          withTypes: withTypes,
          tabWidth: tabWidth,
          level: level
      );
    }
    // Handle List types
    if (value is List) {
      return showType + _listToStructuredString(
          list: value,
          stringQuote: stringQuote,
          keyQuote: keyQuote,
          withTypes: withTypes,
          tabWidth: tabWidth,
          level: level
      );
    }
    // Handle Set types
    if (value is Set) {
      return showType + _setToStructuredString(
          set: value,
          stringQuote: stringQuote,
          keyQuote: keyQuote,
          withTypes: withTypes,
          tabWidth: tabWidth,
          level: level
      );
    }
    // Attempt to convert custom objects via toMap()
    try {
      return showType + _mapToStructuredString(
          map: (value as dynamic).toMap(),
          stringQuote: stringQuote,
          keyQuote: keyQuote,
          withTypes: withTypes,
          tabWidth: tabWidth,
          level: level
      );
    } on NoSuchMethodError {
      throw UnimplementedError('$type.toMap()');
    }
  }

  /// Converts a [Map] into a structured, indented string.
  String _mapToStructuredString({
    required Map map,
    required String stringQuote,
    required String keyQuote,
    required bool withTypes,
    required tabWidth,
    required int level
  }) {

    final tab = ' ' * tabWidth;
    var str = '{\n';

    for (final entry in map.entries) {
      final value = entry.value;

      final tabs = tab * (level + 1);
      if (entry.key is String) {
        str += '$tabs$keyQuote${entry.key}$keyQuote: ';
      } else {
        str += '$tabs${entry.key}: ';
      }

      str += _toStructuredString(
          value: value,
          parentIsSimpleList: false,
          stringQuote: stringQuote,
          keyQuote: keyQuote,
          withTypes: withTypes,
          tabWidth: tabWidth,
          level: level + 1
      );

      if (entry.key == map.entries.last.key) {
        str += '\n';
      } else {
        str += ',\n';
      }
    }

    return '$str${tab * level}}';
  }

  /// Converts a [List] into a structured, indented string.
  ///
  /// Simple lists (`List<Object>`) are rendered on a single line,
  /// while nested lists are multi-line with indentation.
  String _listToStructuredString({
    required List list,
    required String stringQuote,
    required String keyQuote,
    required bool withTypes,
    required tabWidth,
    required int level
  }) {

    final tab = ' ' * tabWidth;
    final simple = list.runtimeType.toString() == 'List<Object>' ? false : true;
    var str = simple ? '[ ' : '[\n';

    for (final value in list) {
      if (!simple) str += tab * (level + 1);
      str += _toStructuredString(
          value: value,
          parentIsSimpleList: simple,
          stringQuote: stringQuote,
          keyQuote: keyQuote,
          withTypes: withTypes,
          tabWidth: tabWidth,
          level: level + 1
      );
      str += _divider(value == list.last, simple);
    }

    if (simple) return '$str]';
    return '$str${tab * level}]';
  }

  /// Converts a [Set] into a structured, indented string.
  ///
  /// Simple sets are rendered on a single line,
  /// while nested sets are multi-line with indentation.
  String _setToStructuredString({
    required Set set,
    required String stringQuote,
    required String keyQuote,
    required bool withTypes,
    required tabWidth,
    required int level
  }) {

    final tab = ' ' * tabWidth;
    final simple =
    set.toList().runtimeType.toString() == 'List<Object>' ? false : true;
    var str = simple ? '{ ' : '{\n';

    for (final value in set) {
      if (!simple) str += tab * (level + 1);
      str += _toStructuredString(
          value: value,
          parentIsSimpleList: simple,
          stringQuote: stringQuote,
          keyQuote: keyQuote,
          withTypes: withTypes,
          tabWidth: tabWidth,
          level: level + 1
      );
      str += _divider(value == set.last, simple);
    }

    if (simple) return '$str}';
    return '$str${tab * level}}';
  }

  /// Returns the appropriate divider (comma and/or newline) based on
  /// whether this is the last element and whether the container is simple.
  String _divider(bool last, bool simple) {
    if (last) {
      if (simple) return ' ';
      return '\n';
    }
    if (simple) return ', ';
    return ',\n';
  }

  /// Converts this object to a [Uint8List].
  ///
  /// Currently only supports [String] values.
  /// Throws an [Exception] for unsupported types.
  Uint8List toBytes() {
    if (this is String) return Uint8List.fromList(utf8.encode(this as String));
    throw 'toBytes() function is not implemented for $runtimeType type.';
  }
}
