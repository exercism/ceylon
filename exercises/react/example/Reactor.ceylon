import ceylon.collection { HashMap, MutableMap }

class Reactor<Element>() given Element satisfies Object {
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
      eachDependent((d) => d.fireCallbacks());
    }
  }

  shared InputCell newInputCell(Element initialValue) {
    return InputCell(initialValue);
  }

  shared class ComputeCell(Element() newValue) extends Cell() {
    shared alias Callback => Anything(Element);

    variable Element currentValue_ = newValue();
    variable Element lastCallbackValue = currentValue_;
    shared actual Element currentValue => currentValue_;

    variable Integer callbacksIssued = 0;
    variable MutableMap<Integer, Callback> activeCallbacks = HashMap<Integer, Callback>();

    shared interface Subscription {
      shared formal void cancel();
    }

    shared Subscription addCallback(Callback f) {
      value id = callbacksIssued;
      callbacksIssued++;
      activeCallbacks.put(id, f);
      return object satisfies Subscription {
        cancel() => activeCallbacks.remove(id);
      };
    }

    shared void propagate() {
      Element nv = newValue();
      if (nv != currentValue) {
        currentValue_ = nv;
        eachDependent((d) => d.propagate());
      }
    }

    shared void fireCallbacks() {
      if (lastCallbackValue == currentValue) {
        return;
      }
      lastCallbackValue = currentValue;
      for (cb in activeCallbacks.items) {
        cb(currentValue);
      }
      eachDependent((d) => d.fireCallbacks());
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
