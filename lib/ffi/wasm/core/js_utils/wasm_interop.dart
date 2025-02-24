@JS()
library;

import 'dart:js_interop';
import 'dart:js_interop_unsafe';
import 'dart:typed_data';

@JS('fetch')
external JSPromise<JSObject> _fetch(JSString resource);

@JS('BigInt')
external JSBigInt _bigInt(JSAny? s);

@JS('Number')
external JSNumber _number(JSAny? obj);

///
extension type WrappedJSAny._(JSAny _) implements JSAny {
  ///
  external static JSArray<JSAny?> keys(JSObject o);

  @JS('toString')
  external JSString _toString();
}

@JS('Object')
///
extension type WrappedJSObject._(JSObject _) implements JSObject {
  ///
  external static JSArray<JSAny?> keys(JSObject o);

  ///
  external static JSArray<JSAny?> entries(JSObject o);
}

@JS()
@anonymous
///
extension type WrappedJSFunction._(JSObject _) implements JSObject {
  ///
  external JSString? get name;

  ///
  external JSNumber? get length;
}

///
extension type JsBigInt(JSBigInt _jsBigInt) implements JSBigInt {
  ///
  factory JsBigInt.parse(String s) => JsBigInt(_bigInt(s.toJS));

  ///
  factory JsBigInt.fromInt(int i) => JsBigInt(_bigInt(i.toJS));

  ///
  factory JsBigInt.fromBigInt(BigInt i) => JsBigInt.parse(i.toString());

  ///
  int get asDartInt => _number(_jsBigInt).toDartInt;

  ///
  BigInt get asDartBigInt => BigInt.parse(jsToString());

  ///
  JSBigInt get jsObject => _jsBigInt;

  ///
  bool get isSafeInteger {
    const maxSafeInteger = 9007199254740992;
    const minSafeInteger = -maxSafeInteger;

    return minSafeInteger.toJS.lessThanOrEqualTo(_jsBigInt).toDart &&
        _jsBigInt.lessThanOrEqualTo(maxSafeInteger.toJS).toDart;
  }

  ///
  Object toDart() {
    return isSafeInteger ? asDartInt : asDartBigInt;
  }

  ///

  String jsToString() {
    return (_jsBigInt as WrappedJSAny)._toString().toDart;
  }
}

@JS('WebAssembly.Memory')
external JSFunction get _memoryConstructor;

@JS('WebAssembly.Table')
external JSFunction get _tableConstructor;

@JS('WebAssembly.Global')
external JSFunction get _globalConstructor;

/// [WasmModule] imports entry.
@JS()
@anonymous
extension type ModuleImportDescriptor._(JSObject _) implements JSObject {
  /// Name of imports module, not to confuse with [WasmModule].
  external String get module;

  /// Name of imports entry.
  external String get name;

  /// Kind of imports entry.
  external String get kind;
}

/// [WasmModule] exports entry.
@JS()
@anonymous
extension type ModuleExportDescriptor._(JSObject _) implements JSObject {
  /// Name of exports entry.
  external String get name;

  /// Kind of imports entry.
  external String get kind;
}

@JS('WebAssembly.Module')
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
extension type WasmModule._(JSObject _) implements JSObject {
  // List<_ModuleExportDescriptor>
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  external static JSArray<ModuleExportDescriptor> exports(WasmModule module);

  // List<_ModuleImportDescriptor>
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  external static JSArray<ModuleImportDescriptor> imports(WasmModule module);

  // List<ByteBuffer>
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  external static JSArray<JSArrayBuffer> customSections(
    WasmModule module,
    JSString sectionName,
  );

  // Named constructor to create module synchronously.
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  external WasmModule.fromBytesOrBuffer(JSObject bytesOrBuffer);
}

@JS('WebAssembly.Instance')
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
extension type WasmInstance._(JSObject _) implements JSObject {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  external JSObject get exports;

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  external WasmInstance(WasmModule module, JSObject imports);
}

extension type _InstantiateResultObject._(JSObject _) implements JSObject {
  external WasmModule get module;
  external WasmInstance get instance;
}

@JS('WebAssembly.instantiate')
external JSPromise<_InstantiateResultObject> _instantiate(
  JSObject bytesOrBuffer,
  JSObject import,
);

@JS('WebAssembly.instantiateStreaming')
external JSPromise<_InstantiateResultObject> _instantiateStreaming(
  JSAny? source,
  JSObject imports,
);

@JS()
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
extension type MemoryDescriptor._(JSObject _) implements JSObject {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  external factory MemoryDescriptor({
    required JSNumber initial,
    JSNumber? maximum,
    JSBoolean? shared,
  });
}

@JS('WebAssembly.Memory')
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
extension type WasmMemory._(JSObject _) implements JSObject {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  external factory WasmMemory(MemoryDescriptor descriptor);

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  external JSArrayBuffer get buffer;

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  static bool isInstance(JSAny? obj) =>
      obj != null && obj.instanceof(_memoryConstructor);
}

@JS()
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
extension type GlobalDescriptor._(JSObject _) implements JSObject {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  external factory GlobalDescriptor({
    required JSString value,
    JSBoolean mutable,
  });
}

@JS('WebAssembly.Global')
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
extension type WasmGlobal._(JSObject _) implements JSObject {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  external factory WasmGlobal(GlobalDescriptor descriptor, JSBoolean mutable);
  external JSNumber value;

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  static bool isInstance(JSAny? obj) =>
      obj != null && obj.instanceof(_globalConstructor);
}

@JS()
/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
extension type TableDescriptor._(JSObject _) implements JSObject {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  external factory TableDescriptor({
    required JSString element,
    required JSNumber initial,
    JSNumber? maximum,
  });
}

@JS('WebAssembly.Table')
///
extension type WasmTable._(JSObject _) implements JSObject {
  ///
  static WasmTable? global;

  ///
  external factory WasmTable(TableDescriptor descriptor, JSObject value);

  ///
  external JSNumber get length;

  ///
  external JSObject get(JSNumber index);

  ///
  external void set(JSNumber index, JSObject value);

  ///
  external JSNumber grow(JSNumber delta);

  ///
  static bool isInstance(JSAny? obj) =>
      obj != null && obj.instanceof(_tableConstructor);
}

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
class Instance {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final WasmModule nativeModule;

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final WasmInstance nativeInstance;

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final Map<String, JSFunction> functions = {};

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final Map<String, WasmGlobal> globals = {};

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final Map<String, WasmMemory> memories = <String, WasmMemory>{};

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final Map<String, WasmTable> tables = <String, WasmTable>{};

  Instance._(this.nativeModule, this.nativeInstance) {
    for (final rawKey in WrappedJSObject.keys(nativeInstance.exports).toDart) {
      final key = (rawKey! as JSString).toDart;
      final value = nativeInstance.exports.getProperty(rawKey);

      if (value == null) {
        // TODO throw StateError('Could not find an export named $key');
        continue;
      }
      if (value is Function) {
        functions[key] = (value as JSFunction);
      } else if (WasmGlobal.isInstance(value)) {
        globals[key] = (value as WasmGlobal);
      } else if (WasmMemory.isInstance(value)) {
        memories[key] = (value as WasmMemory);
      } else if (WasmTable.isInstance(value)) {
        tables[key] = (value as WasmTable);
      }
    }
  }

  static JSObject _createJsImports(Map<String, Map<String, JSAny?>> imports) {
    final importsJs = JSObject();
    imports.forEach((module, moduleImports) {
      final moduleJs = JSObject();
      importsJs[module] = moduleJs;

      moduleImports.forEach((name, value) {
        moduleJs[name] = value;
      });
    });

    return importsJs;
  }

  ///
  static Future<Instance> loadfromUrl(
    String url, {
    Map<String, Map<String, JSAny?>> imports = const {},
  }) async {
    final importsJs = _createJsImports(imports);
    final response = await _fetch(url.toJS).toDart;
    final native = await _instantiateStreaming(response, importsJs).toDart;

    // If the module has an `_initialize` export, it needs to be called to run
    // C constructors and set up memory.
    final exports = native.instance.exports;
    if (exports.has('_initialize')) {
      (exports['_initialize']! as JSFunction).callAsFunction();
    }

    return Instance._(native.module, native.instance);
  }

  /// Loads a WebAssembly module from the given binary data and returns a future
  /// that resolves to an [Instance] object.
  ///
  /// If the module has an `_initialize` export, it needs to be called to run
  /// C constructors and set up memory. This is done automatically if the export
  /// is present in the module.
  ///
  /// The `imports` parameter can be used to specify imports for the module. If
  /// the module imports a module named `module`, and that module has an export
  /// named `export`, the value of `imports[module][export]` will be passed as
  /// the value of that export. The type of the value must match the type of the
  /// export. If the export is a function, the value must be a [JSFunction].
  ///
  /// The returned [Instance] object is used to access the exports of the
  /// module.
  static Future<Instance> loadFromBinary(
    Uint8List wasmBinary, {
    Map<String, Map<String, JSAny?>> imports = const {},
  }) async {
    final importsJs = _createJsImports(imports);

    final native = await _instantiate(wasmBinary.toJS, importsJs).toDart;

    // If the module has an `_initialize` export, it needs to be called to run
    // C constructors and set up memory.
    final exports = native.instance.exports;
    if (exports.has('_initialize')) {
      (exports['_initialize']! as JSFunction).callAsFunction();
    }

    return Instance._(native.module, native.instance);
  }

  /// Sync version of [loadFromBinary].
  ///
  /// This function is sync because it uses the `WasmModule.fromBytesOrBuffer` method
  /// from the `wasm_interop` package, which is sync. This method is only available
  /// in web environments.
  ///
  /// This function is useful if you want to load a wasm binary from a file, or
  /// from a bytes buffer.
  static Instance loadFromBinarySync(
    Uint8List wasmBinary, {
    Map<String, Map<String, JSAny?>> imports = const {},
  }) {
    final importsJs = _createJsImports(imports);
    final module = WasmModule.fromBytesOrBuffer(wasmBinary.toJS);

    final instance = WasmInstance(module, importsJs);
    return Instance._(module, instance);
  }
}
