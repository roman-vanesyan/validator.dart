import 'ipv4.dart';
import 'ipv6.dart';

/// Checks whether given [value] is either valid IPv4 or IPv6 address.
bool isIP(String value) => isIPv4(value) || isIPv6(value);
