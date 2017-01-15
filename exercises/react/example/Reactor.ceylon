class Reactor() {
  shared interface Cell<Element> {
    shared formal Element currentValue;
  }

  shared class InputCell<Element>(Element initialValue) satisfies Cell<Element> {
    variable Element currentValue_ = initialValue;
    shared actual Element currentValue => currentValue_;
    assign currentValue {
      currentValue_ = currentValue;
    }
  }

  shared class ComputeCell<Element> satisfies Cell<Element> {
    variable Element currentValue_;
    Element() newValue;

    shared new single(Cell<Element> c, Element(Element) f) {
      newValue = () => f(c.currentValue);
      currentValue_ = newValue();
    }

    shared actual Element currentValue => currentValue_;
  }
}
