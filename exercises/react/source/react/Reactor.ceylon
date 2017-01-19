class Reactor<Element>() given Element satisfies Object {
  shared abstract class Cell() {
    shared formal Element currentValue;
  }

  shared class InputCell(Element initialValue) extends Cell() {
    shared actual variable Element currentValue = nothing;
  }

  shared class ComputeCell() extends Cell() {
    shared alias Callback => Anything(Element);

    shared actual Element currentValue = nothing;

    shared interface Subscription {
      shared formal void cancel();
    }

    shared Subscription addCallback(Callback f) {
      return nothing;
    }
  }

  shared ComputeCell newComputeCell1(Cell c, Element(Element) f) {
    return nothing;
  }

  shared ComputeCell newComputeCell2(Cell c1, Cell c2, Element(Element, Element) f) {
    return nothing;
  }
}
