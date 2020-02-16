/// Tests whether [value] is uppercase string.
///
/// ```dart
/// isUpperCase('STRING'); // => true
/// isUpperCase('StRing'); // => false
/// ```
bool isUpperCase(String value) => value.toUpperCase() == value;
