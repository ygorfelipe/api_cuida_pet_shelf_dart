import 'package:logger/logger.dart' as log;

import 'logger.dart';

class LoggerImpl implements Logger {
  final _logger = log.Logger();

  @override
  void debug(dynamic message, [error, StackTrace? stackTrace]) =>
      _logger.d(message, error: error, stackTrace: stackTrace);

  @override
  void error(dynamic message, [error, StackTrace? stackTrace]) =>
      _logger.e(message, error: error, stackTrace: stackTrace);

  @override
  void info(dynamic message, [error, StackTrace? stackTrace]) =>
      _logger.i(message, error: error, stackTrace: stackTrace);

  @override
  void warning(dynamic message, [error, StackTrace? stackTrace]) =>
      _logger.w(message, error: error, stackTrace: stackTrace);

  @override
  void infoServer(instance) {
    _logger.i('Start the ${instance.runtimeType} instance');
  }
}
