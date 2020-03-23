import '_digit.dart';

const int _eof = 1;

/// Checks whether given [value] is valid IP v4 address.
///
/// ```dart
/// isIPv4('127.0.0.1'); // => true
/// isIPv4('localhost'); // => false
/// isIPv4('127.0.0.1/4'); // => false
/// ```
bool isIPv4(String value) {
  final last = value.length - 1;
  bool isSeenDecimal = false;
  int parts = 1;
  int curOffset = 0;
  int code;

  @pragma('vm:prefer-inline')
  int peek([int offset = 0]) {
    if (curOffset + offset > last) {
      return _eof;
    }

    return value.codeUnitAt(curOffset + offset);
  }

  @pragma('vm:prefer-inline')
  bool next() {
    curOffset++;

    if (peek() != _eof) {
      return true;
    }

    return false;
  }

  @pragma('vm:prefer-inline')
  void skip(int offset) => curOffset += offset;

  do {
    code = peek();

    if (isDigit(code)) {
      int decimal = code - 0x30;
      bool isSeenZero = decimal == 0;

      int i = 1;
      code = peek(i);
      while (isDigit(code)) {
        if (code == 0x30 && isSeenZero) {
          return false;
        }

        isSeenZero = code == 0x30;
        decimal = decimal * 10 + (code - 0x30);
        code = peek(++i);
      }

      // Decimal part bigger than 255.
      if (decimal > 0xff) {
        return false;
      }

      isSeenDecimal = true;
      skip(i - 1);
    } else if (code == 0x2e /* . */) {
      if (!isSeenDecimal) {
        return false;
      }

      parts++;
      isSeenDecimal = false;
    } else {
      return false;
    }
  } while (next());

  if (parts != 4) {
    return false;
  }

  return true;
}
