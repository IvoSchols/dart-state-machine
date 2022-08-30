import 'package:state_machine/state_machine.dart';
import 'package:test/test.dart';

void main() {
  group('StateMachine', () {
    late StateMachine machine;

    setUp(() {
      machine = StateMachine('test');
    });

    test('Expect machine initial throwsUnsupportedError', () {
      expect(() => machine.initial, throwsUnsupportedError);
    });

    test('Expect machine initial equals state', () {
      State state = machine.newState('test');
      expect(machine.initial, equals(state));
    });

    test('Expect initial equals start state', () {
      State state = machine.newState('test');
      State state2 = machine.newState('test2');
      machine.start(state2);
      expect(machine.initial, equals(state2));
    });

    test('Expect machine initial does not equal transitioned state', () {
      State state = machine.newState('test');
      State state2 = machine.newState('test2');
      Transition transition = machine.newTransition('test', {state}, state2);
      machine.start();
      transition.execute();
      expect(machine.initial, isNot(equals(state2)));
      expect(machine.initial, equals(state));
    });

    test('Expect machine current throwsUnsupportedError', () {
      expect(() => machine.current, throwsUnsupportedError);
    });

    test('Expect machine current equals state', () {
      State state = machine.newState('test');
      machine.start(state);
      expect(machine.current, equals(state));
    });

    test('Expect machine current equals start state', () {
      machine.newState('test');
      State state2 = machine.newState('test2');
      machine.start(state2);
      expect(machine.current, equals(state2));
    });

    test('Expect machine current equals transitioned state', () {
      State state = machine.newState('test');
      State state2 = machine.newState('test2');
      Transition transition = machine.newTransition('test', {state}, state2);
      machine.start(state);
      transition.execute();
      expect(machine.current, equals(state2));
    });

    test('Expect empty states', () {
      expect(machine.states, isEmpty);
    });

    test('Expect states', () {
      State state = machine.newState('test');
      expect(machine.states, isNotEmpty);
      expect(machine.states, equals({state}));
    });

    test('Expect empty transitions', () {
      expect(machine.transitions, isEmpty);
    });

    test('Expect transitions', () {
      State state = machine.newState('test');
      State state2 = machine.newState('test2');
      Transition transition = machine.newTransition('test', {state}, state2);
      expect(machine.transitions, isNotEmpty);
      expect(machine.transitions[state], equals({transition}));
    });

    test('Expect empty allTransitions', () {
      expect(machine.allTransitions, isEmpty);
    });

    test('Expect allTransitions', () {
      State state = machine.newState('test');
      State state2 = machine.newState('test2');
      Transition transition = machine.newTransition('test', {state}, state2);
      Transition transition2 = machine.newTransition('test2', {state2}, state);
      expect(machine.allTransitions, isNotEmpty);
      expect(machine.allTransitions, equals({transition, transition2}));
    });
  });
}
