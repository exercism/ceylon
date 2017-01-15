import ceylon.test { ... }

test
void inputCellsHaveValue() {
  value r = Reactor();
  value input = r.InputCell<Integer>(10);
  assertEquals(input.currentValue, 10);
}

test
void inputCellsCanHaveValuesSet() {
  value r = Reactor();
  value input = r.InputCell<Integer>(4);
  input.currentValue = 20;
  assertEquals(input.currentValue, 20);
}

test
void computeCellsCalculateInitialValue() {
  value r = Reactor();
  value input = r.InputCell<Integer>(1);
  value output = r.ComputeCell<Integer>.single(input, (x) => x + 1);
  assertEquals(output.currentValue, 2);
}
