import 'package:logger/logger.dart';

class AppLogger {
  AppLogger._privateConstructor();

  static final AppLogger _instance = AppLogger._privateConstructor();

  static AppLogger get instance => _instance;

  var logger = Logger(
    printer: PrettyPrinter(),
  );
}
