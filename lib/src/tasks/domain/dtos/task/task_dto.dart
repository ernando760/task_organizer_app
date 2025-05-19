import '../../entities/task/task_entity.dart';

class TaskDto {
  final String? id;
  final String title;
  final String? description;
  final bool isDone;

  TaskDto({
    this.id,
    required this.title,
    this.description,
    required this.isDone,
  });

  TaskDto copyWith({
    String? id,
    String? title,
    String? description,
    bool? isDone,
  }) {
    return TaskDto(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
    );
  }

  factory TaskDto.fromTask(TaskEntity task) => TaskDto(
    id: task.id,
    title: task.title,
    description: task.description,
    isDone: task.isDone,
  );

  TaskEntity toTask() => TaskEntity(
    id: id,
    title: title,
    description: description,
    isDone: isDone,
  );

  @override
  String toString() =>
      'TaskDto(title: $title, description: $description, isDone: $isDone)';
}
