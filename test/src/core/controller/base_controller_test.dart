import 'package:flutter_test/flutter_test.dart';

import '../../../mocks/mocks.dart';

void main() {
  late CounterController controller;

  setUp(() {
    controller = CounterController();
  });

  tearDown(() {
    controller.dispose();
  });

  test('O valor de ser incrementado e retorna com o valor 1', () {
    expect(controller.state, equals(0));

    controller.increment();

    expect(controller.state, equals(1));
  });
}
