import ceylon.test {
    ...
}

// Tests adapted from problem-specifications version 2.1.1

{[String, String, Integer?]*} cases => {
    // identical strands
    ["A", "A", 0],
    // long identical strands
    ["GGACTGA", "GGACTGA", 0],
    // complete distance in single nucleotide strands
    ["A", "G", 1],
    // complete distance in small strands
    ["AG", "CT", 2],
    // small distance in small strands
    ["AT", "CT", 1],
    // small distance
    ["GGACG", "GGTCG", 1],
    // small distance in long strands
    ["ACCAGGG", "ACTATGG", 2],
    // non-unique character in first strand
    ["AAG", "AAA", 1],
    // non-unique character in second strand
    ["AAA", "AAG", 1],
    // same nucleotides in different positions
    ["TAG", "GAT", 2],
    // large distance
    ["GATACA", "GCATAA", 4],
    // large distance in off-by-one strand
    ["GGACGGATTCTG", "AGGACGGATTCT", 9],
    // empty strands
    ["", "", 0],
    // disallow first strand longer
    ["AATG", "AAA", null],
    // disallow second strand longer
    ["ATA", "AGTG", null]
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
