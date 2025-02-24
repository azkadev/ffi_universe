import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import '../ffi_utils/utf16.dart';
import '../ffi_utils/utf8.dart';
import '../js_utils/inject_js.dart';
import '../js_utils/wasm_interop.dart' as interop;
import 'allocation.dart';
import 'annotations.dart';
import 'marshaller.dart';
import 'memory.dart';
import 'modules/emscripten_module.dart';
import 'modules/module.dart';
import 'modules/standalone_module.dart';
import 'types.dart';

/// An interface for loading module binary.
mixin ModuleLoader {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  Future<bool> exists(String modulePath);

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  Future<Uint8List> load(String modulePath);
}

/// Enum for StandaloneWasmModule and EmscriptenModule
enum WasmType {
  /// The module is loaded from a wasm file
  wasm32Standalone,

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  wasm64Standalone,

  /// The module is loaded using emscripten js
  wasm32Emscripten,

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  wasm64Emscripten,
}

/// Used on [DynamicLibrary] creation to control if the therby newly created
/// [Memory] object should be registered as [Memory.global].
@extra
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
enum GlobalMemory {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  yes,

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  no,

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  ifNotSet,
}

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
class WebModuleLoader implements ModuleLoader {
  @override
  Future<bool> exists(String modulePath) async {
    try {
      final response = await http.head(Uri.parse(modulePath));
      // Check if the response status code indicates success (2xx)
      return response.statusCode >= 200 && response.statusCode < 300;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Uint8List> load(String modulePath) async {
    final response = await http.get(Uri.parse(modulePath));
    if (response.statusCode != 200) {
      throw Exception('Failed to load module: $modulePath');
    }
    return response.bodyBytes;
  }
}

/// Represents a dynamically loaded C library.
class DynamicLibrary {
  final Module _module;
  final Memory _memory;

  /// Access the module object
  @extra
  Module get module => _module;

  /// Default allocator for this library
  @extra
  Allocator get allocator => _memory;

  /// Allocator for this library
  /// @deprecated
  /// Use [allocator]
  @extra
  @Deprecated('Use allocator instead')
  Memory get memory => _memory;

  DynamicLibrary._(this._module, this._memory);

  /// Creates a instance based on the given module.
  ///
  /// While for each [DynamicLibrary] a [Memory] object is
  /// created, the [Memory] objects share the backing memory if
  /// they are created based on the same module.
  ///
  /// The [wasmType] parameter can be used to control if the module should be
  /// loaded as standalone wasm module or as emscripten module.
  ///
  /// The [moduleName] parameter is only used for debugging purposes. It is
  /// needed for the [EmscriptenModule] to find the correct module. It is
  /// ignored for the [StandaloneWasmModule].
  ///
  /// The [useAsGlobal] parameter can be used to control if the
  /// newly created [Memory] object should be registered as [Memory.global].
  /// Loads a library file and provides access to its symbols.
  ///
  /// Calling this function multiple times with the same [path], even across
  /// different isolates, only loads the library into the DartVM process once.
  /// Multiple loads of the same library file produces [DynamicLibrary] objects
  /// which are equal (`==`), but not [identical].
  @different
  static Future<DynamicLibrary> open(String modulePath, {String? moduleName, ModuleLoader? moduleLoader, WasmType? wasmType, GlobalMemory? useAsGlobal}) async {
    /// 64-bit wasm is not supported
    if (wasmType == WasmType.wasm64Standalone || wasmType == WasmType.wasm64Emscripten) {
      throw UnsupportedError('64-bit wasm is not supported');
    }

    moduleLoader ??= WebModuleLoader();

    /// Initialize the native types in marshaller
    initTypes();
    registerOpaqueType<Utf8>(1);
    registerOpaqueType<Utf16>(2);

    final uri = Uri.parse(modulePath);

    // extract the module name from the path if not provided
    moduleName ??= path.basenameWithoutExtension(uri.pathSegments.last);

    // Infer the wasm type
    if (wasmType == null) {
      final ext = path.extension(uri.pathSegments.last);
      if (ext == '.js') {
        wasmType = WasmType.wasm32Emscripten;
      } else if (ext == '.wasm') {
        wasmType = WasmType.wasm32Standalone;
      } else {
        if (await moduleLoader.exists('$modulePath.js')) {
          modulePath = '$modulePath.js';
          wasmType = WasmType.wasm32Emscripten;
        } else if (await moduleLoader.exists('$modulePath.wasm')) {
          modulePath = '$modulePath.wasm';
          wasmType = WasmType.wasm32Standalone;
        } else {
          throw ArgumentError('No wasm or js file found at $modulePath');
        }
      }
    }

    late Module module;
    if (wasmType == WasmType.wasm32Emscripten) {
      await importLibrary(modulePath);
      module = await EmscriptenModule.compile(moduleName);
    } else {
      final wasmBinary = await moduleLoader.load(modulePath);
      module = await StandaloneWasmModule.compile(wasmBinary);
    }

    final Memory memory = createMemory(module);

    switch (useAsGlobal ?? GlobalMemory.ifNotSet) {
      case GlobalMemory.yes:
        Memory.global = memory;
        interop.WasmTable.global = module.indirectFunctionTable;
        break;
      case GlobalMemory.no:
        break;
      case GlobalMemory.ifNotSet:
        Memory.global ??= memory;
        interop.WasmTable.global ??= module.indirectFunctionTable;
        break;
    }

    return DynamicLibrary._(module, memory);
  }

  /// Emtpy stub for [DynamicLibrary.process]
  ///
  /// This is not possible since explicit module is required
  @different
  static DynamicLibrary process() => throw UnimplementedError();

  /// Emtpy stub for [DynamicLibrary.executable]
  ///
  /// This is not possible since explicit module is required
  @different
  static DynamicLibrary executable() => throw UnimplementedError();

  /// Looks up a symbol in the DynamicLibrary and returns its address in memory.
  ///
  /// Throws an [ArgumentError] if it fails to lookup the symbol.
  ///
  /// While this method checks if the underyling wasm symbol is a actually
  /// a function when you lookup a [NativeFunction]`<T>`, it does not check if
  /// the return type and parameters of `T` match the wasm function.
  Pointer<T> lookup<T extends NativeType>(String name) => _module.lookup(name, _memory);

  /// Checks whether this dynamic library provides a symbol with the given
  /// name.
  bool providesSymbol(String symbolName) => _module.providesSymbol(symbolName);

  /// Closes this dynamic library.
  ///
  /// After calling [close], this library object can no longer be used for
  /// lookups. Further, this information is forwarded to the operating system,
  /// which may unload the library if there are no remaining references to it
  /// in the current process.
  ///
  /// Depending on whether another reference to this library has been opened,
  /// pointers and functions previously returned by [lookup] and
  /// [DynamicLibraryExtension.lookupFunction] may become invalid as well.
  void close() => throw UnimplementedError();

  /// Helper that combines lookup and cast to a Dart function.
  ///
  /// This simply calls [DynamicLibrary.lookup] and [NativeFunctionPointer.asFunction]
  /// internally, so see this two methods for additional insights.
  F lookupFunction<T extends Function, F extends Function>(String name) => _module.lookupFunction(name, _memory);
}
