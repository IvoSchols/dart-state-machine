import 'package:state_machine/state_machine.dart';
import 'package:test/test.dart';

void main() {
  // transition_test.dart
  group('Transition', () {
    test('can be created', () {
      StateMachine machine = StateMachine('test');
      State state = machine.newState('test');
      Transition transition = machine.newTransition('test', [state], state);
      expect(transition.name, equals('test'));
      expect(transition.from, equals(state));
      expect(transition.to, equals(state));
    });
  });
}
