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
      State state = machine.newState('test');
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
  });
}
