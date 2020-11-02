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

  void showWelcome() {
    init();
    console
      ..writeLine('d: fetch weather from ID', TextAlignment.center)
      ..writeLine('i: fetch weather from IP', TextAlignment.center)
      ..writeLine('n: fetch weather from name', TextAlignment.center)
      ..writeLine('z: fetch weather from ZIP code', TextAlignment.center);
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
          getSelection();
          break;
        default:
          continue;
      }
      selectionSet = true;
    }
  }

  void displayWeather(String weatherInfo) {
    init();
    console.writeLine(weatherInfo, TextAlignment.center);
    getSelection();
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
    displayWeather(await Weather('key', cityName: name).fetchWeatherFromName());
  }

  void getWeatherFromID() async {
    int cityId;
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
      }

      try {
        int.parse(input);
      } on FormatException {
        console.writeLine('Not a valid ID.');
        continue;
      }
      idSet = true;
      cityId = int.parse(input);
    }
    displayWeather(await Weather('key', cityId: cityId).fetchWeatherFromID());
  }

  void getWeatherFromZIP() async {
    int zipCode;
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
      }

      try {
        int.parse(input);
      } on FormatException {
        console.writeLine('Not a valid ZIP code.');
        continue;
      }
      zipSet = true;
      zipCode = int.parse(input);
    }
    displayWeather(
        await Weather('key', zipCode: zipCode).fetchWeatherFromZIP());
    getSelection();
  }
}
