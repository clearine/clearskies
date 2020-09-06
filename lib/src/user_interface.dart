import 'dart:io';

import 'package:clearskies/src/weather.dart';
import 'package:console/console.dart';
import 'package:console/curses.dart';

class UserInterface extends Window {
  UserInterface() : super('Clear Skies');

  @override
  void draw() {
    super.draw();
    writeCentered('Welcome to Clear Skies');
  }

  @override
  void initialize() {
    Keyboard.bindKeys(['q', 'Q']).listen((_) {
      close();
      Console.resetAll();
      Console.eraseDisplay();
      exit(0);
    });

    Keyboard.bindKeys(['w', 'W']).listen((_) async {
      super.draw();
      writeCentered(await Weather('key').fetchWeatherFromIP());
    });
  }
}
