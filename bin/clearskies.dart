import 'package:args/args.dart';
import 'package:clearskies/src/weather.dart';

final parser = ArgParser(allowTrailingOptions: false);

void main(List<String> arguments) {
  parser.addOption('name', abbr: 'n');
  parser.addOption('id', abbr: 'i');

  var results = parser.parse(arguments);
}
