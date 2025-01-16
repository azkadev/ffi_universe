/// Foreign Function Interface for interoperability with the C programming language.
///
/// This is quivalent to the `dart:ffi` package for the web platform.
library;

export 'core/ffi/allocation.dart';
export 'core/ffi/dynamic_library.dart';
export 'core/ffi/extensions.dart';
export 'core/ffi/marshaller.dart' show registerOpaqueType;
export 'core/ffi/native_finalizer.dart';
export 'core/ffi/types.dart';
