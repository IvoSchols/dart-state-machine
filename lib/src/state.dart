part of '../state_machine.dart';

/// Represents a state that can be visited within a
/// [StateMachine] instance.
///
/// States must be created from a [StateMachine] instance:
class State {
  /// Name of the state. Used for debugging.
  String name;

  /// [StateMachine] that this state is a part of.
  StateMachine _machine;

  /// List of state transitions that can be made from this state.
  List<Transition> _transitions = [];

  /// Unmodifiable list of state transitions that can be made from this state.
  List<Transition> get transitions => List.unmodifiable(_transitions);

  void addTransition(Transition transition) {
    _transitions.add(transition);
  }

  State._(
    this.name,
    this._machine,
  );

  /// Determine whether or not this [State] is active.
  bool get isActive => _machine.current == this;
}
