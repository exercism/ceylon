import ceylon.test {
    ...
}

{[String, String, Integer?]*} cases => {
    // empty strands
    ["", "", 0],
    // single letter identical strands
    ["A", "A", 0],
    // single letter different strands
    ["G", "T", 1],
    // long identical strands
    ["GGACTGAAATCTG", "GGACTGAAATCTG", 0],
    // long different strands
    ["GGACGGATTCTG", "AGGACGGATTCT", 9],
    // disallow first strand longer
    ["AATG", "AAA", null],
    // disallow second strand longer
    ["ATA", "AGTG", null],
    // disallow left empty strand
    ["", "G", null],
    // disallow right empty strand
    ["G", "", null]
};

test
parameters (`value cases`)
void testHamming(String s1, String s2, Integer? expected) {
    value result = distance(s1, s2);
    if (exists expected) {
        assertEquals(result, expected);
    } else if (!is Error result) {
        fail("should have errored, but got ``result``");
    }
}
