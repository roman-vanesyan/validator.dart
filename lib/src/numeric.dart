/// Checks whether given [value] is numeric.
bool isNumeric(String value, {bool integerOnly = false}) {
  final len = value.length;

  if (integerOnly) {
    for (int i = 0; i < len; i++) {
      final codeUnit = value.codeUnitAt(i);

      if (codeUnit < 0x30 /* 0 */ || codeUnit > 0x39 /* 9 */) {
        return false;
      }
    }
  }

  return true;
}
