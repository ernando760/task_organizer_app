import 'package:flutter/material.dart';

import '../../../core/widgets/controller_state_builder_widget.dart';
import '../../domain/dtos/task/task_dto.dart';
import '../../domain/entities/task/task_entity.dart';
import '../controllers/checkbox_task_controller.dart';
import '../controllers/tasks_controller.dart';
import 'task_action_menu_widget.dart';

class ListTileTaskWidget extends StatelessWidget {
  const ListTileTaskWidget({
    super.key,
    required this.task,
    required this.tasksController,
    this.onToggle,
  });
  final TaskEntity task;
  final TasksController tasksController;
  final ValueChanged<TaskEntity>? onToggle;
  @override
  Widget build(BuildContext context) {
    final TaskDto taskDto = TaskDto.fromTask(task);
    final checkboxController = CheckboxTaskController(taskDto.isDone);
    return ListTile(
      leading: ControllerStateBuilderWidget(
        controller: checkboxController,
        builder: (context, state) {
          return Checkbox(
            value: state,
            onChanged: (value) async {
              checkboxController.toggle(value);
              onToggle?.call(taskDto.copyWith(isDone: value).toTask());
            },
          );
        },
      ),
      title: Text(taskDto.title),
      subtitle:
          taskDto.description != null ? Text(taskDto.description!) : SizedBox(),
      trailing: TaskActionMenuWidget(
        task: task,
        tasksController: tasksController,
      ),
    );
  }
}
