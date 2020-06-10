/// Checks whether given [value] is a valid IP v6 address.
bool isIPv6(String value) {
  // TODO: Optimize to avoid throwing-and-recatching.
  try {
    Uri.parseIPv6Address(value);
  } on FormatException {
    return false;
  }

  return true;
}

enum PartType {
  ipv4,
  hex,
  wildcard,
}

bool isA(String value) {
  final len = value.length;
  bool isWildcardSeen = false;
  final parts = <PartType>[];

  for (int i = 0; i < len; i++) {
    final codeUnit = value.codeUnitAt(i);

    if (codeUnit == 0x3a /* : */) {
      if (i == 0) {
        // If we see a `:` in the beginning, expect wildcard.
        if (value.codeUnitAt(++i) != 0x3a) {
          return false;
        }

        isWildcardSeen = true;
        parts.add(PartType.wildcard);
      }
    }
  }

  // Colon without joint part.
  if (parts.last == PartType.wildcard) {
    return false;
  }

  return true;
}
