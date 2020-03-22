import 'package:test/test.dart';
import 'package:validator/src/lowercase.dart';

void main() {
  group('isLowerCase', () {
    test('it should work', () {
      expect(isLowerCase('string'), isTrue);

      expect(isLowerCase('STRING'), isFalse);
      expect(isLowerCase('StRinG'), isFalse);
      expect(isLowerCase('String'), isFalse);
    });
  });
}
