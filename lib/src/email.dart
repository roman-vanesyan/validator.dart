final RegExp _regExp = RegExp(
    '[a-z0-9!#\$%&\'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#\$%&\'*+/=?^_`{|}~-]+)*'
    '@'
    '(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?');

/// Checks whether given [value] is valid email.
///
/// ```dart
/// isEmail('user@example.com'); // => true
/// ```
bool isEmail(String value) => _regExp.hasMatch(value);
