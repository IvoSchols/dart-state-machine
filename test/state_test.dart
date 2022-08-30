import 'package:state_machine/state_machine.dart';
import 'package:test/test.dart';

void main() {
  group('State', () {
    test('can be created', () {
      StateMachine machine = StateMachine('test');
      State state = machine.newState('test');
      expect(state.name, equals('test'));
      expect(machine.states.contains(state), isTrue);
      expect(state.transitions, isEmpty);
    });
    test('can be added to a state machine', () {
      StateMachine machine = StateMachine('test');
      State state = machine.newState('test');
      expect(machine.states, [state]);
    });

    test('can be added to a state machine only once', () {
      StateMachine machine = StateMachine('test');
      State state = machine.newState('test');
      expect(() => machine.newState('test'), throwsException);
    });
  });
}
