import 'dart:io';

import 'package:clearskies/src/weather.dart';
import 'package:dart_console/dart_console.dart';

final weather = Weather('key');
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

  void showWelcome() {
    init();
    console
      ..writeLine('d: fetch weather from ID', TextAlignment.center)
      ..writeLine('i: fetch weather from IP', TextAlignment.center)
      ..writeLine('n: fetch weather from name', TextAlignment.center)
      ..writeLine('z: fetch weather from ZIP code', TextAlignment.center)
      ..writeLine('h: show this message', TextAlignment.center)
      ..writeLine('q: quit clear skies', TextAlignment.center);
    getSelection();
  }

  void getSelection() {
    var selectionSet = false;
    while (!selectionSet) {
      var selection = console.readKey();
      if (selection.controlChar == ControlCharacter.ctrlC) {
        console.clearScreen();
        console.showCursor();
        exit(0);
      }

      switch (selection.char) {
        case 'd':
          getWeatherFromID();
          break;
        case 'i':
          getWeatherFromIP();
          break;
        case 'n':
          getWeatherFromName();
          break;
        case 'z':
          getWeatherFromZIP();
          break;
        case 'h':
          showWelcome();
          break;
        case 'q':
          console.clearScreen();
          console.showCursor();
          exit(0);
          break;
        default:
          continue;
      }
      selectionSet = true;
    }
  }

  void displayWeather(WeatherInfo weatherInfo) {
    init();
    if (weatherInfo.errorCode != null) {
      console.writeLine(
          WeatherInfo.errorCodes[weatherInfo.errorCode], TextAlignment.center);
    } else {
      console
        ..writeLine(
            'Description: ${weatherInfo.description}', TextAlignment.center)
        ..writeLine('Temperature: ${weatherInfo.temperature.toString()}',
            TextAlignment.center)
        ..writeLine('Wind speed: ${weatherInfo.windSpeed.toString()}',
            TextAlignment.center);
    }
    getSelection();
  }

  void getWeatherFromIP() async {
    console.clearScreen();
    displayWeather(await weather.fetchWeatherFromIP());
  }

  void getWeatherFromName() async {
    String name;
    var nameSet = false;

    console.clearScreen();
    console.showCursor();

    while (!nameSet) {
      console.write('Enter a city name: ');
      final input = console.readLine(cancelOnBreak: true);
      if (input == null) {
        // input can only be null if user does ctrl + c
        console.clearScreen();
        exit(0);
      } else if (input == '') {
        continue;
      }
      nameSet = true;
      name = input;
    }
    displayWeather(await weather.fetchWeatherFromName(name));
  }

  void getWeatherFromID() async {
    String id;
    var idSet = false;

    console.clearScreen();
    console.showCursor();

    while (!idSet) {
      console.write('Enter a city ID: ');
      final input = console.readLine(cancelOnBreak: true);

      if (input == null) {
        // input can only be null if user does ctrl + c
        console.clearScreen();
        exit(0);
      } else if (input == '') {
        continue;
      }

      idSet = true;
      id = input;
    }
    displayWeather(await weather.fetchWeatherFromID(id));
  }

  void getWeatherFromZIP() async {
    String zip;
    var zipSet = false;

    console.clearScreen();
    console.showCursor();

    while (!zipSet) {
      console.write('Enter a ZIP code: ');
      final input = console.readLine(cancelOnBreak: true);

      if (input == null) {
        // input can only be null if user does ctrl + c
        console.clearScreen();
        exit(0);
      } else if (input == '') {
        continue;
      }

      zipSet = true;
      zip = input;
    }
    displayWeather(await weather.fetchWeatherFromZIP(zip));
  }
}
