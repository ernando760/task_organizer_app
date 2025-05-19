import 'package:flutter_test/flutter_test.dart';
import 'package:task_organizer_app/src/core/param/param.dart';
import 'package:task_organizer_app/src/tasks/data/db/task_isar_database.dart';
import 'package:task_organizer_app/src/tasks/data/repositories/get_all_tasks_repository.dart';
import 'package:task_organizer_app/src/tasks/domain/repositories/i_get_all_tasks_repository.dart';

import '../../../../mocks/mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late TaskIsarDatabase taskIsarDatabase;
  late IGetAllTasksRepository getAllTasksRepository;
  setUpAll(() {
    taskIsarDatabase = MockTaskIsarDatabase();

    getAllTasksRepository = GetAllTasksRepository(taskIsarDatabase);
  });

  tearDown(() async {
    await taskIsarDatabase.close();
  });

  test(
    "Deve retornar um lista de tarefas quando for chamar o metodo [GetAllTasksRepository.execute]",
    () async {
      await createManyTasks(taskIsarDatabase);

      final result = await getAllTasksRepository.execute(noParam);

      result.onSuccess((tasks) {
        expect(tasks.length, equals(10));
        expect(tasks, isNotEmpty);
      });
    },
  );

  test(
    "Deve retornar um lista de tarefas vazia quando for chamar o metodo [GetAllTasksRepository.execute]",
    () async {
      final result = await getAllTasksRepository.execute(noParam);

      result.onSuccess((tasks) {
        expect(tasks.length, equals(0));
        expect(tasks, isEmpty);
      });
    },
  );
}
