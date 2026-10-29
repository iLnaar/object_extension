The package extends the functionality of the base class [Object](https://api.dart.dev/stable/2.14.4/dart-core/Object-class.html).
This means that when the `object_extension` package is imported,
absolutely all dart classes and objects (except for `null`) will
have all the functions available in this package.

The functions of the package allow you to simplify the programming
process and transform the data into an easy-to-understand form.

## Method list

| Method | Used for |
|--------|----------|
| [`toStructuredString()`](https://pub.dev/documentation/object_extension/latest/object_extension/ObjectExtension/toStructuredString.html) | Allows you to convert any object to a structured text view. You can set the width of indents, the presence of quotes in keys and in string values. For debugging purposes, the function of showing data types is very good. Lists with simple elements of the same type are shown on one line. The same is true for sets. Map entries are always shown each on a separate line |

## Getting started

To use any functions of the package,
just [install it](https://pub.dev/packages/object_extension/install).
All functions will be automatically available in the entire hierarchy
of dart classes, beginning with the `Object` class.

## Usage

Below are examples of transformations using the [`toStructuredString()`](https://pub.dev/documentation/object_extension/latest/object_extension/ObjectExtension/toStructuredString.html)
method.

To convert the `Map` into a human-readable form, it is enough just to import the package and call the
`toStructuredString()`:

```dart
import 'package:object_extension/object_extension.dart';

final map = {
  'key1': 1,
  3: 100,
  'key3': ['a', 'b', 'c'],
  'key4': { 'key41': 'string41' }
};
print(map.toStructuredString(withTypes: true, tabWidth: 4));
```

Output:

```
_InternalLinkedHashMap<Object, Object> {
    key1: int 1,
    3: int 100,
    key3: List<String> [ 'a', 'b', 'c' ],
    key4: _InternalLinkedHashMap<String, String> {
        key41: String 'string41'
    }
}
```

If you need the ability to transform for instances of classes, then you need to implement your own `toMap()` method in
them and override `toString()`. Example of the class:

```dart
class ExampleClass {
  var property1 = 1;
  var property2 = 2.2;
  var property3 = 'string3';
  var property4 = {
    'entry1': '4',
    'entry2': '44'
  };
  var property5 = [ 5, 55 ];

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
```

Now you can call the `toStructuredString()` method in the same way:

```dart
final sampleObject = ExampleClass();
final structuredObject = sampleObject.toStructuredString();
print(structuredObject);
```

Output:

```
{
  property1: 1,
  property2: 2.2,
  property3: 'string3',
  property4: {
    entry1: '4',
    entry2: '44'
  },
  property5: [ 5, 55 ]
}
```
