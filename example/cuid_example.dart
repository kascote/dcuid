import 'dart:io';
import 'package:dcuid/dcuid.dart';

void main(List<String> arguments) {
  for (var i = 0; i < 10; i++) {
    final c = cuid();
    stdout.writeln('$c ${isCuid(c)}');
  }

  for (var i = 0; i < 10; i++) {
    final s = cuidSlug();
    stdout.writeln('$s ${isSlug(s)}');
  }

  for (var i = 0; i < 10; i++) {
    final c = cuidSecure();
    stdout.writeln('$c ${isCuid(c)}');
  }
}
