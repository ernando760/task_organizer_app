import 'dart:async';

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:result_dart/result_dart.dart';
import 'package:uuid/uuid.dart';

import '../../domain/dtos/task/task_dto.dart';
import '../../domain/errors/task_exceptions.dart';
import '../models/task_model.dart';
import 'interface/i_tasks_database.dart';

class TaskIsarDatabase implements ITasksDatabase {
  factory TaskIsarDatabase() {
    return _instance;
  }

  TaskIsarDatabase._internal() {
    _init();
  }

  final Completer<Isar> _completer = Completer<Isar>();

  static final TaskIsarDatabase _instance = TaskIsarDatabase._internal();

  Future<void> _init() async {
    if (_completer.isCompleted) {
      return;
    }

    final dir = await getApplicationDocumentsDirectory();

    final isar = await Isar.open(
      [TaskModelSchema],
      directory: dir.path,
      name: 'task_organizer.db',
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

  Future<void> close() async {
    final isar = await _completer.future;
    await isar.close();
  }
}
