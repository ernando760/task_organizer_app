import 'package:result_dart/result_dart.dart';

import '../../domain/dtos/task/task_dto.dart';
import '../../domain/entities/task/task_entity.dart';
import '../../domain/errors/task_exceptions.dart';
import '../../domain/repositories/i_remove_task_repository.dart';
import '../db/task_isar_database.dart';

class DeleteTaskRepository implements IDeleteTaskRepository {
  DeleteTaskRepository(this._database);

  final TaskIsarDatabase _database;

  @override
  AsyncResultDart<List<TaskEntity>, TaskException> execute(
    TaskDto params,
  ) async {
    final tasks = await _database
        .deleteTask(params)
        .flatMap((_) async => await _database.getAllTasks())
        .map((tasks) {
          return tasks.map((taskModel) => taskModel.toTask()).toList();
        });

    return tasks;
  }
}
