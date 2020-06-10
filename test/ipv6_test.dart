import 'package:test/test.dart';
import 'package:validator/src/ipv6.dart';

void main() {
  group('isIPv6', () {
    test('it should work', () {
      expect(isIPv6('::1'), isTrue);

      // Disallow 3 colons.
      expect(isIPv6(':::1'), isFalse);

      // Wildcard can only be at the beginning of the IP address.
      expect(isIPv6('::2::1'), isFalse);
    });
  }, skip: true);
}
