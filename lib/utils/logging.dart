import 'dart:developer';
import 'package:logging/logging.dart';

void logData(dynamic data) =>
    AppLogger().logData(data.toString());

void logError(String data, {Exception? exception, StackTrace? stackTrace}) =>
    AppLogger().logError(data, exception, stackTrace);

class AppLogger {
  static final AppLogger _appLogger = AppLogger._();
  factory AppLogger() => _appLogger;

  late final Logger _logger;

  AppLogger._();

  Future<void> init() async {
    Logger.root.level = Level.ALL;
    _logger = Logger('DEV');
    _logger.onRecord.listen((event) {
      var data = '';
      switch (event.level) {
        case Level.SHOUT: data = _errorLogFormat(event);
        case Level.FINE: data = _debugLogFormat(event);
        case Level.FINER: data = _debugLogFormat(event);
      }
      log(data, time: event.time);
    });
  }

  String _debugLogFormat(LogRecord event) => 'DEBUG ${event.time}:: ${event.message}';

  String _errorLogFormat(LogRecord event) => 'ERROR ${event.time}:: ${event.message}, ${event.error ?? ''} '
      '${(event.stackTrace == null) ? '' : '\n${event.stackTrace}'}';

  logData(String message) => _logger.fine(message);

  logError(String message, [Exception? exception, StackTrace? stackTrace]) =>
      _logger.shout(message, exception, stackTrace);
}
