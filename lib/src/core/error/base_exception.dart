abstract class BaseException implements Exception {
  final String? label;
  final String message;
  final String? logMessage;
  final StackTrace? stackTrace;

  BaseException({
    this.label,
    required this.message,
    this.logMessage,
    this.stackTrace,
  });
}

class UnknownException extends BaseException {
  UnknownException({
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
