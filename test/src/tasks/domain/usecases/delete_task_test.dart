import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';
import 'package:task_organizer_app/src/tasks/domain/dtos/task/task_dto.dart';
import 'package:task_organizer_app/src/tasks/domain/errors/task_exceptions.dart';
import 'package:task_organizer_app/src/tasks/domain/repositories/i_remove_task_repository.dart';
import 'package:task_organizer_app/src/tasks/domain/usecases/delete_task.dart';

import '../../../../mocks/mocks.dart';

void main() {
  late IDeleteTaskRepository mockRemoveTaskRepository;
  late IDeleteTask upsertTask;
  setUp(() {
    mockRemoveTaskRepository = MockRemoveTaskRespository();
    upsertTask = DeleteTask(mockRemoveTaskRepository);

    registerFallbackValue(FakeTaskDto());
  });

  test(
    "Quando chamar a função [RemoveTask.execute] e for sucesso deve retornar as tarefas",
    () async {
      final taskDto = TaskDto.fromTask(factoryTasks().last);

      when(() => mockRemoveTaskRepository.execute(any<TaskDto>())).thenAnswer(
        (_) async => Success(factoryTasks()..remove(taskDto.toTask())),
      );

      final result = await upsertTask.execute(taskDto);

      result.onSuccess((tasks) {
        expect(tasks.length, equals(9));
        expect(tasks.last.id, equals("8"));
      });
    },
  );

  test(
    "Quando chamar a função [RemoveTask.execute] e for uma falha deve retornar uma messagem de erro: 'Não foi possivel remover a tarefa, por favor tente mais tarde.'",
    () async {
      final taskDto = TaskDto(id: "11", title: "novo titulo", isDone: false);
      when(
        () => mockRemoveTaskRepository.execute(any<TaskDto>()),
      ).thenAnswer((_) async => Failure(RemoveTaskException()));

      final result = await upsertTask.execute(taskDto);

      result.onFailure((error) {
        expect(
          error.message,
          "Não foi possivel remover a tarefa, por favor tente mais tarde.",
        );
      });
    },
  );

  test(
    "Quando chamar a função [RemoveTask.execute] e for uma falha deve retornar uma messagem de erro: 'Não foi possivel remover a tarefa, por favor tente mais tarde.'",
    () async {
      final taskDto = TaskDto(title: "novo titulo", isDone: false);

      final result = await upsertTask.execute(taskDto);

      result.onFailure((error) {
        expect(error.label, "[DeleteTask.execute] O id está nulo.");
        expect(
          error.message,
          "Não foi possivel remover a tarefa, por favor tente mais tarde.",
        );
      });
    },
  );
}
