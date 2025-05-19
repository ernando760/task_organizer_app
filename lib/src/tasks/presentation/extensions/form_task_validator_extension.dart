import '../../domain/dtos/task/task_dto.dart';

extension FormTaskValidatorExtension on TaskDto {
  String? validateTitle(String? title) {
    if (title == null || title.isEmpty) {
      return "O titulo da tarefa não pode ser vazia";
    }

    return null;
  }
}
