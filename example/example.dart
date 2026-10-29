import 'package:object_extension/src/object_extension.dart';

/// A sample class with various property types to demonstrate
/// the `toStructuredString()` extension method.
class ExampleClass {
  var property1 = 1;
  var property2 = 2.2;
  var property3 = 'string3';
  var property4 = {'entry1': '4', 'entry2': '44'};
  var property5 = [5, 55];

  /// Converts this instance to a Map representation.
  /// Required for custom objects to work with `toStructuredString()`.
  Map toMap() => {
    'property1': property1,
    'property2': property2,
    'property3': property3,
    'property4': property4,
    'property5': property5
  };

  @override
  String toString() => toMap().toString();
}

/// Demonstrates `toStructuredString()` with a custom class instance.
void toStructuredString1() {
  final sampleObject = ExampleClass();

  print('Sample Object (Object of Class):\n$sampleObject');

  // Default formatting without type annotations
  final structuredObject = sampleObject.toStructuredString();
  print('\nStructured Object:\n$structuredObject');

  // Formatting with type annotations enabled
  final structuredObject2 = sampleObject.toStructuredString(withTypes: true);
  print('\nStructured Object with types:\n$structuredObject2');
}

/// Demonstrates `toStructuredString()` with a complex nested Map
/// containing nulls, primitives, maps, lists, and sets.
void toStructuredString2() {
  final sampleObject = {
    'nullValue': null,
    'value1': 'v1',
    10: 20.5,
    'value2': 'v2',
    'map1': {
      'value7': 'v7',
      'list4': ['string1', 'string2'],
      'value8': 'v8'
    },
    'list1': [0, 2, 3, 44, 55],
    'set1': {
      5,
      {
        'list2': ['a', 'b']
      },
      55
    },
    'list3': [
      {'value3': 'v3', 'value4': 'v4'},
      {'value5': 'v5', 'value6': 'v6'},
      [
        1.3,
        [100, 'string3'],
        2.8,
        {666, 777},
        4,
        5
      ],
    ]
  };

  print('Sample Object (Object as Map):\n$sampleObject');

  // Default formatting without type annotations
  final structuredObject = sampleObject.toStructuredString();
  print('\nStructured Object:\n$structuredObject');

  // Formatting with type annotations enabled
  final structuredObject2 = sampleObject.toStructuredString(withTypes: true);
  print('\nStructured Object with types:\n$structuredObject2');

  print('\nSome more examples ...');
  // Simple primitive value
  print('${3.14.toStructuredString()}\n');
  // Simple primitive value with type annotation
  print('${3.14.toStructuredString(withTypes: true)}\n');
  // Simple Set on a single line
  print('${{1, 2, 3, 4}.toStructuredString()}\n');
  // Custom formatting: double-quoted keys/values, 5-space indentation
  print({
    {'key1': 'val1', 'key2': 'val2'},
    [1, 2],
    2
  }.toStructuredString(
      stringQuote: '"', keyQuote: '"', withTypes: false, tabWidth: 5
  ));
}

/// Entry point — runs all example demonstrations.
void main() {
  print('\n----- toStructuredString1() output (Object of Class) -----\n');
  toStructuredString1();
  print('\n----- toStructuredString2() output (Object as Map) -----\n');
  toStructuredString2();
}
