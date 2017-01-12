{String*} anagrams(String subject, {String*} candidates) {
  value lower = subject.lowercased;
  value chars = sort(lower);
  return candidates.filter((c) {
    value lowerCandidate = c.lowercased;
    return lower != lowerCandidate && chars == sort(lowerCandidate);
  });
}
