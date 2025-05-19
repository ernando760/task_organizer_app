import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/controller_state_builder_widget.dart';
import '../../domain/dtos/task/task_dto.dart';
import '../../domain/entities/task/task_entity.dart';
import '../controllers/form_edit_task_controller.dart';
import '../controllers/tasks_controller.dart';
import '../extensions/form_task_validator_extension.dart';

class FormEditTaskBottomSheetWidget extends StatefulWidget {
  const FormEditTaskBottomSheetWidget({
    super.key,
    this.task,
    required this.tasksController,
  });
  final TaskEntity? task;
  final TasksController tasksController;
  @override
  State<FormEditTaskBottomSheetWidget> createState() =>
      _FormEditTaskBottomSheetWidgetState();
}

class _FormEditTaskBottomSheetWidgetState
    extends State<FormEditTaskBottomSheetWidget> {
  late FormEditTaskController _formEditTaskController;

  final GlobalKey<FormFieldState> _formFieldTitlekey =
      GlobalKey<FormFieldState>();

  @override
  void initState() {
    super.initState();

    _formEditTaskController = FormEditTaskController(
      widget.task != null
          ? TaskDto.fromTask(widget.task!)
          : TaskDto(title: "", isDone: false),
    );
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
    final theme = Theme.of(context);
    final title =
        widget.task?.id == null ? "Adicionar tarefa" : "Atualizar tarefa";

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 24,
        ),
        child: ControllerStateBuilderWidget(
          controller: _formEditTaskController,
          builder: (context, task) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 15,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    IconButton(onPressed: _handlePop, icon: Icon(Icons.close)),
                  ],
                ),
                SizedBox(
                  width: sizeOf.width,
                  child: TextFormField(
                    key: _formFieldTitlekey,
                    initialValue: task.title,
                    decoration: InputDecoration(
                      label: Text("Título"),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: _formEditTaskController.setTitle,
                    validator: task.validateTitle,
                  ),
                ),
                TextFormField(
                  maxLines: 4,
                  initialValue: task.description,
                  decoration: InputDecoration(
                    labelText: "Descrição",
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                  onChanged: _formEditTaskController.setDescrition,
                ),

                FilledButton(onPressed: _handleEditTask, child: Text("Salvar")),
              ],
            );
          },
        ),
      ),
    );
  }

  void _handlePop() => GoRouter.of(context).pop();

  Future<void> _handleEditTask() async {
    final isValid = _formFieldTitlekey.currentState?.validate() ?? false;
    if (isValid) {
      await widget.tasksController.upsertTask(_formEditTaskController.state);
      _handlePop();
    }
  }
}
