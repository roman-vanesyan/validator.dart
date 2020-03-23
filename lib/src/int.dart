import '_digit.dart';

const int _eof = -1;

/// Checks whether given [value] is an integer number.
///
/// ```dart
/// isInt('1234'); // => true
/// isInt('123.1'); // => false
/// isInt('0'); // => 0
/// ```
///
/// If [allowLeadingZeros] is set then it is allowed to put
/// any number of leading zeros.
///
/// ```dart
/// isInt('0123', allowedLeadingZeros: true) // => true
/// isInt('00', allowedLeadingZeros: true); // => true
/// ```
///
/// If [allowSigned] is set then it is also allowed to put
/// either minus (`-`) or plus (`+`) sign in front of the number.
///
/// ```dart
/// isInt('-123', allowedSigned: true); // => true
/// isInt('+0', allowedSigned: true); // => true
/// ```
///
/// It is allowed to set both [allowSigned] and [allowLeadingZeros].
bool isInt(String value,
    {bool allowSigned = false, bool allowLeadingZeros = false}) {
  final len = value.length;
  int offset = 0;

  @pragma('vm:prefer-inline')
  int next() {
    if (offset > len - 1) {
      return _eof;
    }

    return value.codeUnitAt(offset++);
  }

  int codeUnit = next();

  // Disallow sign if `allowSigned` is `false`.
  if (codeUnit == 0x2b /* + */ || codeUnit == 0x2d /* - */) {
    if (!allowSigned) {
      return false;
    }

    codeUnit = next();
  }

  if (!isDigit(codeUnit)) {
    return false;
  }

  // Disallow sign if `allowSigned` is `false`.
  if (!allowLeadingZeros) {
    final prev = codeUnit;
    codeUnit = next();

    if (prev == 0x30 /* 0 */ && codeUnit != _eof) {
      return false;
    }
  }

  while (isDigit(codeUnit)) {
    codeUnit = next();
  }

  if (codeUnit != _eof) {
    return false;
  }

  return true;
}
