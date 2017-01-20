import ceylon.collection { HashMap, MutableMap }

class Reactor<Element>() given Element satisfies Object {
  shared abstract class Cell() {
    shared formal Element currentValue;
    variable ComputeCell.Inner[] dependents = [];
    shared default void addDependent(ComputeCell.Inner c) {
      dependents = dependents.withTrailing(c);
    }
    shared void eachDependent(Anything(ComputeCell.Inner) f) {
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

  shared class ComputeCell extends Cell {
    shared alias Callback => Anything(Element);

    shared interface Subscription {
      shared formal void cancel();
    }

    shared class Inner(Element() newValue) extends Cell() {
      variable Element currentValue_ = newValue();
      shared actual Element currentValue => currentValue_;
      variable Element lastCallbackValue = currentValue_;

      variable Integer callbacksIssued = 0;
      variable MutableMap<Integer, Callback> activeCallbacks = HashMap<Integer, Callback>();

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

    Inner inner;

    shared new single(Cell c, Element(Element) f) extends Cell() {
      // Since `c.addDependent(this)` is illegal, we have to create an inner cell.
      inner = Inner(() => f(c.currentValue));
      c.addDependent(inner);
    }

    shared new double(Cell c1, Cell c2, Element(Element, Element) f) extends Cell() {
      // Since `c.addDependent(this)` is illegal, we have to create an inner cell.
      inner = Inner(() => f(c1.currentValue, c2.currentValue));
      c1.addDependent(inner);
      c2.addDependent(inner);
    }

    shared actual Element currentValue => inner.currentValue;

    shared Subscription addCallback(Callback f) {
      return inner.addCallback(f);
    }

    shared actual void addDependent(ComputeCell.Inner c) {
      inner.addDependent(c);
    }
  }
}
