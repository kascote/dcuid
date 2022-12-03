import 'package:test/test.dart';

// ignore: avoid_relative_lib_imports
import '../lib/src/str_ext.dart';

void main() {
  test('must return an empty string if size requested is bigger that string length', () {
    expect(''.slice(10) == '', true);
    expect('some value'.slice(25) == 'some value', true);
  });

  test('must return an empty string if size requested is shorter than string length', () {
    expect(''.slice(-10) == '', true);
    expect('some value'.slice(-25) == 'some value', true);
  });

  test('must return an empty string if the requested value is 0', () {
    expect(''.slice(0) == '', true);
    expect('some value'.slice(0) == '', true);
  });

  test('must return the first N requested characters', () {
    expect('some value'.slice(5) == 'some ', true);
  });

  test('must return the last N requested characters', () {
    expect('some value'.slice(-5) == 'value', true);
  });
}
