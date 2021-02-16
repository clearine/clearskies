import 'dart:convert';

import 'package:dart_console/dart_console.dart';
import 'package:http/http.dart';

final console = Console();

class Weather {
  Weather(this.apiKey);
  String apiKey;

  final Map<dynamic, String> _errorCodes = const {
    401: 'Error 401. Did you provide an API key?',
    '404': 'Error 404. Make sure the provided name/ID/ZIP is valid.',
    429: 'Error 429. You have made more than 60 API calls per minute.'
  };

  bool _checkForError(code) {
    if (_errorCodes[code] == null) return false;
    return true;
  }

  dynamic _getJson(String url) async {
    var getRequest = await get(url);
    return jsonDecode(getRequest.body);
  }

  // TODO: Make output fancier.
  // TODO: Fix output formatting.

  Future<String> fetchWeatherFromIP() async {
    var ipJson = await _getJson('http://ip-api.com/json/');
    var weatherJson = await _getJson(
        'https://api.openweathermap.org/data/2.5/weather?q=${ipJson['city']}&units=metric&appid=$apiKey');

    if (_checkForError(weatherJson['cod'])) {
      return _errorCodes[weatherJson['cod']];
    }

    return '''
    Description: ${weatherJson['weather'][0]['description']}
    Temperature (C): ${weatherJson['main']['temp']}
    Windspeed (KM): ${weatherJson['wind']['speed']}
    ''';
  }

  Future<String> fetchWeatherFromName(String name) async {
    if (name == null) return 'No city name provided.';

    var json = await _getJson(
        'https://api.openweathermap.org/data/2.5/weather?q=${name.split(' ').join('+')}&units=metric&appid=$apiKey');

    if (_checkForError(json['cod'])) {
      return _errorCodes[json['cod']];
    }

    return '''
    Description: ${json['weather'][0]['description']}
    Temperature (C): ${json['main']['temp']}
    Windspeed (KM): ${json['wind']['speed']}
    ''';
  }

  Future<String> fetchWeatherFromID(int id) async {
    if (id == null) return 'No city ID provided.';

    var json = await _getJson(
        'https://api.openweathermap.org/data/2.5/weather?id=${id}&units=metric&appid=$apiKey');

    if (_checkForError(json['cod'])) {
      return _errorCodes[json['cod']];
    }

    return '''
    Description: ${json['weather'][0]['description']}
    Temperature (C): ${json['main']['temp']}
    Windspeed (KM): ${json['wind']['speed']}
    ''';
  }

  Future<String> fetchWeatherFromZIP(int zip) async {
    if (zip == null) return 'No ZIP code provided.';

    var json = await _getJson(
        'https://api.openweathermap.org/data/2.5/weather?zip=${zip}&units=metric&appid=$apiKey');

    if (_checkForError(json['cod'])) {
      return _errorCodes[json['cod']];
    }

    return '''
    Description: ${json['weather'][0]['description']}
    Temperature (C): ${json['main']['temp']}
    Windspeed (KM): ${json['wind']['speed']}
    ''';
  }
}
