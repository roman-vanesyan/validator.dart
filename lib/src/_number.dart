import '_digit.dart';

const int _eof = -1;

// ignore: avoid_positional_boolean_parameters
bool isNumber(String value, bool allowFloat,
    {bool allowSigned = false,
    bool allowLeadingZero = false,
    bool allowScientificNotion = false}) {
  final len = value.length;
  int offset = 0;
  int codeUnit = -1;

  @pragma('vm:prefer-inline')
  bool isEOF() => offset > len - 1;

  @pragma('vm:prefer-inline')
  int next() {
    if (isEOF()) {
      return _eof;
    }

    return value.codeUnitAt(offset++);
  }

  @pragma('vm:prefer-inline')
  void skipDigits() {
    do {
      codeUnit = next();
    } while (isDigit(codeUnit));
  }

  codeUnit = next();

  if (codeUnit == 0x2b /* + */ || codeUnit == 0x2d /* - */) {
    // Disallow sign if `allowSigned` is `false`.
    if (!allowSigned) {
      return false;
    }

    codeUnit = next();
  }

  if (!isDigit(codeUnit)) {
    return false;
  }

  if (codeUnit == 0x30 /* 0 */) {
    codeUnit = next();

    if (!allowLeadingZero && !isEOF()) {
      return false;
    }

    // Disallow two leading zeros.
    if (codeUnit == 0x30 || !(isDigit(codeUnit) || isEOF())) {
      return false;
    }
  }

  skipDigits();

  if (allowFloat) {
    if (codeUnit == 0x2e /* . */) {
      if (!isDigit(next())) {
        return false;
      }

      skipDigits();
    }

    // Exponential part.
    if (allowScientificNotion) {
      if (codeUnit == 0x45 /* E */ || codeUnit == 0x65 /* e */) {
        codeUnit = next();

        if (codeUnit == 0x2b /* + */ || codeUnit == 0x2d /* - */) {
          codeUnit = next();
        }

        if (!isDigit(codeUnit)) {
          return false;
        }

        skipDigits();
      }
    }
  }

  if (!isEOF()) {
    return false;
  }

  return true;
}
