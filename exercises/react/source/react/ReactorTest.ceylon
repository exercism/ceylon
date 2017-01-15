import ceylon.test { ... }

test
void inputCellsHaveValue() {
  value r = Reactor();
  value input = r.InputCell(10);
  assertEquals(input.currentValue, 10);
}

test
void inputCellsCanHaveValuesSet() {
  value r = Reactor();
  value input = r.InputCell(4);
  input.currentValue = 20;
  assertEquals(input.currentValue, 20);
}

test
void computeCellsCalculateInitialValue() {
  value r = Reactor();
  value input = r.InputCell(1);
  value output = r.ComputeCell.single(input, (x) => x + 1);
  assertEquals(output.currentValue, 2);
}

test
void computeCellsTakeInputInRightOrder() {
  value r = Reactor();
  value one = r.InputCell(1);
  value two = r.InputCell(2);
  value output = r.ComputeCell.double(one, two, (x, y) => x + y * 10);
  assertEquals(output.currentValue, 21);
}

test
void computeCellsUpdateValueWhenDependenciesChange() {
  value r = Reactor();
  value input = r.InputCell(1);
  value output = r.ComputeCell.single(input, (x) => x + 1);
  input.currentValue = 3;
  assertEquals(output.currentValue, 4);
}
