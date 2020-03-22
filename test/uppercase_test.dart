import 'package:test/test.dart';
import 'package:validator/src/uppercase.dart';

void main() {
  group('isUpperCase', () {
    test('it should work', () {
      expect(isUpperCase('STRING'), isTrue);

      expect(isUpperCase('string'), isFalse);
      expect(isUpperCase('StRinG'), isFalse);
      expect(isUpperCase('String'), isFalse);
    });
  });
}
