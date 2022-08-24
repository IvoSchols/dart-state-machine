part of '../state_machine.dart';

class StateMachine {
  /// Name of the state machine. Used for debugging.
  String name;

  /// [State] that the machine is currently in.
  State get current => _current ?? initial;
  State? _current;

  /// Whether or not this state machine has been started.
  /// If it has, calls to [newState] and [newStateTransition]
  /// will be prevented.
  bool _started = false;

  /// Initial state when the machine is started.
  late State initial;

  /// List of states created by for this machine.
  final List<State> _states = [];

  /// Unmodifiable list of states created by for this machine.
  List<State> get states => List.unmodifiable(_states);

  StateMachine(String this.name);

  /// Create a new [State] for this [StateMachine].
  ///
  /// [name] helps identify the state for debugging purposes.
  State newState(String name) {
    if (_started) {
      throw ('Cannot create new state ($name) once the machine has been started.');
    }
    State state = State._(name, this);
    _states.add(state);
    return state;
  }

  /// Create a new [StateTransition] for this [StateMachine].
  ///
  /// [name] helps identify the transition for debugging purposes.
  /// This transition will only succeed when this [StateMachine]
  /// is in one of the states listed in [from]. When this transition
  /// occurs, this [StateMachine] will move to the [to] state.
  Transition newStateTransition(String name, List<State> from, State to) {
    if (_started) {
      throw ('Cannot create new state transition ($name) once the machine has been started.');
    }
    Transition newTransition = Transition._(name, this, from, to);
    for (State state in from) {
      state.addTransition(newTransition);
    }
    return newTransition;
  }

  /// Start the state machine at the given starting state.
  void start(State startingState) {
    if (_started) throw StateError('Machine has already been started.');
    _started = true;
    _current = startingState;
    initial = startingState;
  }

  /// Set the machine state and trigger a state change event.
  void _transition(Transition t) {
    _current = t.to;
    //perform action
  }
}
