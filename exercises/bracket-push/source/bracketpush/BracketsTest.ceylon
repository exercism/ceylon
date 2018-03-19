import ceylon.test {
    ...
}

// Tests adapted from problem-specifications version 1.2.0

{[String, Boolean]*} cases => {
    // paired square brackets
    ["[]", true],
    // empty string
    ["", true],
    // unpaired brackets
    ["[[", false],
    // wrong ordered brackets
    ["}{", false],
    // wrong closing bracket
    ["{]", false],
    // paired with whitespace
    ["{ }", true],
    // simple nested brackets
    ["{[]}", true],
    // several paired brackets
    ["{}[]", true],
    // paired and nested brackets
    ["([{}({}[])])", true],
    // unopened closing brackets
    ["{[)][]}", false],
    // unpaired and nested brackets
    ["([{])", false],
    // paired and wrong nested brackets
    ["[({]})", false],
    // math expression
    ["(((185 + 223.85) * 15) - 543)/2", true],
    // complex latex expression
    ["\\left(\\begin{array}{cc} \\frac{1}{3} & x\\\\ \\mathrm{e}^{x} &... x^2 \\end{array}\\right)", true]
};

test
parameters (`value cases`)
void testBalanced(String brackets, Boolean expected) {
    assertEquals(balanced(brackets), expected);
}
