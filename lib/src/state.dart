part of '../state_machine.dart';

/// Represents a state that can be visited within a
/// [StateMachine] instance.
///
/// States must be created from a [StateMachine] instance:
class State {
  /// Name of the state. Used for debugging.
  final String name;

  /// [StateMachine] that this state is a part of.
  final StateMachine _machine;

  State._(
    this.name,
    this._machine,
  );

  /// Unmodifiable list of state transitions that can be made from this state.
  Set<Transition> get transitions => _machine.transitions[this] ?? {};

  /// Determine whether or not this [State] is active.
  bool get isActive => _machine.current == this;
}
