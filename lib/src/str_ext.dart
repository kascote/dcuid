/// String extension
extension StringSlice on String {
  /// Returns a portion of the script.
  /// if the value is positive starts from the beginning
  /// ex:  "hola".slice(2) => "ho"
  ///
  /// if the value is negative, starts from the end
  /// ex: "hola".slice(-2) =-> la
  String slice(int value) {
    if (value >= 0) {
      if (value > length) return this;
      return substring(0, value);
    }

    final startPosition = length - value.abs();
    if (startPosition < 0) return this;

    return substring(startPosition);
  }
}
