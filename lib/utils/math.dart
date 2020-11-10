const ONE_THOUSAND = 1000;

/// Zeros least significant digits
int simplifyNumber(int val) {
  int multiplier = 1;
  while (val > ONE_THOUSAND) {
    val = (val ~/ ONE_THOUSAND).floor();
    multiplier *= ONE_THOUSAND;
  }
  return val * multiplier;
}
