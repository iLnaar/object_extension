import 'package:object_extension/src/object_extension.dart';

class ExampleClass {
  var property1 = 1;
  var property2 = 2.2;
  var property3 = 'string3';
  var property4 = {'entry1': '4', 'entry2': '44'};
  var property5 = [5, 55];

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

void toStructuredString1() {
  final sampleObject = ExampleClass();

  print('Sample Object (Object of Class):\n$sampleObject');

  final structuredObject = sampleObject.toStructuredString();
  print('\nStructured Object:\n$structuredObject');

  final structuredObject2 = sampleObject.toStructuredString(withTypes: true);
  print('\nStructured Object with types:\n$structuredObject2');
}

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

  final structuredObject = sampleObject.toStructuredString();
  print('\nStructured Object:\n$structuredObject');

  final structuredObject2 = sampleObject.toStructuredString(withTypes: true);
  print('\nStructured Object with types:\n$structuredObject2');

  print('\nSome more examples ...');
  print(3.14.toStructuredString() + '\n');
  print(3.14.toStructuredString(withTypes: true) + '\n');
  print({1, 2, 3, 4}.toStructuredString() + '\n');
  print({
    {'key1': 'val1', 'key2': 'val2'},
    [1, 2],
    2
  }.toStructuredString(
      stringQuote: '"', keyQuote: '"', withTypes: false, tabWidth: 5));
}

void main() {
  print('\n----- toStructuredString1() output (Object of Class) -----\n');
  toStructuredString1();
  print('\n----- toStructuredString2() output (Object as Map) -----\n');
  toStructuredString2();
}