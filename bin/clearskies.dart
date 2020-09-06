import 'dart:io';

import 'package:args/args.dart';
import 'package:clearskies/src/weather.dart';

final parser = ArgParser(allowTrailingOptions: false);

void main(List<String> arguments) async {
  final helpMessage = '''Usage: clearskies -m [<mode>] [<name/id/ip/zip>]
  Modes:
    name: Get weather by name
    id: Get weather by OpenWeatherMap ID
    ip: Get weather by IP address
    zip: Get weather by ZIP code''';

  parser.addOption('mode', abbr: 'm', allowed: ['name', 'id', 'ip', 'zip']);

  try {
    parser.parse(arguments); // check if no mode is provided
  } on FormatException {
    print(helpMessage);
    exit(1); // exit code 1 meaning failure
  }

  final results = parser.parse(arguments);

  if (results['mode'] == null) print(helpMessage);

  if (results['mode'] == 'name') {
    try {
      var weather =
          await Weather(cityName: results.rest[0]).fetchWeatherFromName();
      print(weather);
    } on NoSuchMethodError {
      print('Not a valid city.');
    } on RangeError {
      print(helpMessage);
    }
  } else if (results['mode'] == 'id') {
    try {
      var id = int.parse(results.rest[0]);
      var weather = await Weather(cityId: id).fetchWeatherFromID();
      print(weather);
    } on NoSuchMethodError {
      print('Not a valid ID');
    } on RangeError {
      print(helpMessage);
    }
  } else if (results['mode'] == 'ip') {
    try {
      var weather = await Weather().fetchWeatherFromIP();
      print(weather);
    } on NoSuchMethodError {
      print('Unable to fetch weather (Did you put in your API key?)');
    }
  } else if (results['mode'] == 'zip') {
    try {
      var zip = int.parse(results.rest[0]);
      var weather = await Weather(zipCode: zip).fetchWeatherFromZIP();
      print(weather);
    } on NoSuchMethodError {
      print('Not a valid ZIP code.');
    } on RangeError {
      print(helpMessage);
    }
  }
}
