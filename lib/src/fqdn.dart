bool _isValidChar(int code) {
  return false;
}

/// Checks whether given [value] is fully qualified domain name.
///
/// ```dart
/// isFQDN('example.com'); // => true
/// isFQDN('-example.com'); // => false
/// ```
bool isFQDN(String value,
    {bool allowUnderscore = false, bool allowTrailingDot = true}) {
  final len = value.length;
  final parts = value.split('.');

  // Omit tail dot if presented.
  if (allowTrailingDot && value[len - 1] == '.') {
    parts.removeLast();
  }

  final partsLen = parts.length;

  for (int i = 0; i < partsLen; i++) {
    final part = parts[i];
    final partLen = part.length;

    if (part.codeUnitAt(0) == 0x2d /* - */ ||
        part.codeUnitAt(partLen - 1) == 0x2d) {
      return false;
    }

    for (int j = 0; j < partLen; j++) {
      if (!_isValidChar(part.codeUnitAt(j))) {
        return false;
      }
    }
  }

  return true;
}
