import 'package:flutter/material.dart';

import '../../../core/widgets/controller_state_builder_widget.dart';
import '../controllers/tasks_controller.dart';
import '../states/tasks_state.dart';
import '../widgets/form_edit_task_bottom_sheet_widget.dart';
import '../widgets/task_list_widget.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key, required this.tasksController});

  final TasksController tasksController;

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await widget.tasksController.getAllTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text("Minhas tarefas")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ControllerStateBuilderWidget(
              controller: widget.tasksController,
              listener: (state) {
                if (state is ErrorTask) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      showCloseIcon: false,
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is LoadingTask) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is LoadedTask) {
                  final tasks = state.tasks;

                  if (tasks.isEmpty) {
                    return Text(
                      "Nenhuma tarefa encontrada.",
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  }

                  return Expanded(
                    child: TaskListWidget(
                      tasksController: widget.tasksController,
                      tasks: tasks,
                    ),
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder:
                (context) => FormEditTaskBottomSheetWidget(
                  tasksController: widget.tasksController,
                ),
          );
        },
        child: Icon(Icons.add_task_rounded),
      ),
    );
  }
}
