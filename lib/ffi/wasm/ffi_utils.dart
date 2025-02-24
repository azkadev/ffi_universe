/// Utilities for working with Foreign Function Interface (FFI) code, incl.
/// converting between Dart strings and C strings encoded with UTF-8 and UTF-16.
///
/// This is quivalent to the `package:ffi/ffi.dart` package for the web platform.
library;

export 'core/ffi_utils/allocation.dart' show calloc, malloc;
export 'core/ffi_utils/arena.dart';
export 'core/ffi_utils/utf16.dart';
export 'core/ffi_utils/utf8.dart';
