// import 'package:ffi_universe/io/io.dart';

import 'package:ffi_universe/ffi/ffi.dart';

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
class VectorFfiUniverseUtils {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  ///
  /// Convert
  ///
  /// From = List\<String\> args[1] = ["hello"];
  ///
  /// to = std::vector\<char\> argv[1] = {"hello"}
  ///
  static Pointer<Pointer<Char>> fromListStringToVectorChar({required List<String> strings}) {
    final List<Pointer<Char>> utf8PointerList = strings.map((str) => str.toNativeUtf8().cast<Char>()).toList();

    final Pointer<Pointer<Char>> pointerPointer = malloc.allocate(utf8PointerList.length);
    strings.asMap().forEach((index, utf) {
      pointerPointer[index] = utf8PointerList[index];
    });
    return pointerPointer;
  }

  ///
  /// Convert
  ///
  /// From = List\<String\> args[1] = ["hello"];
  ///
  /// to = std::vector\<string\> argv[1] = {"hello"}
  ///
  static Pointer<Pointer<Utf8>> fromListStringToVectorString({required List<String> strings}) {
    final List<Pointer<Utf8>> utf8PointerList = strings.map((str) => str.toNativeUtf8()).toList();
    final Pointer<Pointer<Utf8>> pointerPointer = malloc.allocate(utf8PointerList.length);
    strings.asMap().forEach((index, utf) {
      pointerPointer[index] = utf8PointerList[index];
    });
    return pointerPointer;
  }
}
