import 'dart:typed_data';
import 'package:meta/meta.dart';
import 'allocation.dart';
import 'annotations.dart';
import 'modules/module.dart';
import 'types.dart';

/// Represents the native heap.
@extra
class Memory implements Allocator {
  /// The endianess of data stored.
  ///
  /// The WebAssembly speficiation defines little endianess, so this is a constant.
  static const Endian endianess = Endian.little;

  /// The default [Memory] object to use.
  ///
  /// This field is null until it is either manually set to a [Memory] object,
  /// or automatically set by.
  ///
  /// This is most notably used when creating a pointer using [Pointer.fromAddress]
  /// with no explicite memory to bind to given.
  static Memory? global;

  /// Can be used to directly access the memory of this object.
  ///
  /// The value of this field should not be stored in a state variable,
  /// since the returned buffer may change over time.
  @doNotStore
  ByteBuffer get buffer => _module.heap;

  final Module _module;
  final Map<String, WasmSymbol> _symbolsByName;
  final Map<int, WasmSymbol> _symbolsByAddress;

  Memory._(this._module)
    : _symbolsByAddress = Map<int, WasmSymbol>.fromEntries(
        _module.exports.map<MapEntry<int, WasmSymbol>>(
          (WasmSymbol symbol) =>
              MapEntry<int, WasmSymbol>(symbol.address, symbol),
        ),
      ),
      _symbolsByName = Map<String, WasmSymbol>.fromEntries(
        _module.exports.map<MapEntry<String, WasmSymbol>>(
          (WasmSymbol symbol) =>
              MapEntry<String, WasmSymbol>(symbol.name, symbol),
        ),
      );

  @override
  Pointer<T> allocate<T extends NativeType>(int byteCount, {int? alignment}) {
    return Pointer<T>.fromAddress(_module.malloc(byteCount), this);
  }

  @override
  void free(Pointer<NativeType> pointer) {
    _module.free(pointer.address);
  }
}

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
Memory createMemory(Module module) => Memory._(module);

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
WasmSymbol symbolByAddress(Memory m, int address) {
  final WasmSymbol? s = m._symbolsByAddress[address];
  if (s != null) {
    return s;
  } else {
    throw ArgumentError('Could not find symbol at $address!');
  }
}

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
WasmSymbol symbolByName(Memory m, String name) {
  final WasmSymbol? s = m._symbolsByName[name];
  if (s != null) {
    return s;
  } else {
    throw ArgumentError('Could not find symbol $name!');
  }
}
