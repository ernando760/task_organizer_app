import '../../../core/controller/base_controller.dart';
import '../../../core/logger/app_logger.dart';
import '../../../core/param/param.dart';
import '../../domain/dtos/task/task_dto.dart';
import '../../domain/usecases/delete_task.dart';
import '../../domain/usecases/get_all_tasks.dart';
import '../../domain/usecases/upsert_task.dart';
import '../states/tasks_state.dart';

final class TasksController extends BaseController<TasksState> {
  TasksController(this._getAllTasks, this._upsertTask, this._deleteTask)
    : super(InitialTask());

  final IGetAllTasks _getAllTasks;
  final IUpsertTask _upsertTask;
  final IDeleteTask _deleteTask;

  final AppLogger _logger = AppLogger();

  Future<void> getAllTasks() async {
    emit(LoadingTask());

    final result = await _getAllTasks.execute(noParam);

    final state = result.fold((tasks) => LoadedTask(tasks: tasks), (error) {
      _logger.error(error.logMessage ?? "", error: error);
      return ErrorTask(message: error.message);
    });

    emit(state);
  }

  Future<void> upsertTask(TaskDto taskDto) async {
    final result = await _upsertTask.execute(taskDto);

    final state = result.fold((tasks) => LoadedTask(tasks: tasks), (error) {
      _logger.error(error.logMessage ?? "", error: error);
      return ErrorTask(message: error.message);
    });

    emit(state);
  }

  Future<void> deleteTask(TaskDto taskDto) async {
    final result = await _deleteTask.execute(taskDto);

    final state = result.fold((tasks) => LoadedTask(tasks: tasks), (error) {
      _logger.error(error.logMessage ?? "", error: error);
      return ErrorTask(message: error.message);
    });

    emit(state);
  }
}
