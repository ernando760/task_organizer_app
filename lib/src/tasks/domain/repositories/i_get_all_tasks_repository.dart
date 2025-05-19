import '../../../core/param/param.dart';
import '../../../core/repository/base_repository.dart';
import '../entities/task/task_entity.dart';
import '../errors/task_exceptions.dart';

abstract class IGetAllTasksRepository
    extends BaseRepository<List<TaskEntity>, TaskException, NoParam> {}
