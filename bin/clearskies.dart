import 'package:args/args.dart';
import 'package:clearskies/src/weather.dart';

final parser = ArgParser(allowTrailingOptions: false);

void main(List<String> arguments) async {
  parser.addOption('mode', abbr: 'm', allowed: ['name', 'id', 'zip']);
  var results = parser.parse(arguments);

  if (results['mode'] == 'name') {
    var weather =
        await Weather(cityName: results.rest[0]).fetchWeatherFromName();
    print(weather);
  } else if (results['mode'] == 'id') {
    var id = int.parse(results.rest[0]);
    var weather = await Weather(cityId: id).fetchWeatherFromID();
    print(weather);
  } else if (results['mode'] == 'zip') {
    var zip = int.parse(results.rest[0]);
    var weather = await Weather(zipCode: zip).fetchWeatherFromZIP();
    print(weather);
  } else {
    print('${results.rest[0]} is not a valid option.');
  }
}
