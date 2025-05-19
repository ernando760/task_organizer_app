import 'package:isar/isar.dart';
import 'package:task_organizer_app/src/core/util.dart';

import '../../domain/entities/task/task_entity.dart';

part 'task_model.g.dart';

@collection
class TaskModel {
  TaskModel({
    required this.uuid,
    required this.title,
    required this.description,
    required this.isDone,
  });

  final String? uuid;

  Id get id => fastHash(uuid!);

  final String title;
  final String? description;
  final bool isDone;

  TaskEntity toTask() => TaskEntity(
    id: uuid,
    title: title,
    description: description,
    isDone: isDone,
  );

  factory TaskModel.fromTask(TaskEntity task) => TaskModel(
    uuid: task.id,
    title: task.title,
    description: task.description,
    isDone: task.isDone,
  );

  @override
  String toString() {
    return 'TaskModel(uuid: $uuid, title: $title, description: $description, isDone: $isDone)';
  }
}
