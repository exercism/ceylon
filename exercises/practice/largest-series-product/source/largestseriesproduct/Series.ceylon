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
    return nothing;
}
