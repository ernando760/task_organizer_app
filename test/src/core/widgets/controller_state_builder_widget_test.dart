import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_organizer_app/src/core/widgets/controller_state_builder_widget.dart';

import '../../../mocks/mocks.dart';

void main() {
  testWidgets('O estado inicial deve ser o valor 0', (tester) async {
    final controller = CounterController();

    await tester.pumpWidget(
      MaterialApp(
        home: ControllerStateBuilderWidget(
          controller: controller,
          builder: (context, state) {
            return Text("Valor: $state", textDirection: TextDirection.ltr);
          },
        ),
      ),
    );

    expect(find.text("Valor: 0"), findsOneWidget);
  });

  testWidgets('Quando o estado for mudado o valor de ser 1', (tester) async {
    final controller = CounterController();

    await tester.pumpWidget(
      MaterialApp(
        home: ControllerStateBuilderWidget<int>(
          controller: controller,
          builder: (context, state) {
            return Text('Valor: $state', textDirection: TextDirection.ltr);
          },
        ),
      ),
    );

    controller.increment();
    await tester.pump();

    expect(find.text('Valor: 1'), findsOneWidget);
  });

  testWidgets(
    'Quando o listener for chamado corretamente o valor do estado deve ser 1',
    (tester) async {
      final controller = CounterController();
      int? receivedState;

      await tester.pumpWidget(
        MaterialApp(
          home: ControllerStateBuilderWidget<int>(
            controller: controller,
            builder: (context, state) {
              return Text('Valor: $state', textDirection: TextDirection.ltr);
            },
            listener: (state) {
              receivedState = state;
            },
          ),
        ),
      );

      controller.increment();
      await tester.pump();

      expect(receivedState, 1);
    },
  );
}
