import 'package:flutter_test/flutter_test.dart';
import 'package:task_organizer_app/src/tasks/data/db/task_isar_database.dart';
import 'package:task_organizer_app/src/tasks/data/repositories/upsert_task_repository.dart';
import 'package:task_organizer_app/src/tasks/domain/dtos/task/task_dto.dart';
import 'package:task_organizer_app/src/tasks/domain/entities/task/task_entity.dart';
import 'package:task_organizer_app/src/tasks/domain/repositories/i_upsert_task_repository.dart';

import '../../../../mocks/mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late TaskIsarDatabase taskIsarDatabase;
  late IUpsertTaskRepository upsertTaskRepository;
  setUpAll(() {
    taskIsarDatabase = MockTaskIsarDatabase();

    upsertTaskRepository = UpsertTaskRepository(taskIsarDatabase);
  });

  tearDown(() async {
    await taskIsarDatabase.close();
  });

  test(
    "Deve retornar um lista de tarefas quando for criar uma nova tarefa chamando o método [UpsertTaskRepository.execute]",
    () async {
      final dto = TaskDto(title: "Titulo #1", isDone: false);

      final result = await upsertTaskRepository.execute(dto);

      result.onSuccess((tasks) {
        expect(tasks.length, equals(1));
        expect(tasks, isNotEmpty);
      });
    },
  );

  test(
    "Deve retornar um lista de tarefas quando for atualizar a tafera chamando o método [UpsertTaskRepository.execute]",
    () async {
      final dto = TaskDto(title: "Titulo #1", isDone: false);

      final tasks = (await upsertTaskRepository.execute(dto)).getOrNull();

      final taskUptaded = TaskDto.fromTask(
        tasks!.first,
      ).copyWith(title: "Titulo atualizado");

      final result = await upsertTaskRepository.execute(taskUptaded);

      result.onSuccess((tasks) {
        expect(tasks.length, equals(1));
        expect(tasks, isNotEmpty);
        expect(
          tasks,
          isA<List<TaskEntity>>().having(
            (tasks) {
              return tasks.first.title;
            },
            "Titulo",
            "Titulo atualizado",
          ),
        );
      });
    },
  );
}
