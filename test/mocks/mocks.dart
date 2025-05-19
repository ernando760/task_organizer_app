import 'dart:async';
import 'dart:io';

// import 'package:isar/isar.dart';
import 'package:isar/isar.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';
import 'package:task_organizer_app/src/core/controller/base_controller.dart';
import 'package:task_organizer_app/src/tasks/data/db/task_isar_database.dart';
import 'package:task_organizer_app/src/tasks/data/models/task_model.dart';
import 'package:task_organizer_app/src/tasks/domain/dtos/task/task_dto.dart';
import 'package:task_organizer_app/src/tasks/domain/entities/task/task_entity.dart';
import 'package:task_organizer_app/src/tasks/domain/errors/task_exceptions.dart';
import 'package:task_organizer_app/src/tasks/domain/repositories/i_get_all_tasks_repository.dart';
import 'package:task_organizer_app/src/tasks/domain/repositories/i_remove_task_repository.dart';
import 'package:task_organizer_app/src/tasks/domain/repositories/i_upsert_task_repository.dart';
import 'package:uuid/uuid.dart';

Future<void> createManyTasks(
  TaskIsarDatabase taskIsarDatabase, {
  int amount = 10,
}) async {
  final tasks = List.generate(
    amount,
    (i) => TaskDto(id: Uuid().v6(), title: "Titulo ${i + 1}", isDone: i.isEven),
  );
  for (var task in tasks) {
    await taskIsarDatabase.upsertTask(task);
  }
}

class MockUpsertTaskRespository extends Mock implements IUpsertTaskRepository {}

class MockRemoveTaskRespository extends Mock implements IDeleteTaskRepository {}

class MockGetAllTasksRespository extends Mock
    implements IGetAllTasksRepository {}

class FakeTaskDto extends Fake implements TaskDto {}

List<TaskEntity> factoryTasks() => List.generate(10, (index) {
  return TaskEntity(
    id: "$index",
    title: "title $index",
    description: "description $index",
    isDone: index.isEven,
  );
});

class CounterController extends BaseController<int> {
  CounterController() : super(0);

  void increment() => emit(state + 1);
}

class MockTaskIsarDatabase implements TaskIsarDatabase {
  factory MockTaskIsarDatabase() {
    return _instance;
  }

  MockTaskIsarDatabase._internal() {
    _init();
  }

  static final MockTaskIsarDatabase _instance =
      MockTaskIsarDatabase._internal();

  final Completer<Isar> _completer = Completer<Isar>();

  Future<void> _init() async {
    if (_completer.isCompleted) {
      return;
    }

    await Isar.initializeIsarCore(download: true);

    final tempDir = Directory.systemTemp.createTempSync();

    final isar = await Isar.open(
      [TaskModelSchema],
      directory: tempDir.path,
      name: 'task_organizer_test.db',
    );

    _completer.complete(isar);
  }

  @override
  AsyncResultDart<List<TaskModel>, TaskException> getAllTasks() async {
    try {
      final isar = await _completer.future;

      final tasks = await isar.taskModels.where().findAll();

      return Success(tasks);
    } on IsarError catch (e) {
      return Failure(
        GetAllTaskException(logMessage: e.message, stackTrace: e.stackTrace),
      );
    } catch (e, s) {
      return Failure(
        TaskUnknownException(logMessage: e.toString(), stackTrace: s),
      );
    }
  }

  @override
  AsyncResultDart<Unit, TaskException> upsertTask(TaskDto taskDto) async {
    try {
      final isar = await _completer.future;

      final taskModel = TaskModel.fromTask(
        taskDto.id != null
            ? taskDto.toTask()
            : taskDto.copyWith(id: Uuid().v6()).toTask(),
      );

      await isar.writeTxn(() async {
        isar.taskModels.put(taskModel);
      });

      return Success(unit);
    } on IsarError catch (e) {
      return Failure(
        GetAllTaskException(logMessage: e.message, stackTrace: e.stackTrace),
      );
    } catch (e, s) {
      return Failure(
        TaskUnknownException(logMessage: e.toString(), stackTrace: s),
      );
    }
  }

  @override
  AsyncResultDart<Unit, TaskException> deleteTask(TaskDto taskDto) async {
    try {
      final isar = await _completer.future;
      final taskModel = TaskModel.fromTask(taskDto.toTask());

      await isar.writeTxn(() async {
        isar.taskModels.delete(taskModel.id);
      });
      return Success(unit);
    } on IsarError catch (e) {
      return Failure(
        GetAllTaskException(logMessage: e.message, stackTrace: e.stackTrace),
      );
    } catch (e, s) {
      return Failure(
        TaskUnknownException(logMessage: e.toString(), stackTrace: s),
      );
    }
  }

  @override
  Future<void> close() async {
    final isar = await _completer.future;
    await isar.writeTxn(() async {
      await isar.clear();
    });
  }
}
