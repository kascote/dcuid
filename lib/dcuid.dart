// Copyright 2022 (c) netFlux
//
// Licensed under MIT license
// ...

/// `dcuid` is a [Dart](https://dart.dev/) implementation of js [cuid](https://github.com/paralleldrive/cuid) library.
///
/// _CUID is a Collision-resistant ids optimized for horizontal scaling and binary search lookup performance._
///
/// For technical details is recommended to check the original documentation where the inner details are explained.
///
/// Example usage:
///
/// ```dart
///   // cuid generator
///   cuid(); // => cl8qj639w000l7n6e6p689uad
///
///   // cuid using secure random generator
///   cuidCrypto(); // => cl8qjcei8000kfq6e3a1q19os
///
///   // slug generator
///   cuidSlug(); // => 9w000g7e9a
/// ```
library dcuid;

import 'src/cuid_generator.dart' show Cuid;

/// Generates a new id
String cuid() => Cuid().gen();

/// Generates a new id using cryptographic random generator.
/// Will throw error if the system can not provide a secure source of random numbers. Check [Random.secure()]
String cuidSecure() => Cuid().secure();

/// Generates a new slug.
String cuidSlug() => Cuid().slug();

/// Makes a simple guess about the hash format
bool isCuid(String value) => Cuid().isCuid(value);

/// Makes a simple guess about the slug format
bool isSlug(String value) => Cuid().isSlug(value);
