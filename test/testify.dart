import 'package:test/test.dart';

void testify(bool Function(String v) f,
    {required List<String> valid, required List<String> invalid}) {
  for (final t in valid) {
    expect(f(t), isTrue, reason: 'expect to accept $t');
  }

  for (final t in invalid) {
    expect(f(t), isFalse, reason: 'expect to reject $t');
  }
}
