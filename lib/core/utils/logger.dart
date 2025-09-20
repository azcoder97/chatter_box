import 'package:logger/logger.dart';

final Logger log = Logger(
  printer: PrettyPrinter(
    methodCount: 2, // number of method calls to be displayed
    errorMethodCount: 5, // number of method calls when error is thrown
    lineLength: 50,
    colors: true,
    printEmojis: true,
    dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart, // ✅ use this instead of printTime
  ),
);
