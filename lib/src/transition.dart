part of '../state_machine.dart';

class Transition {
  /// Name of the state transition. Used for debugging.
  final String name;

  /// List of valid [State]s that the machine must be in
  /// for this transition to occur.
  final List<State> _from;

  /// Unmodifiable list of valid [State]s that the machine must be in
  /// for this transition to occur.
  List<State> get from => List.unmodifiable(_from);

  /// [StateMachine] that this state transition is a part of.
  final StateMachine _machine;

  /// [State] to transition the machine to when executing
  /// this transition.
  final State _to;

  /// [State] to transition the machine to when executing
  get to => _to;

  /// [BinaryExpressionTree] that determines whether or not
  /// this transition can occur.
  final BinaryExpressionTree? _conditions;

  /// [Map] of [String]s to [String]s that contains the
  /// names and types of the conditions
  final Map<String, String> _variableDeclarations;

  Transition._(
    this.name,
    this._machine,
    this._from,
    this._to,
    this._conditions,
    this._variableDeclarations,
  );

  /// Returns true if transition can be executed, with these variable values
  /// false if it's not possible.
  bool canCall(Map<String, String> variableValues) {
    // State current = _machine.current;
    // // Verify if the transition is valid from the current state.
    // if (!_from.contains(current)) {
    //   return false;
    // }

    // // Check conditionals

    return true;
  }

  /// Returns true if the transition succeeded, false
  /// if it was canceled.
  bool call(Map<String, String> variableValues) {
    if (!canCall(variableValues)) {
      return false;
    }

    // Transition is legal and wasn't canceled.
    // Update the machine state.
    _machine._transition(this);

    return true;
  }
}
