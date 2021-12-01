extension ObjectExtension on Object {

  String toStructuredString(
      {String stringQuote = "'",
        String keyQuote = '',
        bool withTypes = false,
        int tabWidth = 2}) =>
      _toStructuredString(
          value: this,
          parentIsSimpleList: false,
          stringQuote: stringQuote,
          keyQuote: keyQuote,
          withTypes: withTypes,
          tabWidth: tabWidth,
          level: 0);

  String _toStructuredString(
      {required Object? value,
        required bool parentIsSimpleList,
        required String stringQuote,
        required String keyQuote,
        required bool withTypes,
        required tabWidth,
        required int level}) {
    final type = value.runtimeType.toString();
    final showType = withTypes && !parentIsSimpleList ? type + ' ' : '';

    if (value == null) {
      return showType + 'null';
    }
    if (value is String) {
      return showType + stringQuote + value + stringQuote;
    }
    if (value is bool || value is int || value is double || value is num) {
      return showType + value.toString();
    }
    if (value is Map) {
      return showType +
          _mapToStructuredString(
              map: value,
              stringQuote: stringQuote,
              keyQuote: keyQuote,
              withTypes: withTypes,
              tabWidth: tabWidth,
              level: level);
    }
    if (value is List) {
      return showType +
          _listToStructuredString(
              list: value,
              stringQuote: stringQuote,
              keyQuote: keyQuote,
              withTypes: withTypes,
              tabWidth: tabWidth,
              level: level);
    }
    if (value is Set) {
      return showType +
          _setToStructuredString(
              set: value,
              stringQuote: stringQuote,
              keyQuote: keyQuote,
              withTypes: withTypes,
              tabWidth: tabWidth,
              level: level);
    }
    try {
      return showType +
          _mapToStructuredString(
              map: (value as dynamic).toMap(),
              stringQuote: stringQuote,
              keyQuote: keyQuote,
              withTypes: withTypes,
              tabWidth: tabWidth,
              level: level);
    } on NoSuchMethodError {
      throw UnimplementedError('$type.toMap()');
    }
  }

  String _mapToStructuredString(
      {required Map map,
        required String stringQuote,
        required String keyQuote,
        required bool withTypes,
        required tabWidth,
        required int level}) {
    final tab = ' ' * tabWidth;
    var str = '{\n';

    for (final entry in map.entries) {
      final value = entry.value;

      if (entry.key is String) {
        str += tab * (level + 1) + keyQuote + entry.key + keyQuote + ': ';
      } else {
        str += tab * (level + 1) + entry.key.toString() + ': ';
      }
      str += _toStructuredString(
          value: value,
          parentIsSimpleList: false,
          stringQuote: stringQuote,
          keyQuote: keyQuote,
          withTypes: withTypes,
          tabWidth: tabWidth,
          level: level + 1);
      if (entry.key == map.entries.last.key) {
        str += '\n';
      } else {
        str += ',\n';
      }
    }

    return str + tab * level + '}';
  }

  String _listToStructuredString(
      {required List list,
        required String stringQuote,
        required String keyQuote,
        required bool withTypes,
        required tabWidth,
        required int level}) {
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
          level: level + 1);
      str += _divider(value == list.last, simple);
    }

    if (simple) return str + ']';
    return str + tab * level + ']';
  }

  String _setToStructuredString(
      {required Set set,
        required String stringQuote,
        required String keyQuote,
        required bool withTypes,
        required tabWidth,
        required int level}) {
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
          level: level + 1);
      str += _divider(value == set.last, simple);
    }

    if (simple) return str + '}';
    return str + tab * level + '}';
  }

  String _divider(bool last, bool simple) {
    if (last) {
      if (simple) return ' ';
      return '\n';
    }
    if (simple) return ', ';
    return ',\n';
  }
}
