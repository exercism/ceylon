import ceylon.test {
    ...
}

{[Integer, Boolean]*} cases => {
    [2015, false],
    [1970, false],
    [1996, true],
    [1960, true],
    [2100, false],
    [1900, false],
    [2000, true],
    [2400, true],
    [1800, false]
};

test
parameters (`value cases`)
void testLeapYear(Integer year, Boolean isLeap) {
    assertEquals(leapYear(year), isLeap);
}
