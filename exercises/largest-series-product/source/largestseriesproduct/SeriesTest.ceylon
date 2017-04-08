import ceylon.test { ... }

// Tests adapted from x-common version 1.0.0
{[String, Integer, Integer?]*} cases => {
  ["29", 2, 18],
  ["0123456789", 2, 72],
  ["576802143", 2, 48],
  ["0123456789", 3, 504],
  ["1027839564", 3, 270],
  ["0123456789", 5, 15120],
  ["73167176531330624919225119674426574742355349194934", 6, 23520],
  ["0000", 2, 0],
  ["99099", 3, 0],
  ["123", 4, null],
  ["", 0, 1],
  ["123", 0, 1],
  ["", 1, null],
  ["1234a5", 2, null],
  ["12345", -1, null]
};

test
parameters(`value cases`)
void testLargestProduct(String digits, Integer window, Integer? expected) {
  value result = largestProduct(digits, window);
  if (exists expected) {
    assertEquals(result, expected);
  } else if (!is Error result) {
    fail("should have errored, but got ``result``");
  }
}
