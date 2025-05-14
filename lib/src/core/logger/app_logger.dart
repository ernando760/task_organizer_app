import 'package:logger/logger.dart';

import '../error/base_exception.dart';

class AppLogger {
  final Logger _logger = Logger();

  void info(String message, {BaseException? error, DateTime? time}) {
    _logger.i(message, error: error, stackTrace: error?.stackTrace, time: time);
  }

  void error(String message, {BaseException? error, DateTime? time}) {
    _logger.e(message, error: error, stackTrace: error?.stackTrace, time: time);
  }

  void warning(String message, {BaseException? error, DateTime? time}) {
    _logger.w(message, error: error, stackTrace: error?.stackTrace, time: time);
  }

  void debug(String message, {BaseException? error, DateTime? time}) {
    _logger.d(message, error: error, stackTrace: error?.stackTrace, time: time);
  }

  void trace(String message, {BaseException? error, DateTime? time}) {
    _logger.t(message, error: error, stackTrace: error?.stackTrace, time: time);
  }

  void fatal(String message, {BaseException? error, DateTime? time}) {
    _logger.f(message, error: error, stackTrace: error?.stackTrace, time: time);
  }
}
