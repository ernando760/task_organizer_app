import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  final String? id;
  final String title;
  final String? description;
  final bool isDone;

  const TaskEntity({
    this.id,
    required this.title,
    this.description,
    this.isDone = false,
  });

  @override
  List<Object?> get props => [id, title, description, isDone];

  @override
  bool get stringify => true;
}
