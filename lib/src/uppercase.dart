/// Checks whether given [value] is uppercase string.
///
/// ```dart
/// isUpperCase('STRING'); // => true
/// isUpperCase('string'); // => false
/// isUpperCase('StRing'); // => false
/// ```
bool isUpperCase(String value) => value.toUpperCase() == value;
