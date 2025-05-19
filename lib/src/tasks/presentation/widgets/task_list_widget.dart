import 'package:flutter/widgets.dart';

import '../../domain/entities/task/task_entity.dart';
import '../controllers/tasks_controller.dart';
import 'list_tile_task_widget.dart';

class TaskListWidget extends StatelessWidget {
  const TaskListWidget({
    super.key,
    required this.tasksController,
    required this.tasks,
  });
  final TasksController tasksController;
  final List<TaskEntity> tasks;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];

        return ListTileTaskWidget(tasksController: tasksController, task: task);
      },
      separatorBuilder: (context, index) => SizedBox(height: 10),
    );
  }
}
