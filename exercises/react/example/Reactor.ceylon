class Reactor() {
  shared alias Element => Integer;

  shared interface Cell {
    shared formal Element currentValue;
  }

  shared class InputCell(Element initialValue) satisfies Cell {
    variable Element currentValue_ = initialValue;
    shared actual Element currentValue => currentValue_;
    assign currentValue {
      currentValue_ = currentValue;
    }
  }

  shared class ComputeCell satisfies Cell {
    variable Element currentValue_;
    Element() newValue;

    shared new single(Cell c, Element(Element) f) {
      newValue = () => f(c.currentValue);
      currentValue_ = newValue();
    }

    shared actual Element currentValue => currentValue_;
  }
}
