import 'dart:convert';
import 'package:ffi_universe/ffi_universe.dart';

typedef MainFunctionNative = Int Function(
    Int argc, Pointer<Pointer<Char>> argv);
typedef MainFunctionDart = int Function(int argc, Pointer<Pointer<Char>> argv);

typedef TestFunctionNative = Void Function(Pointer<Char> text);
typedef TestFunctionDart = void Function(Pointer<Char> text);

typedef InvokeFunctionNative = Pointer<Char> Function(Pointer<Char> parameters);
typedef InvokeFunctionDart = Pointer<Char> Function(Pointer<Char> parameters);

void main() async {
  final DynamicLibrary dynamicLibrary =
      await FFIUniverse.open(path: "libraryname");

  /// main_function
  {
    final List<String> arguments = ["", "--help", "name"];
    final MainFunctionDart mainFunction = dynamicLibrary
        .lookupFunction<MainFunctionNative, MainFunctionDart>("main");
    mainFunction(arguments.length, arguments.toNativeVectorChar());
  }

  /// test_function
  {
    final String text = "Hello";
    final Pointer<Utf8> textNative = text.toNativeUtf8();
    final TestFunctionDart testFunction = dynamicLibrary
        .lookupFunction<TestFunctionNative, TestFunctionDart>("test");
    testFunction(textNative.cast<Char>());
    malloc.free(textNative);
  }

  /// invoke_function
  {
    final Map<String, dynamic> parameters = {"@type": "getVersion"};
    final Pointer<Utf8> parametersNative =
        json.encode(parameters).toNativeUtf8();
    final InvokeFunctionDart invokeFunction = dynamicLibrary
        .lookupFunction<InvokeFunctionNative, InvokeFunctionDart>("invoke");
    final Pointer<Char> resultInvoke =
        invokeFunction(parametersNative.cast<Char>());
    print(resultInvoke.cast<Utf8>().toDartString());
    malloc.free(parametersNative);
  }

  dynamicLibrary.close();
}
