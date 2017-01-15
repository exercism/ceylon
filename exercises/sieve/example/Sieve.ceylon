import ceylon.numeric.float { sqrt }

{Integer*} primesUpTo(Integer max) {
  // if max < 4, sqrt(max) < 2, so 2..sqrt(max) gives decreasing values.
  // Prevent this by just returning the small primes here:
  if (max < 4) {
    return {2, 3}.takeWhile((c) => c <= max);
  }

  value prime = Array.ofSize(max + 1, true);
  prime[0] = false;
  prime[1] = false;

  for (i in 2..(sqrt(max.float).integer)) {
    if (!(prime[i] else false)) {
      continue;
    }

    for (multiple in ((i * i)..max).by(i)) {
      prime[multiple] = false;
    }
  }
  return { for (i -> p in prime.indexed) if (p) i };
}
