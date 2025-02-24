import 'package:ffi_universe/ffi/ffi.dart';
import 'package:ffi_universe/utils/vector/vector.dart';

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
extension ListStringExtensionFFIUNIVERSE on List<String> {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  ///
  /// Convert
  ///
  /// From = List\<String\> args[1] = ["hello"];
  ///
  /// to = std::vector\<char\> argv[1] = {"hello"}
  ///
  Pointer<Pointer<Char>> toNativeVectorChar() {
    return VectorFfiUniverseUtils.fromListStringToVectorChar(strings: this);
  }

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  ///
  /// Convert
  ///
  /// From = List\<String\> args[1] = ["hello"];
  ///
  /// to = std::vector\<string\> argv[1] = {"hello"}
  ///
  Pointer<Pointer<Utf8>> toNativeVectorString() {
    return VectorFfiUniverseUtils.fromListStringToVectorString(strings: this);
  }
}
