import 'dart:io';
import 'dart:math';

import './str_ext.dart';

/// size of the alphabet (e.g. base36 is [a-z0-9])
const base = 36;

/// Length of each segment of the hash
const blockSize = 4;

/// first letter of the hash
const letter = 'd';

/// maximum number that can be stored in a block of the specified size using the specified alphabet
final _discreteValues = pow(base, blockSize) - 1; // b36 = zzzz / b10 = 1679615

final _rxFormat = RegExp('$letter[0-9a-z]{${6 * blockSize}}');

///
class Cuid {
  static final Cuid _instance = Cuid._internal();
  var _counter = 0;
  String _fingerprint = '';

  /// Factory that create a new [Cuid] instance
  factory Cuid() {
    return _instance;
  }

  Cuid._internal();

  /// Generates a new Cuid using [Random] generator.
  String gen() {
    return _assembleCUID(_getRandom(), _getRandom());
  }

  /// Generates a new id using cryptographic random generator.
  /// Will throw error if the system can not provide a secure source of random numbers.
  /// Check [Random.secure()] for details
  String secure() {
    return _assembleCUID(_getRandomCrypto(), _getRandomCrypto());
  }

  /// Makes a simple guess about the hash format, returns true if seems valid.
  bool isCuid(String value) => _rxFormat.hasMatch(value);

  /// Makes a simple guess about the slug format
  bool isSlug(String value) {
    final l = value.length;
    return l >= 6 && l <= 10;
  }

  /// Generates a new slug.
  /// A slug is a simplified/shorter cuid. Do not use use it except for generate
  /// url slug or similar
  String slug() {
    final fingerprint = _getFingerprint();
    final sb = StringBuffer()
      ..write(_getTimestamp().slice(-2))
      ..write(_getCounter())
      ..write('${fingerprint.substring(0, 1)}${fingerprint.slice(-1)}')
      ..write(_getRandom().slice(-2));

    return sb.toString();
  }

  String _assembleCUID(String rnd1, String rnd2) {
    final sb = StringBuffer(letter)
      ..write(_getTimestamp())
      ..write(_getCounter())
      ..write(_getFingerprint())
      ..write(rnd1)
      ..write(rnd2);

    return sb.toString();
  }

  String _getCounter() {
    return _pad(_nextCounter().toRadixString(base), blockSize);
  }

  String _getFingerprint() {
    if (_fingerprint.isNotEmpty) return _fingerprint;

    final hostname = Platform.localHostname;
    final hostId = _pad(
      hostname
          .split('')
          .fold(
            hostname.length + base,
            (value, element) => value + element.codeUnitAt(0),
          )
          .toRadixString(base),
      2,
    );
    return _fingerprint = '${_pad(pid.toRadixString(base), 2)}$hostId';
  }

  String _getRandom() {
    return _pad(Random().nextInt(_discreteValues as int).toRadixString(base), blockSize);
  }

  String _getRandomCrypto() {
    return _pad(Random.secure().nextInt(_discreteValues as int).toRadixString(base), blockSize);
  }

  int _nextCounter() {
    _counter = _counter < _discreteValues ? _counter : 0;
    _counter++;
    return _counter - 1;
  }

  String _pad(String value, int len) {
    return '000000000$value'.slice(len * -1);
  }

  static String _getTimestamp() {
    return DateTime.now().millisecondsSinceEpoch.toRadixString(base);
  }
}
