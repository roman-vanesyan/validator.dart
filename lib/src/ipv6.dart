import 'ipv4.dart';

/// Checks whether given [value] is a valid IP v6 address.
/// An IPv6 address consists of exactly 8 parts of 1-4 hex digits, separated
/// by `:`'s, with the following exceptions:
///
///  - One (and only one) wildcard (`::`) may be present, representing a fill
///    of 0's. The IPv6 `::` is thus 16 bytes of `0`.
///  - The last two parts may be replaced by an IPv4 "dotted-quad" address.
bool isIPv6(final String value) {
  int partsCount = 0;
  bool isLastWildcard = false;

  String val = value;

  if (val.contains('%')) {
    final parts = val.split('%');

    // IPv6 must consist exactly from 2 parts, if '%' is presented.
    if (parts.length > 2) {
      return false;
    } else if (parts.length == 2) {
      // TODO: should we validate zone representation?
      final zone = parts[1];
      if (zone.isEmpty) {
        return false;
      }

      val = parts[0];
    }
  }

  final end = val.length;

  @pragma('vm:prefer-inline')
  bool isValidHexPart(int start, int end) {
    if (end - start > 4) return false;

    final v = int.parse(val.substring(start, end), radix: 16);
    if (v < 0 || v > 0xFFFF) return false;

    return true;
  }

  // Address is too short.
  if (val.length < 2) return false;

  bool wildcardSeen = false;
  // Set if seeing a ".", suggesting that there is an IPv4 address.
  bool seenDot = false;
  int partStart = 0;

  // Parse all parts, except a potential last one.
  for (int i = 0; i < end; i++) {
    final char = val.codeUnitAt(i);
    if (char == 0x3a /* : */) {
      if (i == 0) {
        // If we see a `:` in the beginning, expect wildcard.
        i++;

        // Invalid start colon.
        if (val.codeUnitAt(i) != 0x3a /* : */) return false;
        partStart = i;
      }

      if (i == partStart) {
        // Only one wildcard `::` is allowed
        if (wildcardSeen) {
          return false;
        }

        wildcardSeen = true;
        isLastWildcard = true;
        partsCount += 1;
      } else {
        // Found a single colon. Parse [partStart..i] as a hex entry.
        if (!isValidHexPart(partStart, i)) return false;

        isLastWildcard = false;
        partsCount += 1;
      }

      partStart = i + 1;
    } else if (char == 0x2e /* . */) {
      seenDot = true;
    }
  }

  // Too few parts.
  if (partsCount == 0) return false;

  final bool atEnd = partStart == end;

  // Expect a part after last `:`
  if (atEnd && !isLastWildcard) return false;

  if (!atEnd) {
    if (!seenDot) {
      if (!isValidHexPart(partStart, end)) return false;
      partsCount+= 1;
    } else {
      if (!isIPv4(val.substring(partStart, end))) {
        return false;
      }

      partsCount += 2;
    }
  }

  if (wildcardSeen) {
    // An address with a wildcard must have less than 7 parts
    if (partsCount > 7) {
      return false;
    }

    // An address without a wildcard must contain exactly 8 parts
  } else if (partsCount != 8) {
    return false;
  }

  return true;
}
