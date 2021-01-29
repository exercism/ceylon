import ceylon.test {
    ...
}

{[String, String|Null]*} cases => {
    // empty strand
    ["", ""],
    // single C nucleotide strand
    ["C", "G"],
    // single G nucleotide strand
    ["G", "C"],
    // single A nucleotide strand
    ["A", "U"],
    // single T nucleotide strand
    ["T", "A"],
    // longer strand
    ["ACGTGGTCTTAA", "UGCACCAGAAUU"],
    // The Ceylon track keeps these Error cases,
    // from problem-specifications 1.0.1 (removed in 1.1.0)
    // strand with DNA nucleotides
    ["U", null],
    // strand with invalid nucleotides
    ["XCGFGGTDTTAA", null],
    // strand with invalid nucleotides after the first nucleotide
    ["ACGTFGTBTEAA", null]
};

test
parameters (`value cases`)
void testHamming(String dna, String|Null expected) {
    if (exists expected) {
        assertEquals(transcription(dna), expected);
    } else if (!is Error result = transcription(dna)) {
        fail("should have errored, but got ``result``");
    }
}
