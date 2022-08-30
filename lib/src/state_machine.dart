part of '../state_machine.dart';

class StateMachine {
  /// Name of the state machine. Used for debugging.
  final String name;

  /// Initial state when the machine is started or first state added.
  State? _initial;

  State get initial =>
      _initial ?? (throw UnsupportedError('No state has yet been added.'));

  /// Whether or not this state machine has been started.
  /// If it has, calls to [newState] and [newTransition] will throw
  bool _started = false;

  /// [State] that the machine is currently in.
  State? _current;

  State get current => _current ?? initial;

  /// List of states created by for this machine.
  final Set<State> _states = {};

  /// Unmodifiable list of states created by for this machine.
  Set<State> get states => Set.unmodifiable(_states);

  /// List of transitions created by for this machine.
  final Map<State, Set<Transition>> _transitions = {};

  /// Unmodifiable list of transitions created by for this machine.
  Set<Transition> get allTransitions =>
      Set.unmodifiable(_transitions.values.expand((e) => e));

  /// Unmodifiable map of transitions per state.
  Map<State, Set<Transition>> get transitions => Map.unmodifiable(_transitions);

  StateMachine(this.name);

  /// Create a new [State] for this [StateMachine].
  ///
  /// [name] helps identify the state for debugging purposes.
  State newState(String name) {
    if (_started) {
      throw ('Cannot create new state ($name) once the machine has been started.');
    }

    State state = State._(name, this);

    _initial ??= state;

    if (_states.add(state)) _transitions[state] = {};
    return state;
  }

  /// Create a new [StateTransition] for this [StateMachine].
  ///
  /// [name] helps identify the transition for debugging purposes.
  /// This transition will only succeed when this [StateMachine]
  /// is in one of the states listed in [from]. When this transition
  /// occurs, this [StateMachine] will move to the [to] state.
  Transition newTransition(String name, Set<State> from, State to,
      {Map? conditions}) {
    if (_started) {
      throw ('Cannot create new state transition ($name) once the machine has been started.');
    }

    Transition newTransition = Transition._(name, this, from, to, conditions);

    for (State state in from) {
      // Transition set is guaranteed to exist, if belongs to [this]. (See [newState])
      _transitions[state]!.add(newTransition);
    }

    return newTransition;
  }

  /// Start the state machine at either initial or the given starting state.
  void start([State? startingState]) {
    if (_started) throw StateError('Machine has already been started.');
    _started = true;
    _current = startingState ?? _initial;
    _initial = startingState ?? _initial;
  }

  /// Set the machine state and trigger a state change event.
  void _transition(Transition t) {
    _current = t.to;
  }
}
