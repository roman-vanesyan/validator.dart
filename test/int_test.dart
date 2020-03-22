import 'package:test/test.dart';
import 'package:validator/src/int.dart';

void main() {
  group('isInt', () {
    test('it should work', () {
      expect(isInt('1234'), isTrue);
      expect(isInt('0'), isTrue);
    });

    test('it should work with `allowLeadingZero`', () {
      expect(isInt('0100', allowLeadingZeros: true), isTrue);
      expect(isInt('0123', allowLeadingZeros: true), isTrue);

      expect(isInt('00123', allowLeadingZeros: true), isTrue);
      expect(isInt('00', allowLeadingZeros: true), isTrue);

      // Disallow leading zero without `allowLeadingZero` flag enabled.
      expect(isInt('012345'), isFalse);

      expect(isInt('123.123'), isFalse);
      expect(isInt('asd'), isFalse);
    });

    test('it should work with `allowSigned`', () {
      expect(isInt('-101', allowSigned: true), isTrue);
      expect(isInt('-0', allowSigned: true), isTrue);
      expect(isInt('+0', allowSigned: true), isTrue);

      // Disallow multiple signs.
      expect(isInt('-+1001', allowSigned: true), isFalse);
      expect(isInt('-10-1', allowSigned: true), isFalse);

      // Disallow sign without `allowSigned` flag disabled.
      expect(isInt('-10'), isFalse);

      expect(isInt('-'), isFalse);
      expect(isInt('+-'), isFalse);
    });

    test('it should work with both `allowLeadingZero` and `allowSigned`', () {
      expect(
          isInt('-0100', allowSigned: true, allowLeadingZeros: true), isTrue);
      expect(
          isInt('-00123', allowSigned: true, allowLeadingZeros: true), isTrue);
    });
  });
}
