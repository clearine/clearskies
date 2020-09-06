import 'package:args/args.dart';
import 'package:clearskies/src/user_interface.dart';

final parser = ArgParser(allowTrailingOptions: false);

void main(List<String> arguments) {
  var window = UserInterface();
  window.display();
}
