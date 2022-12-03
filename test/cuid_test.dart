import 'package:dcuid/dcuid.dart';
import 'package:test/test.dart';

void main() {
  // the Cuid is a singleton and the counter is
  // attached to the instance, this test always
  // must be the first or the test will fail
  test('must generate consecutive numbers the counter', () {
    expect(cuid().substring(9, 13), '0000');
    expect(cuid().substring(9, 13), '0001');
    expect(cuid().substring(9, 13), '0002');
    expect(cuid().substring(9, 13), '0003');

    expect(cuidSecure().substring(9, 13), '0004');
    expect(cuidSecure().substring(9, 13), '0005');
    expect(cuidSecure().substring(9, 13), '0006');
    expect(cuidSecure().substring(9, 13), '0007');
  });

  test('must use the same initial value always', () {
    expect(cuid().substring(0, 1), 'd');
    expect(cuid().substring(0, 1), 'd');
    expect(cuid().substring(0, 1), 'd');

    expect(cuidSecure().substring(0, 1), 'd');
    expect(cuidSecure().substring(0, 1), 'd');
    expect(cuidSecure().substring(0, 1), 'd');
  });

  test('must check for valid cuid', () {
    expect(isCuid(cuid()), true);
    expect(isCuid(cuidSecure()), true);
  });

  test('must return false if not seems a cuid', () {
    expect(isCuid(''), false);
    expect(isCuid('1q2w2e'), false);
  });

  test('must return an slug', () {
    expect(isSlug(cuidSlug()), true);
  });

  test('must return false if not seems a slug', () {
    expect(isSlug(''), false);
    expect(isSlug('q2w2e'), false);
  });

  test('must not get collisions', () {
    final s = <String>{};
    for (var i = 0; i < 500000; i++) {
      final c = cuid();
      if (s.contains(c)) {
        throw Exception('Collision detected at iteration %i');
      }
      s.add(c);
    }
  });

  test('must not get collisions (secure)', () {
    final s = <String>{};
    for (var i = 0; i < 500000; i++) {
      final c = cuidSecure();
      if (s.contains(c)) {
        throw Exception('Collision detected at iteration %i');
      }
      s.add(c);
    }
  });
}
