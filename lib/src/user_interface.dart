import 'package:clearskies/src/weather.dart';
import 'package:dart_console/dart_console.dart';

final console = Console();

class UserInterface {
  var screens = <Function>[
    (() {
      final row = (console.windowHeight / 2).round() - 1;

      console
        ..clearScreen()
        ..setBackgroundColor(ConsoleColor.white)
        ..setForegroundColor(ConsoleColor.black)
        ..writeLine('Clear Skies', TextAlignment.center)
        ..resetColorAttributes()
        ..cursorPosition = Coordinate(row - 2, 0)
        ..writeLine('test', TextAlignment.center);
    })
  ];
}
