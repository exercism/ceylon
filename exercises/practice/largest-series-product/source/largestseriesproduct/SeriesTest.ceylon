import ceylon.test {
    ...
}

{[String, Integer, Integer|Error]*} cases => {
    // finds the largest product if span equals length
    ["29", 2, 18],
    // can find the largest product of 2 with numbers in order
    ["0123456789", 2, 72],
    // can find the largest product of 2
    ["576802143", 2, 48],
    // can find the largest product of 3 with numbers in order
    ["0123456789", 3, 504],
    // can find the largest product of 3
    ["1027839564", 3, 270],
    // can find the largest product of 5 with numbers in order
    ["0123456789", 5, 15120],
    // can get the largest product of a big number
    ["73167176531330624919225119674426574742355349194934", 6, 23520],
    // reports zero if the only digits are zero
    ["0000", 2, 0],
    // reports zero if all spans include zero
    ["99099", 3, 0],
    // rejects span longer than string length
    ["123", 4, InvalidWindowSize()],
    // rejects empty string and nonzero span
    ["", 1, InvalidWindowSize()],
    // rejects invalid character in digits
    ["1234a5", 2, InvalidDigit('a')],
    // rejects negative span
    ["12345", -1, InvalidWindowSize()]
};

test
parameters (`value cases`)
void testLargestProduct(String digits, Integer window, Integer|Error expected) {
    assertEquals(largestProduct(digits, window), expected);
}
