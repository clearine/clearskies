import 'dart:io';

import 'package:clearskies/src/weather.dart';
import 'package:dart_console/dart_console.dart';

final console = Console();
final row = (console.windowHeight / 2).round() - 1;

class UserInterface {
  void init() {
    console
      ..clearScreen()
      ..hideCursor()
      ..setBackgroundColor(ConsoleColor.white)
      ..setForegroundColor(ConsoleColor.black)
      ..writeLine('Clear Skies', TextAlignment.center)
      ..resetColorAttributes()
      ..cursorPosition = Coordinate(row - 2, 0);
  }

  void displayWeather(String weatherInfo) {
    init();
    console.writeLine(weatherInfo, TextAlignment.center);
  }

  void getWeatherFromID() async {
    console.clearScreen();
    console.showCursor();
    console.write('Enter a city ID: ');
    final input = console.readLine(cancelOnBreak: true);
    if (input == null) {
      // input can only be null if user does ctrl+c
      console.clearScreen();
      exit(0);
    }
    final cityId = int.parse(input);
    displayWeather(await Weather('key', cityId: cityId).fetchWeatherFromID());
  }

  void getWeatherFromIP() async {
    console.clearScreen();
    displayWeather(await Weather('key').fetchWeatherFromIP());
  }

  void getWeatherFromName() async {
    console.clearScreen();
    console.showCursor();
    console.write('Enter a city name: ');
    final name = console.readLine(cancelOnBreak: true);
    if (name == null) {
      console.clearScreen();
      exit(0);
    }
    displayWeather(await Weather('key', cityName: name).fetchWeatherFromID());
  }

  void getWeatherFromZIP() async {
    console.clearScreen();
    console.showCursor();
    console.write('Enter a ZIP code: ');
    final input = console.readLine(cancelOnBreak: true);
    if (input == null) {
      console.clearScreen();
      exit(0);
    }
    final zipCode = int.parse(input);
    displayWeather(
        await Weather('key', zipCode: zipCode).fetchWeatherFromZIP());
  }
}
