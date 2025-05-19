import 'package:result_dart/result_dart.dart';

import '../../../core/usecase/base_use_case.dart';
import '../dtos/task/task_dto.dart';
import '../entities/task/task_entity.dart';
import '../errors/task_exceptions.dart';
import '../repositories/i_remove_task_repository.dart';

abstract class IDeleteTask
    extends BaseUsecase<List<TaskEntity>, TaskException, TaskDto> {}

class DeleteTask extends IDeleteTask {
  DeleteTask(this._removeTaskRepository);

  final IDeleteTaskRepository _removeTaskRepository;

  @override
  AsyncResultDart<List<TaskEntity>, TaskException> execute(
    TaskDto param,
  ) async {
    if (param.id == null) {
      return Failure(
        RemoveTaskException(label: "[$runtimeType.execute] O id está nulo."),
      );
    }

    return await _removeTaskRepository.execute(param);
  }
}
