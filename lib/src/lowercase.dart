/// Checks whether given [value] is lowercase string.
///
/// ```dart
/// isLowerCase('string'); // => true
/// isLowerCase('String'); // => false
/// isLowerCase('STRING'); // => false
/// ```
bool isLowerCase(String value) => value == value.toLowerCase();
