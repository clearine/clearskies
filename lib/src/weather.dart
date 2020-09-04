import 'dart:convert';

import 'package:http/http.dart';

class Weather {
  Weather({this.cityName, this.cityId, this.zipCode});

  String cityName;
  int cityId;
  int zipCode;

  Future<String> fetchWeatherFromIP() async {
    var ipUrl = await get('http://ip-api.com/json/');
    var ipJson = jsonDecode(ipUrl.body);
    var weatherUrl =
        'https://api.openweathermap.org/data/2.5/weather?q=${ipJson['city']}&units=metric&appid=KEY';
    var weatherRequest = await get(weatherUrl);
    var weatherJson = jsonDecode(weatherRequest.body);

    return '''
    Description: ${weatherJson['weather'][0]['description']}
    Temperature (C): ${weatherJson['main']['temp']}
    Windspeed (KM): ${weatherJson['wind']['speed']}
    ''';
  }

  Future<String> fetchWeatherFromName() async {
    if (cityName == null) return 'No city name provided.';

    var url =
        'https://api.openweathermap.org/data/2.5/weather?q=${cityName.split(' ').join('+')}&units=metric&appid=KEY';
    var request = await get(url);
    var json = jsonDecode(request.body);

    return '''
    Description: ${json['weather'][0]['description']}
    Temperature (C): ${json['main']['temp']}
    Windspeed (KM): ${json['wind']['speed']}
    ''';
  }
}
