import 'dart:async';
import 'dart:ffi';

export 'dart:ffi';
export 'package:ffi/ffi.dart';

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
class FfiUniverseDynamicLibrary {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  static FutureOr<DynamicLibrary> openAsync({required String path}) async {
    return DynamicLibrary.open(path);
  }

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  static DynamicLibrary openSync({required String path}) {
    return DynamicLibrary.open(path);
  }
}
