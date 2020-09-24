import 'dart:io';

import 'package:clearskies/src/weather.dart';
import 'package:console/console.dart';
import 'package:console/curses.dart';

class UserInterface extends Window {
  UserInterface() : super('Clear Skies');

  @override
  void draw() {
    super.draw();
    writeCentered(
        '${Color.WHITE}Welcome to Clear Skies. Press h to show the keybinds.');
  }

  @override
  void initialize() {
    Keyboard.bindKeys(['q', 'Q']).listen((_) {
      close();
      Console.resetAll();
      Console.eraseDisplay();
      exit(0);
    });

    Keyboard.bindKeys(['h', 'H']).listen((_) {
      super.draw();
      writeCentered(
          '${Color.WHITE}d: fetch weather from ID\t i: fetch weather from IP\t n: fetch weather from name\t z: fetch weather from ZIP code');
    });

    Keyboard.bindKeys(['d', 'D']).listen((_) async {
      close();
      Console.eraseDisplay();
      var weather = await getUserInputID();
      super.draw();
      writeCentered(weather);
    });

    Keyboard.bindKeys(['i', 'I']).listen((_) async {
      super.draw();
      writeCentered(await Weather('key').fetchWeatherFromIP());
    });

    Keyboard.bindKeys(['n', 'N']).listen((_) async {
      close();
      Console.eraseDisplay();
      var cityName = await readInput('${Color.WHITE}Enter a city name: ');
      super.draw();
      writeCentered(
          await Weather('key', cityName: cityName).fetchWeatherFromName());
    });

    Keyboard.bindKeys(['z', 'Z']).listen((_) async {
      close();
      Console.eraseDisplay();
      var weather = await getUserInputZIP();
      super.draw();
      writeCentered(weather);
    });
  }

  // made these functions for error handling purposes
  Future<String> getUserInputID() async {
    String cityIdString;
    int cityId;
    var idNotSet = true;
    while (idNotSet) {
      cityIdString = await readInput('${Color.WHITE}Enter a city ID: ');
      try {
        int.parse(cityIdString);
      } on FormatException {
        print('Not a valid ID.\n');
        await getUserInputID();
      }
      idNotSet = false;
      cityId = int.parse(cityIdString);
    }
    return Weather('key', cityId: cityId).fetchWeatherFromID();
  }

  Future<String> getUserInputZIP() async {
    String zipCodeString;
    int zipCode;
    var zipNotSet = true;
    while (zipNotSet) {
      zipCodeString = await readInput('${Color.WHITE}Enter a city ID: ');
      try {
        int.parse(zipCodeString);
      } on FormatException {
        print('Not a valid ID.\n');
        await getUserInputID();
      }
      zipNotSet = false;
      zipCode = int.parse(zipCodeString);
    }
    return Weather('key', zipCode: zipCode).fetchWeatherFromZIP();
  }
}
