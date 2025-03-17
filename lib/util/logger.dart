import 'package:flutter/rendering.dart';
import 'package:jorim_flutter/util/theme/colors.dart';

enum LogLevel { DEBUG, INFO, WARN, ERROR }

void logMessage(String message, {LogLevel level = LogLevel.DEBUG}) {
  final now = DateTime.now();
  final formattedTime =
      "${now.year}/${now.month.toString().padLeft(2, '0')}/${now.day.toString().padLeft(2, '0')} "
      "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}.${now.millisecond}";
  final levelStr = level.toString().split(".").last;
  String color;

  debugPrint("$formattedTime | [$levelStr] | $message");
}
