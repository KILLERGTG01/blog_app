import 'package:logging/logging.dart';

final Logger logger = Logger('BlogExplorerLogger');

void setupLogging() {
  // Set the logging level (ALL, FINE, INFO, WARNING, SEVERE, etc.)
  logger.level = Level.ALL;

  // Configure the logger to listen for log records and log them
  logger.onRecord.listen((LogRecord record) {
    // Log the formatted message directly using logger's severe method if necessary.
    logger.log(record.level, '${record.level.name}: ${record.time}: ${record.message}');

    if (record.error != null) {
      logger.log(Level.SEVERE, 'Error: ${record.error}');
    }

    if (record.stackTrace != null) {
      logger.log(Level.SEVERE, 'Stacktrace: ${record.stackTrace}');
    }
  });
}
