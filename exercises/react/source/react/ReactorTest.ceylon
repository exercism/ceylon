import ceylon.test { ... }

test
void inputCellsHaveValue() {
  value r = Reactor();
  value input = r.newInputCell(10);
  assertEquals(input.currentValue, 10);
}

test
void inputCellsCanHaveValuesSet() {
  value r = Reactor();
  value input = r.newInputCell(4);
  input.currentValue = 20;
  assertEquals(input.currentValue, 20);
}

test
void computeCellsCalculateInitialValue() {
  value r = Reactor();
  value input = r.newInputCell(1);
  value output = r.newComputeCell1(input, (x) => x + 1);
  assertEquals(output.currentValue, 2);
}

test
void computeCellsTakeInputInRightOrder() {
  value r = Reactor();
  value one = r.newInputCell(1);
  value two = r.newInputCell(2);
  value output = r.newComputeCell2(one, two, (x, y) => x + y * 10);
  assertEquals(output.currentValue, 21);
}

test
void computeCellsUpdateValueWhenDependenciesChange() {
  value r = Reactor();
  value input = r.newInputCell(1);
  value output = r.newComputeCell1(input, (x) => x + 1);
  input.currentValue = 3;
  assertEquals(output.currentValue, 4);
}

test
void computeCellsCanDependOnOtherComputeCells() {
  value r = Reactor();
  value input = r.newInputCell(1);
  value timesTwo = r.newComputeCell1(input, (x) => x * 2);
  value timesThirty = r.newComputeCell1(input, (x) => x * 30);
  value output = r.newComputeCell2(timesTwo, timesThirty, (x, y) => x + y);

  assertEquals(output.currentValue, 32);
  input.currentValue = 3;
  assertEquals(output.currentValue, 96);
}

test
void computeCellsFireCallbacks() {
  value r = Reactor();
  value input = r.newInputCell(1);
  value output = r.newComputeCell1(input, (x) => x + 1);

  variable Element[] vals = [];
  output.addCallback((x) => vals = vals.withTrailing(x));

  input.currentValue = 3;
  assertEquals(vals, [4]);
}

test
void callbacksOnlyFireOnChange() {
  value r = Reactor();
  value input = r.newInputCell(1);
  value output = r.newComputeCell1(input, (x) => if (x < 3) then 111 else 222);

  variable Element[] vals = [];
  output.addCallback((x) => vals = vals.withTrailing(x));

  input.currentValue = 2;
  assertEquals(vals, []);

  input.currentValue = 4;
  assertEquals(vals, [222]);
}

test
void callbacksCanBeAddedAndRemoved() {
  value r = Reactor();
  value input = r.newInputCell(11);
  value output = r.newComputeCell1(input, (x) => x + 1);

  variable Element[] vals1 = [];
  value sub1 = output.addCallback((x) => vals1 = vals1.withTrailing(x));
  variable Element[] vals2 = [];
  output.addCallback((x) => vals2 = vals2.withTrailing(x));

  input.currentValue = 31;

  sub1.cancel();
  variable Element[] vals3 = [];
  output.addCallback((x) => vals3 = vals3.withTrailing(x));

  input.currentValue = 41;

  assertEquals(vals1, [32]);
  assertEquals(vals2, [32, 42]);
  assertEquals(vals3, [42]);
}

test
void removingCallbackMultipleTimesDoesntInterfereWithOtherCallbacks() {
  value r = Reactor();
  value input = r.newInputCell(1);
  value output = r.newComputeCell1(input, (x) => x + 1);

  variable Element[] vals1 = [];
  value sub1 = output.addCallback((x) => vals1 = vals1.withTrailing(x));
  variable Element[] vals2 = [];
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
  value r = Reactor();
  value input = r.newInputCell(1);
  value plusOne = r.newComputeCell1(input, (x) => x + 1);
  value minusOne1 = r.newComputeCell1(input, (x) => x - 1);
  value minusOne2 = r.newComputeCell1(minusOne1, (x) => x - 1);
  value output = r.newComputeCell2(plusOne, minusOne2, (x, y) => x * y);

  variable Element[] vals = [];
  output.addCallback((x) => vals = vals.withTrailing(x));

  input.currentValue = 4;
  assertEquals(vals, [10]);
}

test
void callbacksAreNotCalledIfDependenciesChangeButOutputValueDoesntChange() {
  value r = Reactor();
  value input = r.newInputCell(1);
  value plusOne = r.newComputeCell1(input, (x) => x + 1);
  value minusOne = r.newComputeCell1(input, (x) => x - 1);
  value alwaysTwo = r.newComputeCell2(plusOne, minusOne, (x, y) => x - y);

  variable Element[] vals = [];
  alwaysTwo.addCallback((x) => vals = vals.withTrailing(x));

  for (i in 1..10) {
    input.currentValue = i;
  }
  assertEquals(vals, []);
}
