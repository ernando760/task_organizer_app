import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';
import 'package:task_organizer_app/src/core/param/param.dart';
import 'package:task_organizer_app/src/tasks/domain/errors/task_exceptions.dart';
import 'package:task_organizer_app/src/tasks/domain/repositories/i_get_all_tasks_repository.dart';
import 'package:task_organizer_app/src/tasks/domain/usecases/get_all_tasks.dart';

import '../../../../mocks/mocks.dart';

void main() {
  late IGetAllTasksRepository mockGetAllTasksRepository;
  late IGetAllTasks getAllTasks;
  setUp(() {
    mockGetAllTasksRepository = MockGetAllTasksRespository();
    getAllTasks = GetAllTasks(mockGetAllTasksRepository);
  });

  test(
    "Quando chamar a função [GetAllTasks.execute] e for sucesso deve retornar as tarefas",
    () async {
      when(
        () => mockGetAllTasksRepository.execute(noParam),
      ).thenAnswer((_) async => Success(factoryTasks()));

      final result = await getAllTasks.execute(noParam);

      result.onSuccess((tasks) {
        expect(tasks.length, equals(10));
        expect(tasks, isNotEmpty);
      });
    },
  );

  test(
    "Quando chamar a função [GetAllTasks.execute] e for uma falha deve retornar uma messagem de erro: 'Não foi possivel buscar todas as tarefas, por favor tente mais tarde.'",
    () async {
      when(
        () => mockGetAllTasksRepository.execute(noParam),
      ).thenAnswer((_) async => Failure(GetAllTaskException()));

      final result = await getAllTasks.execute(noParam);

      result.onFailure((error) {
        expect(
          error.message,
          "Não foi possivel buscar todas as tarefas, por favor tente mais tarde.",
        );
      });
    },
  );
}
