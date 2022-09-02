part of '../state_machine.dart';

class Transition extends Equatable {
  /// Name of the state transition. Used for debugging.
  final String name;

  /// [StateMachine] that this state transition is a part of.
  final StateMachine machine;

  /// List of valid [State]s that the machine must be in
  /// for this transition to occur.
  final Set<State> from;

  /// [State] to transition the machine to when executing
  /// this transition.
  final State to;

  final Map? conditions;

  Transition._(
    this.name,
    this.machine,
    this.from,
    this.to,
    this.conditions,
  );

  /// Returns true if transition can be executed, with these variable values
  /// false if it's not possible.
  bool evaluateConditions(bool Function(Map) evaluator) {
    if (conditions == null) return true;
    return evaluator(conditions!);
  }

  /// Returns true if the transition succeeded, false
  /// if it was canceled. (does not evaluate conditions)
  bool execute() {
    if (!from.contains(machine.current)) return false;
    // Transition is legal and wasn't canceled.
    // Update the machine state.
    machine._transition(this);

    return true;
  }

  @override
  List<Object?> get props => [name, machine, from, to, conditions];
}
