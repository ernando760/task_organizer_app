import 'package:flutter/material.dart';

import '../../domain/dtos/task/task_dto.dart';
import '../../domain/entities/task/task_entity.dart';
import '../controllers/tasks_controller.dart';
import 'form_edit_task_bottom_sheet_widget.dart';

class TaskActionMenuWidget extends StatefulWidget {
  const TaskActionMenuWidget({
    super.key,
    required this.task,
    required this.tasksController,
  });
  final TaskEntity task;
  final TasksController tasksController;

  @override
  State<TaskActionMenuWidget> createState() => _TaskActionMenuWidgetState();
}

class _TaskActionMenuWidgetState extends State<TaskActionMenuWidget> {
  final FocusNode _buttonFocusNode = FocusNode();

  @override
  void dispose() {
    _buttonFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MenuAnchor(
      childFocusNode: _buttonFocusNode,
      menuChildren: [
        MenuItemButton(onPressed: _handleEditTask, child: Text("Editar")),
        MenuItemButton(
          onPressed: _handleDeleteTask,
          child: Text(
            "Deletar",
            style: theme.textTheme.bodySmall?.copyWith(color: Colors.redAccent),
          ),
        ),
      ],
      builder: (_, controller, _) {
        return IconButton(
          onPressed: () => _handleMenuAnchorIsOpen(controller),
          icon: Icon(Icons.more_vert),
        );
      },
    );
  }

  Future<void> _handleEditTask() async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder:
          (context) => FormEditTaskBottomSheetWidget(
            tasksController: widget.tasksController,
            task: widget.task,
          ),
    );
  }

  Future<void> _handleDeleteTask() async {
    await widget.tasksController.deleteTask(TaskDto.fromTask(widget.task));
  }

  void _handleMenuAnchorIsOpen(MenuController controller) {
    if (controller.isOpen) {
      controller.close();
      return;
    }
    controller.open();
  }
}
