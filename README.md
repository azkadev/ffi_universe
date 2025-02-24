# FFI UNIVERSE
 
**FFI UNIVERSE** Standarization FFI will bring support cross platform same style api for boost project

[![](https://raw.githubusercontent.com/globalcorporation/.github/main/.github/logo/powered.png)](https://www.youtube.com/@Global_Corporation)

**Copyright (c) 2024 GLOBAL CORPORATION - GENERAL DEVELOPER**

## 📚️ Docs

1. [Documentation](https://youtube.com/@GENERAL_DEV)
2. [Youtube](https://youtube.com/@GENERAL_DEV)
3. [Telegram Support Group](https://t.me/DEVELOPER_GLOBAL_PUBLIC)
4. [Contact Developer](https://github.com/General-Developer) (check social media or readme profile github)

## 🔖️ Features

1. [x] 📱️ **Cross Platform** support (Device, Edge Severless functions)
2. [x] 📜️ **Standarization** Style Code
3. [x] ⌨️ **Cli** (Terminal for help you use this library or create project)
4. [x] 🔥️ **Api** (If you developer bot / userbot you can use this library without interact cli just add library and use 🚀️)
5. [x] 🧩️ **Customizable Extension** (if you want add extension so you can more speed up on development)
6. [x] ✨️ **Pretty Information** (user friendly for newbie)
 
## ❔️ Fun Fact

- **This library 100%** use on every my create project (**App, Server, Bot, Userbot**)
 
## 📈️ Proggres
 
- **10-02-2025**
  Starting **Release Stable** With core Features

### 📥️ Install Library

1. **Dart**

```bash
dart pub add ffi_universe
```

## 🚀️ Quick Start

Example Quickstart script minimal for insight you or make you use this library because very simple

```dart
import 'dart:convert';
import 'package:ffi_universe/ffi_universe.dart';

typedef MainFunctionNative = Int Function(Int argc, Pointer<Pointer<Char>> argv);
typedef MainFunctionDart = int Function(int argc, Pointer<Pointer<Char>> argv);

typedef TestFunctionNative = Void Function(Pointer<Char> text);
typedef TestFunctionDart = void Function(Pointer<Char> text);

typedef InvokeFunctionNative = Pointer<Char> Function(Pointer<Char> parameters);
typedef InvokeFunctionDart = Pointer<Char> Function(Pointer<Char> parameters);

void main() async {
  final DynamicLibrary dynamicLibrary = await FFIUniverse.open(
    path: "libraryname",
  );

  /// main_function
  {
    final List<String> arguments = [
      "",
      "--help",
      "name",
    ];
    final MainFunctionDart mainFunction = dynamicLibrary.lookupFunction<MainFunctionNative, MainFunctionDart>("main");
    mainFunction(arguments.length, arguments.toNativeVectorChar());
  }

  /// test_function
  {
    final String text = "Hello";
    final Pointer<Utf8> textNative = text.toNativeUtf8();
    final TestFunctionDart testFunction = dynamicLibrary.lookupFunction<TestFunctionNative, TestFunctionDart>("test");
    testFunction(textNative.cast<Char>());
    malloc.free(textNative);
  }

  /// invoke_function
  {
    final Map<String, dynamic> parameters = {
      "@type": "getVersion",
    };
    final Pointer<Utf8> parametersNative = json.encode(parameters).toNativeUtf8();
    final InvokeFunctionDart invokeFunction = dynamicLibrary.lookupFunction<InvokeFunctionNative, InvokeFunctionDart>("invoke");
    final Pointer<Char> resultInvoke = invokeFunction(parametersNative.cast<Char>());
    print(resultInvoke.cast<Utf8>().toDartString());
    malloc.free(parametersNative);
  }

  dynamicLibrary.close();
}

```

**Copyright (c) 2024 GLOBAL CORPORATION - GENERAL DEVELOPER**