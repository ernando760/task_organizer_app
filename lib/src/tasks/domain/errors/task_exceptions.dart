import '../../../core/error/base_exception.dart';

abstract class TaskException extends BaseException {
  TaskException({
    super.label,
    required super.message,
    super.logMessage,
    super.stackTrace,
  });
}

class GetAllTaskException extends TaskException {
  GetAllTaskException({
    super.label,
    String? message,
    super.logMessage,
    super.stackTrace,
  }) : super(
         message:
             message ??
             "Não foi possivel buscar todas as tarefas, por favor tente mais tarde.",
       );
}

class UpsertTaskException extends TaskException {
  UpsertTaskException({
    super.label,
    String? message,
    super.logMessage,
    super.stackTrace,
  }) : super(
         message:
             message ??
             "Não foi possivel Editar a tarefa, por favor tente mais tarde.",
       );
}

class RemoveTaskException extends TaskException {
  RemoveTaskException({
    super.label,
    String? message,
    super.logMessage,
    super.stackTrace,
  }) : super(
         message:
             message ??
             "Não foi possivel remover a tarefa, por favor tente mais tarde.",
       );
}

class TaskUnknownException extends TaskException {
  TaskUnknownException({
    super.label,
    String? message,
    super.logMessage,
    super.stackTrace,
  }) : super(
         message:
             message ??
             "Ocorreu um erro inesperado, por favor tente mais tarde.",
       );
}
