abstract class Error() of InvalidWindowSize | InvalidDigit {}
class InvalidWindowSize() extends Error() {
    shared actual default Boolean equals(Object that) => that is InvalidWindowSize;
}
class InvalidDigit(Character c) extends Error() {
    shared actual default Boolean equals(Object that) {
        if (is InvalidDigit that) {
            return that.c == c;
        }
        return false;
    }
}

Integer|Error largestProduct(String digits, Integer window) {
    if (window<0 || window>digits.size) {
        return InvalidWindowSize();
    }
    value invalids = [for (d in digits) if (!('0'..'9').contains(d)) d];
    if (nonempty invalids) {
        return InvalidDigit(invalids[0]);
    }
    value parsed = [for (d in digits) d.integer - '0'.integer];
    value ranges = { for (i in 0 .. (digits.size - window)) parsed[i:window] };
    return max({ for (r in ranges) r.fold(1)((acc, e) => acc * e) });
}
