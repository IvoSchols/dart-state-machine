import 'package:state_machine/state_machine.dart';
import 'package:test/test.dart';

void main() {
  group('Transition', () {
    late StateMachine machine;
    late State state;
    late State state2;
    late Transition transition;

    setUp(() {
      machine = StateMachine('test');
      state = machine.newState('test');
      state2 = machine.newState('test2');
      transition = machine.newTransition('test', {state}, state2);
    });

    test('Expect transition name equals name', () {
      expect(transition.name, equals('test'));
    });

    test('Expect machine contains transition', () {
      expect(machine.transitions[state], contains(transition));
    });

    test('Expect allTransitions contains transition', () {
      expect(machine.allTransitions, contains(transition));
    });

    test('Expect evaluate conditions', () {
      expect(transition.evaluateConditions((Map map) => false), isTrue);
    });

    test('Expect evaluate conditions true', () {
      Transition transition2 = machine.newTransition('test', {state}, state2,
          conditions: {'test': 'test'});
      expect(transition2.evaluateConditions((Map map) => map['test'] == 'test'),
          isTrue);
    });

    test('Expect evaluate conditions false', () {
      Transition transition2 = machine.newTransition('test', {state}, state2,
          conditions: {'test': 'test'});
      expect(transition2.evaluateConditions((Map map) => false), isFalse);
    });

    test('Expect execute transition', () {
      machine.start(state);
      expect(transition.execute(), isTrue);
      expect(machine.current, equals(state2));
    });

    test('Expect execute transition false', () {
      Transition transition2 = machine.newTransition('test', {state2}, state);
      machine.start(state);
      expect(transition2.execute(), isFalse);
      expect(machine.current, equals(state));
    });
  });
}
