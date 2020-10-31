import 'package:clearskies/src/weather.dart';
import 'package:dart_console/dart_console.dart';

final console = Console();

class UserInterface {
  void showWeatherFromID() async {
    console.clearScreen();
    console.showCursor();
    console.writeLine('Enter a city ID: ');
    final input = console.readLine(cancelOnBreak: true);
    final cityId = int.parse(input);
    console
        .writeLine(await Weather('key', cityId: cityId).fetchWeatherFromID());
  }

  void showWeatherFromIP() async {
    console.clearScreen();
    console.writeLine(await Weather('key').fetchWeatherFromIP());
  }

  void showWeatherFromName() async {
    console.clearScreen();
    console.showCursor();
    console.writeLine('Enter a city name: ');
    final name = console.readLine(cancelOnBreak: true);
    console
        .writeLine(await Weather('key', cityName: name).fetchWeatherFromID());
  }

  void showWeatherFromZIP() async {
    console.clearScreen();
    console.showCursor();
    console.writeLine('Enter a ZIP code: ');
    final input = console.readLine(cancelOnBreak: true);
    final zipCode = int.parse(input);
    console.writeLine(
        await Weather('key', zipCode: zipCode).fetchWeatherFromZIP());
  }
}
