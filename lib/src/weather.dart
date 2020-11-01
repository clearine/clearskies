import 'dart:convert';
import 'dart:io';

import 'package:dart_console/dart_console.dart';
import 'package:http/http.dart';

final console = Console();

class Weather {
  Weather(this.apiKey, {this.cityName, this.cityId, this.zipCode});

  String cityName;
  String apiKey;
  int cityId;
  int zipCode;

  Map<dynamic, String> errorCodes = {
    401: 'Error 401. Did you provide an API key?',
    '404': 'Error 404. Make sure the provided name/ID/ZIP is valid.',
    429: 'Error 429. You have made more than 60 API calls per minute.'
  };

  bool checkForError(code) {
    if (errorCodes[code] == null) return false;
    return true;
  }

  // TODO: Make output fancier.
  // TODO: Fix output formatting.

  Future<String> fetchWeatherFromIP() async {
    var ipUrl = await get('http://ip-api.com/json/');
    var ipJson = jsonDecode(ipUrl.body);
    var weatherUrl =
        'https://api.openweathermap.org/data/2.5/weather?q=${ipJson['city']}&units=metric&appid=$apiKey';
    var weatherRequest = await get(weatherUrl);
    var weatherJson = jsonDecode(weatherRequest.body);

    if (checkForError(weatherJson['cod'])) {
      return errorCodes[weatherJson['cod']];
    }

    return '''
    Description: ${weatherJson['weather'][0]['description']}
    Temperature (C): ${weatherJson['main']['temp']}
    Windspeed (KM): ${weatherJson['wind']['speed']}
    ''';
  }

  Future<String> fetchWeatherFromName() async {
    if (cityName == null) return 'No city name provided.';

    var url =
        'https://api.openweathermap.org/data/2.5/weather?q=${cityName.split(' ').join('+')}&units=metric&appid=$apiKey';
    var request = await get(url);
    var json = jsonDecode(request.body);

    if (checkForError(json['cod'])) {
      return errorCodes[json['cod']];
    }

    return '''
    Description: ${json['weather'][0]['description']}
    Temperature (C): ${json['main']['temp']}
    Windspeed (KM): ${json['wind']['speed']}
    ''';
  }

  Future<String> fetchWeatherFromID() async {
    if (cityId == null) return 'No city ID provided.';

    var url =
        'https://api.openweathermap.org/data/2.5/weather?id=${cityId}&units=metric&appid=$apiKey';
    var request = await get(url);
    var json = jsonDecode(request.body);

    if (checkForError(json['cod'])) {
      return errorCodes[json['cod']];
    }

    return '''
    Description: ${json['weather'][0]['description']}
    Temperature (C): ${json['main']['temp']}
    Windspeed (KM): ${json['wind']['speed']}
    ''';
  }

  Future<String> fetchWeatherFromZIP() async {
    if (zipCode == null) return 'No ZIP code provided.';

    var url =
        'https://api.openweathermap.org/data/2.5/weather?zip=${zipCode}&units=metric&appid=$apiKey';
    var request = await get(url);
    var json = jsonDecode(request.body);

    if (checkForError(json['cod'])) {
      return errorCodes[json['cod']];
    }

    return '''
    Description: ${json['weather'][0]['description']}
    Temperature (C): ${json['main']['temp']}
    Windspeed (KM): ${json['wind']['speed']}
    ''';
  }
}
