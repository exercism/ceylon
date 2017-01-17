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
