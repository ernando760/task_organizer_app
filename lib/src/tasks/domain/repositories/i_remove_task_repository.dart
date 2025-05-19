import '../../../core/repository/base_repository.dart';
import '../dtos/task/task_dto.dart';
import '../entities/task/task_entity.dart';
import '../errors/task_exceptions.dart';

abstract class IDeleteTaskRepository
    extends BaseRepository<List<TaskEntity>, TaskException, TaskDto> {}
