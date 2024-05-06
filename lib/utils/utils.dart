double? parseStringToDouble(String input) {
  try {
    return double.parse(input);
  } catch (e) {
    // Parsing failed
    return null;
  }
}