import 'package:clearskies/src/user_interface.dart';
import 'package:dart_console/dart_console.dart';

final interface = UserInterface();
final console = Console();
void main() {
  final row = (console.windowHeight / 2).round() - 1;

  console
    ..clearScreen()
    ..hideCursor()
    ..setBackgroundColor(ConsoleColor.white)
    ..setForegroundColor(ConsoleColor.black)
    ..writeLine('Clear Skies', TextAlignment.center)
    ..resetColorAttributes()
    ..cursorPosition = Coordinate(row - 2, 0)
    ..writeLine('test text', TextAlignment.center);

  var key = console.readKey();

  switch (key.char) {
    case 'd':
      interface.showWeatherFromID();
      break;
    case 'i':
      interface.showWeatherFromIP();
      break;
    case 'n':
      interface.showWeatherFromName();
      break;
    case 'z':
      interface.showWeatherFromZIP();
      break;
  }
}
