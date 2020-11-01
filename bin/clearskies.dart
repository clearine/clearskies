import 'package:clearskies/src/user_interface.dart';
import 'package:dart_console/dart_console.dart';

final interface = UserInterface();
final console = Console();
void main() {
  interface.init();
  console
    ..writeLine('d: fetch weather from ID', TextAlignment.center)
    ..writeLine('i: fetch weather from IP', TextAlignment.center)
    ..writeLine('n: fetch weather from name', TextAlignment.center)
    ..writeLine('z: fetch weather from ZIP code', TextAlignment.center);

  interface.getSelection();
}
