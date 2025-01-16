import 'dart:js_interop';
import 'dart:typed_data';

import '../../js_utils/wasm_interop.dart';
import '../annotations.dart';
import '../memory.dart';
import '../type_utils.dart';
import '../types.dart';
import 'module.dart';

@extra
class StandaloneWasmModule extends Module {
  final Instance _instance;
  final List<WasmSymbol> _exports = [];

  @override
  List<WasmSymbol> get exports => _exports;

  static Future<StandaloneWasmModule> compile(Uint8List wasmBinary) async {
    final wasmInstance = await Instance.loadFromBinary(wasmBinary);
    return StandaloneWasmModule._(wasmInstance);
  }

  FunctionDescription _fromWasmFunction(
      String name, JSFunction func, int index) {
    final funcDesc = func as WrappedJSFunction;

    if (funcDesc.name != null) {
      final length = funcDesc.length;
      if (length != null) {
        return FunctionDescription(
            tableIndex: index,
            name: name,
            function: func,
            argumentCount: length.toDartInt);
      }
    }
    throw ArgumentError('$name does not seem to be a function symbol!');
  }

  StandaloneWasmModule._(this._instance) {
    int index = 0;
    for (final e in _instance.functions.entries) {
      _exports.add(_fromWasmFunction(e.key, e.value, index++));
    }
  }

  @override
  void free(int pointer) {
    final func = _instance.functions['free'];
    if (func is Function) {
      (func! as Function).call(pointer);
    }
  }

  @override
  ByteBuffer get heap => _instance.memories['memory']!.buffer.toDart;

  @override
  WasmTable? get indirectFunctionTable =>
      _instance.tables['__indirect_function_table'];

  @override
  int malloc(int size) {
    final func = _instance.functions['malloc'];
    if (func is Function) {
      final resp = (func! as Function).call(size) as int;
      return resp;
    }
    return -1;
  }

  /// Looks up a symbol in the DynamicLibrary and returns its address in memory.
  ///
  /// Throws an [ArgumentError] if it fails to lookup the symbol.
  ///
  /// While this method checks if the underyling wasm symbol is a actually
  /// a function when you lookup a [NativeFunction]`<T>`, it does not check if
  /// the return type and parameters of `T` match the wasm function.
  @override
  Pointer<T> lookup<T extends NativeType>(String name, Memory memory) {
    final WasmSymbol symbol = symbolByName(memory, name);
    if (isNativeFunctionType<T>()) {
      if (symbol is FunctionDescription) {
        return Pointer<T>.fromAddress(symbol.tableIndex, memory);
      } else {
        throw ArgumentError(
            'Tried to look up $name as a function, but it seems it is NOT a function!');
      }
    } else {
      return Pointer<T>.fromAddress(symbol.address, memory);
    }
  }

  /// Checks whether this dynamic library provides a symbol with the given
  /// name.
  @override
  bool providesSymbol(String symbolName) => throw UnimplementedError();

  @override
  F lookupFunction<T extends Function, F extends Function>(
      String name, Memory memory) {
    return _instance.functions[name]! as F;
  }
}
