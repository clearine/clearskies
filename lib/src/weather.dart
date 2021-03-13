import 'dart:convert';

import 'package:dart_console/dart_console.dart';
import 'package:http/http.dart';

final console = Console();

class Weather {
  Weather(this.apiKey);
  String apiKey;

  dynamic _getJson(Uri url) async {
    var getRequest = await get(url);
    return jsonDecode(getRequest.body);
  }

  // TODO: Make output fancier.

  Future<WeatherInfo> fetchWeatherFromIP() async {
    var ipJson = await _getJson(Uri.http('ip-api.com', '/json'));
    var weatherJson = await _getJson(Uri.https(
        'api.openweathermap.org',
        '/data/2.5/weather',
        {'q': ipJson['city'], 'units': 'metric', 'appid': apiKey}));

    if (WeatherInfo.checkForError(weatherJson['cod'])) {
      return WeatherInfo(null, null, null, errorCode: weatherJson['cod']);
    }

    if (weatherJson['main']['temp'] is int) {
      weatherJson['main']['temp'] = weatherJson['main']['temp'].toDouble();
    }

    if (weatherJson['wind']['speed'] is int) {
      weatherJson['wind']['speed'] = weatherJson['wind']['speed'].toDouble();
    }

    return WeatherInfo(weatherJson['weather'][0]['description'],
        weatherJson['main']['temp'], weatherJson['wind']['speed']);
  }

  Future<WeatherInfo> fetchWeatherFromName(String name) async {
    var json = await _getJson((Uri.https('api.openweathermap.org',
        '/data/2.5/weather', {'q': name, 'units': 'metric', 'appid': apiKey})));

    if (WeatherInfo.checkForError(json['cod'])) {
      return WeatherInfo(null, null, null, errorCode: json['cod']);
    }

    if (json['main']['temp'] is int) {
      json['main']['temp'] = json['main']['temp'].toDouble();
    }

    if (json['wind']['speed'] is int) {
      json['wind']['speed'] = json['wind']['speed'].toDouble();
    }

    return WeatherInfo(json['weather'][0]['description'], json['main']['temp'],
        json['wind']['speed']);
  }

  Future<WeatherInfo> fetchWeatherFromID(String? id) async {
    var json = await _getJson(
        (Uri.https('api.openweathermap.org', '/data/2.5/weather', {
      'id': id,
      'units': 'metric',
      'appid': apiKey,
    })));

    if (WeatherInfo.checkForError(json['cod'])) {
      return WeatherInfo(null, null, null, errorCode: json['cod']);
    }

    if (json['main']['temp'] is int) {
      json['main']['temp'] = json['main']['temp'].toDouble();
    }

    if (json['wind']['speed'] is int) {
      json['wind']['speed'] = json['wind']['speed'].toDouble();
    }

    return WeatherInfo(json['weather'][0]['description'], json['main']['temp'],
        json['wind']['speed']);
  }

  Future<WeatherInfo> fetchWeatherFromZIP(String? zip) async {
    var json = await _getJson(
        (Uri.https('api.openweathermap.org', '/data/2.5/weather', {
      'zip': zip,
      'units': 'metric',
      'appid': apiKey,
    })));

    if (WeatherInfo.checkForError(json['cod'])) {
      return WeatherInfo(null, null, null, errorCode: json['cod']);
    }

    if (json['main']['temp'] is int) {
      json['main']['temp'] = json['main']['temp'].toDouble();
    }

    if (json['wind']['speed'] is int) {
      json['wind']['speed'] = json['wind']['speed'].toDouble();
    }

    return WeatherInfo(json['weather'][0]['description'], json['main']['temp'],
        json['wind']['speed']);
  }
}

class WeatherInfo {
  WeatherInfo(this.description, this.temperature, this.windSpeed,
      {this.errorCode});

  String? description;
  double? temperature;
  double? windSpeed;
  dynamic errorCode;

  static final Map<dynamic, String> errorCodes = const {
    // error 400 is the invalid ZIP error code, so the message for 404 also works.
    '400': 'Error 404. Make sure the provided name/ID/ZIP is valid.',
    401: 'Error 401. Did you provide an API key?',
    '404': 'Error 404. Make sure the provided name/ID/ZIP is valid.',
    429: 'Error 429. You have made more than 60 API calls per minute.'
  };

  static bool checkForError(code) {
    if (errorCodes[code] == null) return false;
    return true;
  }
}
