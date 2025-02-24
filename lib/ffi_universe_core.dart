import 'dart:async';

import 'ffi/ffi.dart';

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
class FFIUniverse {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  static FutureOr<DynamicLibrary> open({
    required String path,
    String? moduleName,
    dynamic moduleLoader,
    dynamic wasmType,
    dynamic useAsGlobal,
  }) async {
    // ignore: await_only_futures
    return await DynamicLibrary.open(
      path,
    );
  }
}
