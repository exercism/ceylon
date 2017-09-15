import ceylon.test { ... }

// Tests adapted from problem-specifications version 1.0.0

test
void inputCellsHaveValue() {
  value r = Reactor<Integer>();
  value input = r.InputCell(10);
  assertEquals(input.currentValue, 10);
}

test
void inputCellsCanHaveValuesSet() {
  value r = Reactor<Integer>();
  value input = r.InputCell(4);
  input.currentValue = 20;
  assertEquals(input.currentValue, 20);
}

test
void computeCellsCalculateInitialValue() {
  value r = Reactor<Integer>();
  value input = r.InputCell(1);
  value output = r.ComputeCell.single(input, (Integer x) => x + 1);
  assertEquals(output.currentValue, 2);
}

test
void computeCellsTakeInputInRightOrder() {
  value r = Reactor<Integer>();
  value one = r.InputCell(1);
  value two = r.InputCell(2);
  value output = r.ComputeCell.double(one, two, (Integer x, Integer y) => x + y * 10);
  assertEquals(output.currentValue, 21);
}

test
void computeCellsUpdateValueWhenDependenciesChange() {
  value r = Reactor<Integer>();
  value input = r.InputCell(1);
  value output = r.ComputeCell.single(input, (Integer x) => x + 1);
  input.currentValue = 3;
  assertEquals(output.currentValue, 4);
}

test
void computeCellsCanDependOnOtherComputeCells() {
  value r = Reactor<Integer>();
  value input = r.InputCell(1);
  value timesTwo = r.ComputeCell.single(input, (Integer x) => x * 2);
  value timesThirty = r.ComputeCell.single(input, (Integer x) => x * 30);
  value output = r.ComputeCell.double(timesTwo, timesThirty, (Integer x, Integer y) => x + y);

  assertEquals(output.currentValue, 32);
  input.currentValue = 3;
  assertEquals(output.currentValue, 96);
}

test
void computeCellsFireCallbacks() {
  value r = Reactor<Integer>();
  value input = r.InputCell(1);
  value output = r.ComputeCell.single(input, (Integer x) => x + 1);

  variable Integer[] vals = [];
  output.addCallback((x) => vals = vals.withTrailing(x));

  input.currentValue = 3;
  assertEquals(vals, [4]);
}

test
void callbacksOnlyFireOnChange() {
  value r = Reactor<Integer>();
  value input = r.InputCell(1);
  value output = r.ComputeCell.single(input, (Integer x) => if (x < 3) then 111 else 222);

  variable Integer[] vals = [];
  output.addCallback((x) => vals = vals.withTrailing(x));

  input.currentValue = 2;
  assertEquals(vals, []);

  input.currentValue = 4;
  assertEquals(vals, [222]);
}

test
void callbacksCanBeAddedAndRemoved() {
  value r = Reactor<Integer>();
  value input = r.InputCell(11);
  value output = r.ComputeCell.single(input, (Integer x) => x + 1);

  variable Integer[] vals1 = [];
  value sub1 = output.addCallback((x) => vals1 = vals1.withTrailing(x));
  variable Integer[] vals2 = [];
  output.addCallback((x) => vals2 = vals2.withTrailing(x));

  input.currentValue = 31;

  sub1.cancel();
  variable Integer[] vals3 = [];
  output.addCallback((x) => vals3 = vals3.withTrailing(x));

  input.currentValue = 41;

  assertEquals(vals1, [32]);
  assertEquals(vals2, [32, 42]);
  assertEquals(vals3, [42]);
}

test
void removingCallbackMultipleTimesDoesntInterfereWithOtherCallbacks() {
  value r = Reactor<Integer>();
  value input = r.InputCell(1);
  value output = r.ComputeCell.single(input, (Integer x) => x + 1);

  variable Integer[] vals1 = [];
  value sub1 = output.addCallback((x) => vals1 = vals1.withTrailing(x));
  variable Integer[] vals2 = [];
  output.addCallback((x) => vals2 = vals2.withTrailing(x));

  for (i in 1..10) {
    sub1.cancel();
  }

  input.currentValue = 2;
  assertEquals(vals1, []);
  assertEquals(vals2, [3]);
}

test
void callbacksAreOnlyCalledOnceEvenIfMultipleDependenciesChange() {
  value r = Reactor<Integer>();
  value input = r.InputCell(1);
  value plusOne = r.ComputeCell.single(input, (Integer x) => x + 1);
  value minusOne1 = r.ComputeCell.single(input, (Integer x) => x - 1);
  value minusOne2 = r.ComputeCell.single(minusOne1, (Integer x) => x - 1);
  value output = r.ComputeCell.double(plusOne, minusOne2, (Integer x, Integer y) => x * y);

  variable Integer[] vals = [];
  output.addCallback((x) => vals = vals.withTrailing(x));

  input.currentValue = 4;
  assertEquals(vals, [10]);
}

test
void callbacksAreNotCalledIfDependenciesChangeButOutputValueDoesntChange() {
  value r = Reactor<Integer>();
  value input = r.InputCell(1);
  value plusOne = r.ComputeCell.single(input, (Integer x) => x + 1);
  value minusOne = r.ComputeCell.single(input, (Integer x) => x - 1);
  value alwaysTwo = r.ComputeCell.double(plusOne, minusOne, (Integer x, Integer y) => x - y);

  variable Integer[] vals = [];
  alwaysTwo.addCallback((x) => vals = vals.withTrailing(x));

  for (i in 1..10) {
    input.currentValue = i;
  }
  assertEquals(vals, []);
}

{[Boolean, Boolean, Boolean, Boolean, Boolean]*} adderCases => {
  [false, false, false, false, false],
  [false, false, true, false, true],
  [false, true, false, false, true],
  [false, true, true, true, false],
  [true, false, false, false, true],
  [true, false, true, true, false],
  [true, true, false, true, false],
  [true, true, true, true, true]
};

test
parameters(`value adderCases`)
// This is a digital logic circuit called an adder:
// https://en.wikipedia.org/wiki/Adder_(electronics)
void testAdder(Boolean aval, Boolean bval, Boolean cinval, Boolean expectCout, Boolean expectSum) {
  value r = Reactor<Boolean>();
  value a = r.InputCell(aval);
  value b = r.InputCell(bval);
  value carryIn = r.InputCell(cinval);

  value aXorB = r.ComputeCell.double(a, b, (Boolean a, Boolean b) => a != b);
  value sum = r.ComputeCell.double(aXorB, carryIn, (Boolean axorb, Boolean cin) => axorb != cin);

  value aXorBAndCin = r.ComputeCell.double(aXorB, carryIn, (Boolean axorb, Boolean cin) => axorb && cin);
  value aAndB = r.ComputeCell.double(a, b, (Boolean a, Boolean b) => a && b);
  value carryOut = r.ComputeCell.double(aXorBAndCin, aAndB, (Boolean a, Boolean b) => a || b);

  // Test them both at once so if they fail we get to see both values.
  [Boolean, Boolean] expected = [expectSum, expectCout];
  [Boolean, Boolean] observed = [sum.currentValue, carryOut.currentValue];
  assertEquals(expected, observed);
}
