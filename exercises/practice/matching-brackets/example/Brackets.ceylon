import ceylon.collection {
    ArrayList
}

Map<Character,Character> openFor = map { '}'->'{', ')'->'(', ']'->'[' };
Set<Character> opens = set(openFor.items);

Boolean balanced(String brackets) {
    value expectedOpens = ArrayList<Character>();
    for (c in brackets) {
        if (opens.contains(c)) {
            expectedOpens.push(c);
        } else if (exists open = openFor[c]) {
            if ((expectedOpens.pop() else '!') != open) {
                return false;
            }
        }
    }
    return expectedOpens.empty;
}
