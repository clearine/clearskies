import 'dart:convert';

import 'package:http/http.dart';

class Weather {
  String cityName;
  int cityId;
  int ZipCode;

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
