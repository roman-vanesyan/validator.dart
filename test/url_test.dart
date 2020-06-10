import 'package:test/test.dart';
import 'package:validator/src/url.dart';

void main() {
  group('isUrl', () {
    test('it should work', () {
      expect(isUrl('http://example.com/'), isTrue);
      expect(isUrl('//example.com/'), isTrue);
    });
  });
}
