class Reactor<Element>() given Element satisfies Object {
  shared abstract class Cell() {
    shared formal Element currentValue;
  }

  shared class InputCell(Element initialValue) extends Cell() {
    shared actual variable Element currentValue = nothing;
  }

  shared class ComputeCell extends Cell {
    shared new single(Cell c, Element(Element) f) extends Cell() {
    }

    shared new double(Cell c1, Cell c2, Element(Element, Element) f) extends Cell() {
    }

    shared alias Callback => Anything(Element);

    shared actual Element currentValue = nothing;

    shared interface Subscription {
      shared formal void cancel();
    }

    shared Subscription addCallback(Callback f) {
      return nothing;
    }
  }
}
