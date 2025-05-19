import '../../../core/controller/base_controller.dart';

class CheckboxTaskController extends BaseController<bool?> {
  CheckboxTaskController(super.state);

  void toggle(bool? value) {
    emit(value);
  }
}
