import 'package:result_dart/result_dart.dart';

import '../../../core/param/param.dart';
import '../../domain/entities/task/task_entity.dart';
import '../../domain/errors/task_exceptions.dart';
import '../../domain/repositories/i_get_all_tasks_repository.dart';
import '../db/task_isar_database.dart';

class GetAllTasksRepository extends IGetAllTasksRepository {
  GetAllTasksRepository(this._database);
  final TaskIsarDatabase _database;

  @override
  AsyncResultDart<List<TaskEntity>, TaskException> execute(NoParam _) async {
    final tasks = await _database.getAllTasks().map(
      (tasks) => tasks.map((taskModel) => taskModel.toTask()).toList(),
    );
    return tasks;
  }
}
