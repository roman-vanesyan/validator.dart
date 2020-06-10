import '_number.dart';

/// Checks whether given [value] is an integer number.
///
/// ```dart
/// isInt('1234'); // => true
/// isInt('123.1'); // => false
/// isInt('0'); // => 0
/// ```
///
/// If [allowLeadingZero] is set then it is allowed to put
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
/// It is allowed to set both [allowSigned] and [allowLeadingZero].
bool isInt(String value,
        {bool allowSigned = false, bool allowLeadingZero = false}) =>
    isNumber(value, false,
        allowSigned: allowSigned, allowLeadingZero: allowLeadingZero);
