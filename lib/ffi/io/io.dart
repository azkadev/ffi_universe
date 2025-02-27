import 'dart:async';
import 'dart:ffi';

export 'dart:ffi';
export 'package:ffi/ffi.dart';

class FfiUniverseDynamicLibrary {
  static FutureOr<DynamicLibrary> openAsync({required String path}) async {
    return DynamicLibrary.open(path);
  }
  static DynamicLibrary openSync({
    required String path,
  }) {
    return DynamicLibrary.open(path);
  }
}
