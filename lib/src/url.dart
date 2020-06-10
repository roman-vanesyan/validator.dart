/// Checks whether [value] is valid URL.
///
/// If [protocols] is non-empty list of protocols then protocol of given
/// parsed URL will be validated against it, otherwise any protocol
/// considered as valid.
bool isUrl(String value, {List<String> protocols = const []}) {
  /* late final */ Uri parsedUri;

  try {
    parsedUri = Uri.parse(value);
  } on FormatException {
    return false;
  }

  // Check if protocols is non-empty list and protocol is valid one.
  if (protocols.isNotEmpty && !protocols.contains(parsedUri.scheme)) {
    return false;
  }

  return true;
}
