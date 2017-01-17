alias Element => Integer;

class Reactor() {
  shared abstract class Cell() {
    shared formal Element currentValue;
    variable ComputeCell[] dependents = [];
    shared void addDependent(ComputeCell c) {
      dependents = dependents.withTrailing(c);
    }
    shared void eachDependent(Anything(ComputeCell) f) {
      for (dep in dependents) {
        f(dep);
      }
    }
  }

  shared class InputCell(Element initialValue) extends Cell() {
    variable Element currentValue_ = initialValue;
    shared actual Element currentValue => currentValue_;
    assign currentValue {
      currentValue_ = currentValue;
      eachDependent((d) => d.propagate());
    }
  }

  shared InputCell newInputCell(Element initialValue) {
    return InputCell(initialValue);
  }

  shared class ComputeCell(Element() newValue) extends Cell() {
    variable Element currentValue_ = newValue();
    shared actual Element currentValue => currentValue_;

    shared void propagate() {
      value nv = newValue();
      if (nv != currentValue) {
        currentValue_ = nv;
        eachDependent((d) => d.propagate());
      }
    }
  }

  shared ComputeCell newComputeCell1(Cell c, Element(Element) f) {
    value cell = ComputeCell(() => f(c.currentValue));
    c.addDependent(cell);
    return cell;
  }

  shared ComputeCell newComputeCell2(Cell c1, Cell c2, Element(Element, Element) f) {
    value cell = ComputeCell(() => f(c1.currentValue, c2.currentValue));
    c1.addDependent(cell);
    c2.addDependent(cell);
    return cell;
  }
}
