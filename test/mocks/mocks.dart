import 'package:task_organizer_app/src/core/controller/base_controller.dart';

class CounterController extends BaseController<int> {
  CounterController() : super(0);

  void increment() => emit(state + 1);
}
