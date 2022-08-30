import 'package:state_machine/state_machine.dart';
import 'package:test/test.dart';

void main() {
  group('State', () {
    late StateMachine machine;
    late State state;

    setUp(() {
      machine = StateMachine('test');
      state = machine.newState('test');
    });

    test('Expect state name equals name', () {
      expect(state.name, equals('test'));
    });

    test('Expect machine contains state', () {
      expect(machine.states, contains(state));
    });

    test('Expect transitions is empty', () {
      expect(state.transitions, isEmpty);
    });

    test('Expect transitions contains transition', () {
      State state2 = machine.newState('test2');
      machine.newTransition('test', {state}, state2);
      expect(state.transitions, hasLength(1));
      expect(state.transitions, equals(machine.transitions[state]));
    });

    test('Expect machine isActive equals false', () {
      State state2 = machine.newState('test2');
      expect(state2.isActive, isFalse);
    });

    test('Expect machine isActive equals true', () {
      machine.start(state);
      expect(state.isActive, isTrue);
    });
  });
}
