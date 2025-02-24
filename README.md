Standarization FFI will bring support cross platform same style api for boost project



import 'package:ffi_universe/ffi_universe.dart';

void main() async {
  final DynamicLibrary dynamicLibrary = await FFIUniverse.open(
    path: "libraryname",
  );
  dynamicLibrary.lookupFunction("main").call();
  dynamicLibrary.close();
}

