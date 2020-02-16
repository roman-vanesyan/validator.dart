final RegExp _regExp = new RegExp(
    '[a-z0-9!#\$%&\'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#\$%&\'*+/=?^_`{|}~-]+)*'
    '@'
    '(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?'
);

/// Test whether [value] is valid email.
///
/// ```dart
/// isEmail('user@example.com'); // => true
/// ```
bool isEmail(String value) => _regExp.hasMatch(value);
