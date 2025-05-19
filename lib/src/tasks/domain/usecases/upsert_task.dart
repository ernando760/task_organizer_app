import 'package:result_dart/result_dart.dart';

import '../../../core/usecase/base_use_case.dart';
import '../dtos/task/task_dto.dart';
import '../entities/task/task_entity.dart';
import '../errors/task_exceptions.dart';
import '../repositories/i_upsert_task_repository.dart';

abstract class IUpsertTask
    extends BaseUsecase<List<TaskEntity>, TaskException, TaskDto> {}

class UpsertTask extends IUpsertTask {
  UpsertTask(this._upsertTaskRepository);

  final IUpsertTaskRepository _upsertTaskRepository;

  @override
  AsyncResultDart<List<TaskEntity>, TaskException> execute(
    TaskDto param,
  ) async {
    return _upsertTaskRepository.execute(param);
  }
}
