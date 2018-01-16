import ceylon.test { ... }

// Tests adapted from problem-specifications version 1.3.0
{[Integer, Boolean]*} cases =>
  {[2015, false], [1996, true], [2100, false], [2000, true]};

test
parameters(`value cases`)
void testLeapYear(Integer year, Boolean isLeap) {
  assertEquals(leapYear(year), isLeap);
}
