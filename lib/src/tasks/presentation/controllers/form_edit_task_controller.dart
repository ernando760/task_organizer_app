import '../../../core/controller/base_controller.dart';
import '../../domain/dtos/task/task_dto.dart';

final class FormEditTaskController extends BaseController<TaskDto> {
  FormEditTaskController(super.state);

  void setTitle(String title) {
    emit(state.copyWith(title: title));
  }

  void setDescrition(String? description) {
    emit(state.copyWith(description: description));
  }
}
