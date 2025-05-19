import 'package:result_dart/result_dart.dart';

import '../../../core/param/param.dart';
import '../../../core/usecase/base_use_case.dart';
import '../entities/task/task_entity.dart';
import '../errors/task_exceptions.dart';
import '../repositories/i_get_all_tasks_repository.dart';

abstract class IGetAllTasks
    extends BaseUsecase<List<TaskEntity>, TaskException, NoParam> {}

class GetAllTasks extends IGetAllTasks {
  GetAllTasks(this._getAllTasksRepository);

  final IGetAllTasksRepository _getAllTasksRepository;

  @override
  AsyncResultDart<List<TaskEntity>, TaskException> execute(
    NoParam param,
  ) async {
    return await _getAllTasksRepository.execute(param);
  }
}
