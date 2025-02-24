Standarization FFI will bring support cross platform same style api for boost project

   
import 'package:ffi_universe/ffi_universe.dart';

typedef NativeFunction = Void Function(Pointer<Char> text);
typedef DartFunction = void Function(Pointer<Char> text);

void main() async {
  final DynamicLibrary dynamicLibrary = await FFIUniverse.open(
    path: "libraryname",
  );
  final String text = "Hello";
  final Pointer<Utf8> textNative = text.toNativeUtf8();
  final DartFunction mainFunction = dynamicLibrary.lookupFunction<NativeFunction, DartFunction>("main");
  mainFunction(textNative.cast<Char>());
  malloc.free(textNative);
  dynamicLibrary.close();
}
