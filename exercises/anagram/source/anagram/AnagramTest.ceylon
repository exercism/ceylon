import ceylon.test {
    ...
}

// Tests adapted from problem-specifications version 1.4.1

{[String, {String*}, {String*}]*} cases => {
    // no matches
    ["diaper", { "hello", "world", "zombies", "pants" }, {}],
    // detects two anagrams
    ["master", { "stream", "pigeon", "maters" }, { "stream", "maters" }],
    // does not detect anagram subsets
    ["good", { "dog", "goody" }, {}],
    // detects anagram
    ["listen", { "enlists", "google", "inlets", "banana" }, { "inlets" }],
    // detects three anagrams
    [
        "allergy",
        { "gallery", "ballerina", "regally", "clergy", "largely", "leading" },
        { "gallery", "regally", "largely" }
    ],
    // does not detect non-anagrams with identical checksum
    ["mass", { "last" }, {}],
    // detects anagrams case-insensitively
    ["Orchestra", { "cashregister", "Carthorse", "radishes" }, { "Carthorse" }],
    // detects anagrams using case-insensitive subject
    ["Orchestra", { "cashregister", "carthorse", "radishes" }, { "carthorse" }],
    // detects anagrams using case-insensitive possible matches
    ["orchestra", { "cashregister", "Carthorse", "radishes" }, { "Carthorse" }],
    // does not detect an anagram if the original word is repeated
    ["go", { "go Go GO" }, {}],
    // anagrams must use all letters exactly once
    ["tapper", { "patter" }, {}],
    // words are not anagrams of themselves (case-insensitive)
    ["BANANA", { "BANANA", "Banana", "banana" }, {}]
};

test
parameters (`value cases`)
void testAnagram(String subject, {String*} candidates, {String*} expected) {
    assertEquals(sort(anagrams(subject, candidates)), sort(expected));
}
