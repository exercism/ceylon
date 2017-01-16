class Error() {}

Integer|Error largestProduct(String digits, Integer window) {
  if (window < 0 || window > digits.size) {
    return Error();
  }
  value parsed = [for (d in digits) if (('0'..'9').contains(d)) d.integer - '0'.integer];
  if (parsed.size < digits.size) {
    return Error();
  }
  value ranges = {for (i in 0..(digits.size - window)) parsed[i:window]};
  return max({for (r in ranges) r.fold(1)((acc, e) => acc * e)});
}
