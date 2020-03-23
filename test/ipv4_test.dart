import 'package:test/test.dart';
import 'package:validator/src/ipv4.dart';

void main() {
  group('isIPv4', () {
    test('it should work', () {
      expect(isIPv4('0.0.0.0'), isTrue);
      expect(isIPv4('0.255.0.255'), isTrue);
      expect(isIPv4('127.0.0.1'), isTrue);
      expect(isIPv4('192.168.0.1'), isTrue);

      // Broken string.
      expect(isIPv4('asd'), isFalse);
      expect(isIPv4('asd.asd.asd.asd'), isFalse);

      // Incomplete IP
      expect(isIPv4('192.168.0'), isFalse);
      expect(isIPv4('192.168..0'), isFalse);
      expect(isIPv4('192..0.0'), isFalse);
      expect(isIPv4('192...0'), isFalse);
      expect(isIPv4('.0.0.0'), isFalse);

      // Octet part.
      expect(isIPv4('00.0.0.0'), isFalse);
      expect(isIPv4('0.00.0.0'), isFalse);
      expect(isIPv4('0.0.00.0'), isFalse);
      expect(isIPv4('0.0.0.00'), isFalse);
      expect(isIPv4('020.200.200.200'), isFalse);
      expect(isIPv4('200.020.200.200'), isFalse);
      expect(isIPv4('200.200.020.200'), isFalse);
      expect(isIPv4('200.200.200.020'), isFalse);

      // Some part is bigger than 255.
      expect(isIPv4('0.256.0.256'), isFalse);
      expect(isIPv4('0.0.0.256'), isFalse);
      expect(isIPv4('255.256.255.256'), isFalse);
    });
  });
}
