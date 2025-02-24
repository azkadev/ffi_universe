/// Foreign Function Interface for interoperability with the C programming language.
///
/// This is quivalent to the `dart:ffi` package for the web platform.
library;

export "core/ffi/abi.dart";
export 'core/ffi/allocation.dart';
export 'core/ffi/dynamic_library.dart';
export 'core/ffi/extensions.dart';
export 'core/ffi/marshaller.dart' show registerOpaqueType;
export 'core/ffi/native_finalizer.dart';
export 'core/ffi/types.dart';

export 'core/ffi_utils/allocation.dart' show calloc, malloc;
export 'core/ffi_utils/arena.dart';
export 'core/ffi_utils/utf16.dart';
export 'core/ffi_utils/utf8.dart';
