import 'package:flutter_test/flutter_test.dart';
import 'package:result_dart/result_dart.dart';
import 'package:task_organizer_app/src/tasks/data/db/task_isar_database.dart';
import 'package:task_organizer_app/src/tasks/data/repositories/delete_task_repository.dart';
import 'package:task_organizer_app/src/tasks/domain/dtos/task/task_dto.dart';
import 'package:task_organizer_app/src/tasks/domain/repositories/i_remove_task_repository.dart';

import '../../../../mocks/mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late TaskIsarDatabase taskIsarDatabase;
  late IDeleteTaskRepository deleteTaskRepository;
  setUpAll(() {
    taskIsarDatabase = MockTaskIsarDatabase();

    deleteTaskRepository = DeleteTaskRepository(taskIsarDatabase);
  });

  tearDown(() async {
    await taskIsarDatabase.close();
  });

  test(
    "Deve retornar um lista de tarefas vazia quando for deletar uma tarefa chamando o método [DeleteTaskRepository.execute]",
    () async {
      final dto = TaskDto(title: "Titulo #1", isDone: false);

      await taskIsarDatabase.upsertTask(dto);

      final result = await deleteTaskRepository.execute(dto);

      result.onSuccess((tasks) {
        expect(tasks.length, equals(0));
        expect(tasks, isEmpty);
      });
    },
  );

  test(
    "Deve retornar um lista de tarefas quando for deletar uma tafera chamando o método [DeleteTaskRepository.execute]",
    () async {
      await createManyTasks(taskIsarDatabase);

      final tasks =
          (await taskIsarDatabase.getAllTasks().map(
            (taskModels) =>
                taskModels.map((taskModel) => taskModel.toTask()).toList(),
          )).getOrNull()!;

      final taskDto = TaskDto.fromTask(tasks.first);

      final result = await deleteTaskRepository.execute(taskDto);

      result.onSuccess((tasks) {
        expect(tasks.length, equals(9));
        expect(tasks, isNotEmpty);
      });
    },
  );
}
