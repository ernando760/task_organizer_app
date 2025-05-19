import 'package:equatable/equatable.dart';

import '../../domain/entities/task/task_entity.dart';

sealed class TasksState extends Equatable {}

final class InitialTask extends TasksState {
  @override
  List<Object?> get props => [];
}

final class LoadingTask extends TasksState {
  @override
  List<Object?> get props => [];
}

final class LoadedTask extends TasksState {
  LoadedTask({required this.tasks});

  final List<TaskEntity> tasks;

  @override
  List<Object?> get props => [tasks];
}

final class ErrorTask extends TasksState {
  ErrorTask({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
