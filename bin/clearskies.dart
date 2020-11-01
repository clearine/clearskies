import 'dart:io';

import 'package:clearskies/src/user_interface.dart';
import 'package:dart_console/dart_console.dart';

final interface = UserInterface();
final console = Console();
void main() {
  interface.init();
  console
    ..writeLine('d: fetch weather from ID', TextAlignment.center)
    ..writeLine('i: fetch weather from IP', TextAlignment.center)
    ..writeLine('n: fetch weather from name', TextAlignment.center)
    ..writeLine('z: fetch weather from ZIP code', TextAlignment.center);

  var key = console.readKey();

  if (key.controlChar == ControlCharacter.ctrlC) {
    console.clearScreen();
    console.showCursor();
    exit(0);
  }

  switch (key.char) {
    case 'd':
      interface.getWeatherFromID();
      break;
    case 'i':
      interface.getWeatherFromIP();
      break;
    case 'n':
      interface.getWeatherFromName();
      break;
    case 'z':
      interface.getWeatherFromZIP();
      break;
  }
}
