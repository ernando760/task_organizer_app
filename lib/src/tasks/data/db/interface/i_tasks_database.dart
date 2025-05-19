import 'package:result_dart/result_dart.dart';

import '../../../domain/dtos/task/task_dto.dart';
import '../../../domain/errors/task_exceptions.dart';
import '../../models/task_model.dart';

abstract class ITasksDatabase {
  AsyncResultDart<List<TaskModel>, TaskException> getAllTasks();
  AsyncResultDart<Unit, TaskException> upsertTask(TaskDto taskDto);
  AsyncResultDart<Unit, TaskException> deleteTask(TaskDto taskDto);
}
