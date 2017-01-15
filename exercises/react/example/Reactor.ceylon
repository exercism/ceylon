class Reactor() {
  shared alias Element => Integer;

  shared interface Cell {
    shared formal Element currentValue;
    shared formal Cell[] dependents;
    shared formal void addDependent(Cell c);
  }

  shared class InputCell(Element initialValue) satisfies Cell {
    variable Element currentValue_ = initialValue;
    shared actual Element currentValue => currentValue_;
    assign currentValue {
      currentValue_ = currentValue;
    }

    shared actual variable Cell[] dependents = [];
    shared actual void addDependent(Cell c) {
      dependents = dependents.withTrailing(c);
    }
  }

  shared class ComputeCell satisfies Cell {
    variable Element currentValue_;
    Element() newValue;

    shared actual variable Cell[] dependents = [];
    shared actual void addDependent(Cell c) {
      dependents = dependents.withTrailing(c);
    }

    shared new single(Cell c, Element(Element) f) {
      c.addDependent(this);
      newValue = () => f(c.currentValue);
      currentValue_ = newValue();
    }

    shared new double(Cell c1, Cell c2, Element(Element, Element) f) {
      c1.addDependent(this);
      c2.addDependent(this);
      newValue = () => f(c1.currentValue, c2.currentValue);
      currentValue_ = newValue();
    }

    shared actual Element currentValue => currentValue_;
  }
}
