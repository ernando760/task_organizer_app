import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';
import 'package:task_organizer_app/src/tasks/domain/dtos/task/task_dto.dart';
import 'package:task_organizer_app/src/tasks/domain/errors/task_exceptions.dart';
import 'package:task_organizer_app/src/tasks/domain/repositories/i_upsert_task_repository.dart';
import 'package:task_organizer_app/src/tasks/domain/usecases/upsert_task.dart';

import '../../../../mocks/mocks.dart';

void main() {
  late IUpsertTaskRepository mockUpsertTaskRepository;
  late IUpsertTask upsertTask;
  setUp(() {
    mockUpsertTaskRepository = MockUpsertTaskRespository();
    upsertTask = UpsertTask(mockUpsertTaskRepository);

    registerFallbackValue(FakeTaskDto());
  });

  test(
    "Quando chamar a função [UpsertTask.execute] e for sucesso deve retornar as tarefas",
    () async {
      final taskDto = TaskDto(id: "11", title: "novo titulo", isDone: false);

      when(
        () => mockUpsertTaskRepository.execute(any<TaskDto>()),
      ).thenAnswer((_) async => Success(factoryTasks()..add(taskDto.toTask())));

      final result = await upsertTask.execute(taskDto);

      result.onSuccess((tasks) {
        expect(tasks.length, equals(11));
        expect(tasks.last.id, equals("11"));
      });
    },
  );

  test(
    "Quando chamar a função [UpsertTask.execute] e for uma falha deve retornar uma messagem de erro: 'Não foi possivel Editar a tarefa, por favor tente mais tarde.'",
    () async {
      final taskDto = TaskDto(id: "11", title: "novo titulo", isDone: false);
      when(
        () => mockUpsertTaskRepository.execute(any<TaskDto>()),
      ).thenAnswer((_) async => Failure(UpsertTaskException()));

      final result = await upsertTask.execute(taskDto);

      result.onFailure((error) {
        expect(
          error.message,
          "Não foi possivel Editar a tarefa, por favor tente mais tarde.",
        );
      });
    },
  );
}
