import 'dart:typed_data';
import 'annotations.dart';
import 'exceptions.dart';
import 'marshaller.dart';
import 'memory.dart';
import 'modules/module.dart';
import 'native_finalizer.dart';
import 'types.dart';

/// Extension on [Pointer] specialized for the type argument [NativeFunction].
extension NativeFunctionPointer<NF extends Function>
    on Pointer<NativeFunction<NF>> {
  /// Convert to Dart function, automatically marshalling the arguments and return value.
  ///
  /// There are several rules that apply for the return type of `DF`, see
  /// the list of [allowed return types](https://github.com/vm75/wasm_ffi/blob/main/return_types.md).
  /// If marshalling fails, a [MarshallingException] is thrown.
  ///
  /// If this is called on a pointer that does not point to a function,
  /// a [ArgumentError](https://api.dart.dev/stable/dart-core/ArgumentError-class.html) is thrown.
  DF asFunction<DF extends Function>() {
    // ignore: prefer_final_locals
    WasmSymbol symbol = symbolByAddress(boundMemory, address);
    if (symbol is FunctionDescription && symbol.function is Function) {
      return marshall<NF, DF>(symbol.function as Function, boundMemory);
    } else {
      throw ArgumentError(
          'No function at address $address was found (but a global symbol)!');
    }
  }
}

/// Extension on [Pointer] specialized for the type argument [Float].
extension FloatPointer on Pointer<Float> {
  /// The float at address.
  double get value => this[0];
  set value(double value) => this[0] = value;

  /// Creates a typed list view backed by memory in the address space.
  ///
  /// The returned view will allow access to the memory range
  /// from address to `address + size * length`.
  Float32List asTypedList(int length) =>
      boundMemory.buffer.asFloat32List(address, length);

  /// The float at `address + size * index`.
  double operator [](int index) =>
      viewSingle(index).getFloat32(0, Memory.endianess);

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  void operator []=(int index, double value) =>
      viewSingle(index).setFloat32(0, value, Memory.endianess);
}

/// Extension on [Pointer] specialized for the type argument [Double].
extension DoublePointer on Pointer<Double> {
  /// The double at address.
  double get value => this[0];
  set value(double value) => this[0] = value;

  /// Creates a typed list view backed by memory in the address space.
  ///
  /// The returned view will allow access to the memory range
  /// from address to `address + size * length`.
  Float64List asTypedList(int length) =>
      boundMemory.buffer.asFloat64List(address, length);

  /// The double at `address + size * index`.
  double operator [](int index) =>
      viewSingle(index).getFloat64(0, Memory.endianess);

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  void operator []=(int index, double value) =>
      viewSingle(index).setFloat64(0, value, Memory.endianess);
}

/// Extension on [Pointer] specialized for the type argument [Int8].
extension Int8Pointer on Pointer<Int8> {
  /// The 8-bit integer at `address`.
  int get value => this[0];
  set value(int value) => this[0] = value;

  /// Creates a typed list view backed by memory in the address space.
  ///
  /// The returned view will allow access to the memory range
  /// from address to `address + size * length`.
  Int8List asTypedList(int length) =>
      boundMemory.buffer.asInt8List(address, length);

  /// The 8-bit integer at `address + size * index`.
  int operator [](int index) => viewSingle(index).getInt8(0);

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  void operator []=(int index, int value) =>
      viewSingle(index).setInt8(0, value);
}

/// Extension on [Pointer] specialized for the type argument [Int16].
extension Int16Pointer on Pointer<Int16> {
  /// The 16-bit integer at `address`.
  int get value => this[0];
  set value(int value) => this[0] = value;

  /// Creates a typed list view backed by memory in the address space.
  ///
  /// The returned view will allow access to the memory range
  /// from address to `address + size * length`.
  Int16List asTypedList(int length) =>
      boundMemory.buffer.asInt16List(address, length);

  /// The 16-bit integer at `address + size * index`.
  int operator [](int index) => viewSingle(index).getInt16(0, Memory.endianess);

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  void operator []=(int index, int value) =>
      viewSingle(index).setInt16(0, value, Memory.endianess);
}

/// Extension on [Pointer] specialized for the type argument [Int32].
extension Int32Pointer on Pointer<Int32> {
  /// The 32-bit integer at `address`.
  int get value => this[0];
  set value(int value) => this[0] = value;

  /// Creates a typed list view backed by memory in the address space.
  ///
  /// The returned view will allow access to the memory range
  /// from address to `address + size * length`.
  Int32List asTypedList(int length) =>
      boundMemory.buffer.asInt32List(address, length);

  /// The 32-bit integer at `address + size * index`.
  int operator [](int index) => viewSingle(index).getInt32(0, Memory.endianess);

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  void operator []=(int index, int value) =>
      viewSingle(index).setInt32(0, value, Memory.endianess);
}

/// Extension on [Pointer] specialized for the type argument [Int64].
extension Int64Pointer on Pointer<Int64> {
  /// The 64-bit integer at `address`.
  int get value => this[0];
  set value(int value) => this[0] = value;

  /// Creates a typed list view backed by memory in the address space.
  ///
  /// The returned view will allow access to the memory range
  /// from address to `address + size * length`.
  Int64List asTypedList(int length) =>
      boundMemory.buffer.asInt64List(address, length);

  /// The 64-bit integer at `address + size * index`.
  int operator [](int index) => viewSingle(index).getInt64(0, Memory.endianess);

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  void operator []=(int index, int value) =>
      viewSingle(index).setInt64(0, value, Memory.endianess);
}

/// Extension on [Pointer] specialized for the type argument [Uint8].
extension Uint8Pointer on Pointer<Uint8> {
  /// The 8-bit unsigned integer at `address`.
  int get value => this[0];
  set value(int value) => this[0] = value;

  /// Creates a typed list view backed by memory in the address space.
  ///
  /// The returned view will allow access to the memory range
  /// from address to `address + size * length`.
  Uint8List asTypedList(int length) =>
      boundMemory.buffer.asUint8List(address, length);

  /// The 8-bit unsigned integer at `address + size * index`.
  int operator [](int index) => viewSingle(index).getUint8(0);

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  void operator []=(int index, int value) =>
      viewSingle(index).setUint8(0, value);
}

/// Extension on [Pointer] specialized for the type argument [Uint16].
extension Uint16Pointer on Pointer<Uint16> {
  /// The 16-bit unsigned integer at `address`.
  int get value => this[0];
  set value(int value) => this[0] = value;

  /// Creates a typed list view backed by memory in the address space.
  ///
  /// The returned view will allow access to the memory range
  /// from address to `address + size * length`.
  Uint16List asTypedList(int length) =>
      boundMemory.buffer.asUint16List(address, length);

  /// The 16-bit unsigned integer at `address + size * index`.
  int operator [](int index) =>
      viewSingle(index).getUint16(0, Memory.endianess);

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  void operator []=(int index, int value) =>
      viewSingle(index).setUint16(0, value, Memory.endianess);

  /// Pointer arithmetic (takes element size into account).
  @Deprecated('Use operator + instead')
  Pointer<Uint16> elementAt(int index) =>
      Pointer.fromAddress(address + sizeOf<Uint16>() * index);

  /// A pointer to the [offset]th [Uint16] after this one.
  ///
  /// Returns a pointer to the [Uint16] whose address is
  /// [offset] times the size of `Uint16` after the address of this pointer.
  /// That is `(this + offset).address == this.address + offset * sizeOf<Uint16>()`.
  ///
  /// Also `(this + offset).value` is equivalent to `this[offset]`,
  /// and similarly for setting.
  // @Since('3.3')
  @pragma("vm:prefer-inline")
  Pointer<Uint16> operator +(int offset) =>
      Pointer.fromAddress(address + sizeOf<Uint16>() * offset);

  /// A pointer to the [offset]th [Uint16] before this one.
  ///
  /// Equivalent to `this + (-offset)`.
  ///
  /// Returns a pointer to the [Uint16] whose address is
  /// [offset] times the size of `Uint16` before the address of this pointer.
  /// That is, `(this - offset).address == this.address - offset * sizeOf<Uint16>()`.
  ///
  /// Also, `(this - offset).value` is equivalent to `this[-offset]`,
  /// and similarly for setting,
  // @Since('3.3')
  @pragma("vm:prefer-inline")
  Pointer<Uint16> operator -(int offset) =>
      Pointer.fromAddress(address - sizeOf<Uint16>() * offset);
}

/// Extension on [Pointer] specialized for the type argument [Uint32].
extension Uint32Pointer on Pointer<Uint32> {
  /// The 32-bit unsigned integer at `address`.
  int get value => this[0];
  set value(int value) => this[0] = value;

  /// Creates a typed list view backed by memory in the address space.
  ///
  /// The returned view will allow access to the memory range
  /// from address to `address + size * length`.
  Uint32List asTypedList(int length) =>
      boundMemory.buffer.asUint32List(address, length);

  /// The 32-bit unsigned integer at `address + size * index`.
  int operator [](int index) =>
      viewSingle(index).getUint32(0, Memory.endianess);

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  void operator []=(int index, int value) =>
      viewSingle(index).setUint32(0, value, Memory.endianess);
}

/// Extension on [Pointer] specialized for the type argument [Uint64].
extension Uint64Pointer on Pointer<Uint64> {
  /// The 64-bit unsigned integer at `address`.
  int get value => this[0];
  set value(int value) => this[0] = value;

  /// Creates a typed list view backed by memory in the address space.
  ///
  /// The returned view will allow access to the memory range
  /// from address to `address + size * length`.
  Uint64List asTypedList(int length) =>
      boundMemory.buffer.asUint64List(address, length);

  /// The 64-bit unsigned integer at `address + size * index`.
  int operator [](int index) =>
      viewSingle(index).getUint64(0, Memory.endianess);

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  void operator []=(int index, int value) =>
      viewSingle(index).setUint64(0, value, Memory.endianess);
}

/// Extension on [Pointer] specialized for the type argument [IntPtr].
extension IntPtrPointer on Pointer<IntPtr> {
  /// The 32-bit or 64-bit value at `address`.
  int get value => this[0];
  set value(int value) => this[0] = value;

  /// Returns `true` if the size of a pointer is 64-bit, `false` otherwise.
  @extra
  bool get is64Bit => size == 8;

  /// The 32-bit or 64-bit integer at `address + size * index`.
  int operator [](int index) => is64Bit
      ? viewSingle(index).getUint64(0, Memory.endianess)
      : viewSingle(index).getUint32(0, Memory.endianess);

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  void operator []=(int index, int value) => is64Bit
      ? viewSingle(index).setUint64(0, value, Memory.endianess)
      : viewSingle(index).setUint32(0, value, Memory.endianess);
}

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
/// not_real_implemented
extension AbiSpecificIntegerPointer<T extends AbiSpecificInteger>
    on Pointer<T> {
  /// The integer at [address].
  int get value => this[0];

  set value(int value) {
    this[0] = value;
  }

  /// The integer at `address + sizeOf\<T\>() * index`.
  int operator [](int index) {
    return index;
  }

  /// The integer at `address + sizeOf\<T\>() * index`.
  void operator []=(int index, int value) {}

  /// Pointer arithmetic (takes element size into account).
  @Deprecated('Use operator + instead')
  Pointer<T> elementAt(int index) {
    return this.elementAt(index);
  }

  /// A pointer to the [offset]th [T] after this one.
  ///
  /// Returns a pointer to the [T] whose address is
  /// [offset] times the size of `T` after the address of this pointer.
  /// That is `(this + offset).address == this.address + offset * sizeOf\<T\>()`.
  ///
  /// Also `(this + offset).value` is equivalent to `this[offset]`,
  /// and similarly for setting.
  Pointer<T> operator +(int offset) {
    return this.elementAt(offset);
  }

  /// A pointer to the [offset]th [T] before this one.
  ///
  /// Equivalent to `this + (-offset)`.
  ///
  /// Returns a pointer to the [T] whose address is
  /// [offset] times the size of `T` before the address of this pointer.
  /// That is, `(this - offset).address == this.address - offset * sizeOf\<T\>()`.
  ///
  /// Also, `(this - offset).value` is equivalent to `this[-offset]`,
  /// and similarly for setting,
  Pointer<T> operator -(int offset) {
    return this.elementAt(offset);
  }
}

/// Extension on [Pointer] specialized for the type argument [Pointer].
extension PointerPointer<T extends NativeType> on Pointer<Pointer<T>> {
  /// The pointer at `address`.
  Pointer<T> get value => this[0];

  set value(Pointer<T> value) => this[0] = value;

  /// Returns `true` if the size of a pointer is 64-bit, `false` otherwise.
  @extra
  bool get is64Bit => size == 8;

  /// The pointer at `address + size * index`.
  Pointer<T> operator [](int index) => Pointer<T>.fromAddress(
      is64Bit
          ? viewSingle(index).getUint64(0, Memory.endianess)
          : viewSingle(index).getUint32(0, Memory.endianess),
      boundMemory);

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  void operator []=(int index, Pointer<T> value) => is64Bit
      ? viewSingle(index).setUint64(0, value.address, Memory.endianess)
      : viewSingle(index).setUint32(0, value.address, Memory.endianess);

  /// Pointer arithmetic (takes element size into account).
  @Deprecated('Use operator + instead')
  Pointer<Pointer<T>> elementAt(int index) {
    throw UnimplementedError();
  }

  /// A pointer to the [offset]th [Pointer<T>] after this one.
  ///
  /// Returns a pointer to the [Pointer<T>] whose address is
  /// [offset] times the size of `Pointer<T>` after the address of this pointer.
  /// That is `(this + offset).address == this.address + offset * sizeOf<Pointer<T>>()`.
  ///
  /// Also `(this + offset).value` is equivalent to `this[offset]`,
  /// and similarly for setting.
  Pointer<Pointer<T>> operator +(int offset) {
    throw UnimplementedError();
  }

  /// A pointer to the [offset]th [Pointer<T>] before this one.
  ///
  /// Equivalent to `this + (-offset)`.
  ///
  /// Returns a pointer to the [Pointer<T>] whose address is
  /// [offset] times the size of `Pointer<T>` before the address of this pointer.
  /// That is, `(this - offset).address == this.address - offset * sizeOf<Pointer<T>>()`.
  ///
  /// Also, `(this - offset).value` is equivalent to `this[-offset]`,
  /// and similarly for setting,
  Pointer<Pointer<T>> operator -(int offset) {
    throw UnimplementedError();
  }
}

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
extension StructPointer<T extends Struct> on Pointer<T> {
  /// A Dart view of the struct referenced by this pointer.
  ///
  /// Reading [ref] creates a reference accessing the fields of this struct
  /// backed by native memory at [address].
  /// The [address] must be aligned according to the struct alignment rules of
  /// the platform.
  ///
  /// Assigning to [ref] copies contents of the struct into the native memory
  /// starting at [address].
  ///
  /// This extension method must be invoked on a receiver of type `Pointer<T>`
  /// where `T` is a compile-time constant type.
  T get ref => throw UnimplementedError();
  set ref(T value) {
    throw UnimplementedError();
  }

  /// A Dart view of the struct referenced by this pointer.
  ///
  /// Creates a reference accessing the fields of this struct backed by native
  /// memory at [address].
  /// The [address] must be aligned according to the struct alignment rules of
  /// the platform.
  ///
  /// Attaches [finalizer] to the backing store of the struct. If provided,
  /// [token] will be passed to [finalizer], otherwise the pointer (`this`)
  /// itself will be passed.
  /// The pointer (`this`) must _not_ be used anymore if the struct is _not_
  /// guaranteed to be kept alive.
  /// Prefer doing any native calls with the pointer _before_ calling
  /// [refWithFinalizer].
  ///
  /// This extension method must be invoked on a receiver of type `Pointer<T>`
  /// where `T` is a compile-time constant type.
  // @Since('3.7')
  T refWithFinalizer(Pointer<NativeFinalizerFunction> finalizer,
      {Pointer<Void>? token}) {
    throw UnimplementedError();
  }

  /// Creates a reference to access the fields of this struct backed by native
  /// memory at `address + sizeOf<T>() * index`.
  ///
  /// The [address] must be aligned according to the struct alignment rules of
  /// the platform.
  ///
  /// This extension method must be invoked on a receiver of type `Pointer<T>`
  /// where `T` is a compile-time constant type.
  T operator [](int index) {
    throw UnimplementedError();
  }

  /// Copies the [value] struct into native memory, starting at
  /// `address * sizeOf<T>() * index`.
  ///
  /// This extension method must be invoked on a receiver of type `Pointer<T>`
  /// where `T` is a compile-time constant type.
  void operator []=(int index, T value) {
    throw UnimplementedError();
  }

  /// Pointer arithmetic (takes element size into account)
  @Deprecated('Use operator + instead')
  Pointer<T> elementAt(int index) {
    throw UnimplementedError();
  }

  /// A pointer to the [offset]th [T] after this one.
  ///
  /// Returns a pointer to the [T] whose address is
  /// [offset] times the size of `T` after the address of this pointer.
  /// That is `(this + offset).address == this.address + offset * sizeOf<T>()`.
  ///
  /// Also `(this + offset).value` is equivalent to `this[offset]`,
  /// and similarly for setting.
  Pointer<T> operator +(int offset) {
    throw UnimplementedError();
  }

  /// A pointer to the [offset]th [T] before this one.
  ///
  /// Equivalent to `this + (-offset)`.
  ///
  /// Returns a pointer to the [T] whose address is
  /// [offset] times the size of `T` before the address of this pointer.
  /// That is, `(this - offset).address == this.address - offset * sizeOf<T>()`.
  ///
  /// Also, `(this - offset).value` is equivalent to `this[-offset]`,
  /// and similarly for setting,
  Pointer<T> operator -(int offset) {
    throw UnimplementedError();
  }
}

/// Extension on [Pointer] specialized for the type argument [Bool].
// @Since('2.15')
extension BoolPointer on Pointer<Bool> {
  /// The bool at [address].
  bool get value {
    throw UnimplementedError();
  }

  set value(bool value) {
    throw UnimplementedError();
  }

  /// The bool at `address + sizeOf<Bool>() * index`.
  bool operator [](int index) {
    throw UnimplementedError();
  }

  /// The bool at `address + sizeOf<Bool>() * index`.
  void operator []=(int index, bool value) {
    throw UnimplementedError();
  }

  /// Pointer arithmetic (takes element size into account).
  @Deprecated('Use operator + instead')
  Pointer<Bool> elementAt(int index) =>
      Pointer.fromAddress(address + sizeOf<Bool>() * index);

  /// A pointer to the [offset]th [Bool] after this one.
  ///
  /// Returns a pointer to the [Bool] whose address is
  /// [offset] times the size of `Bool` after the address of this pointer.
  /// That is `(this + offset).address == this.address + offset * sizeOf<Bool>()`.
  ///
  /// Also `(this + offset).value` is equivalent to `this[offset]`,
  /// and similarly for setting.
  // @Since('3.3')
  @pragma("vm:prefer-inline")
  Pointer<Bool> operator +(int offset) =>
      Pointer.fromAddress(address + sizeOf<Bool>() * offset);

  /// A pointer to the [offset]th [Bool] before this one.
  ///
  /// Equivalent to `this + (-offset)`.
  ///
  /// Returns a pointer to the [Bool] whose address is
  /// [offset] times the size of `Bool` before the address of this pointer.
  /// That is, `(this - offset).address == this.address - offset * sizeOf<Bool>()`.
  ///
  /// Also, `(this - offset).value` is equivalent to `this[-offset]`,
  /// and similarly for setting,
  // @Since('3.3')
  @pragma("vm:prefer-inline")
  Pointer<Bool> operator -(int offset) =>
      Pointer.fromAddress(address - sizeOf<Bool>() * offset);
}
