// ignore_for_file: prefer_initializing_formals

import 'dart:developer' as developer;
import 'dart:js_interop';
import 'dart:typed_data';
// import 'package:ffi_universe/ffi/wasm/wasm.dart';
import 'package:meta/meta.dart';
import '../ffi_utils/utf8.dart';
import '../js_utils/wasm_interop.dart';
import 'abi.dart';
import 'allocation.dart';
import 'annotations.dart';
import 'marshaller.dart';
import 'memory.dart';
import 'null_memory.dart';
import 'type_utils.dart';
export 'marshaller.dart' show initTypes, sizeOf;

/// Represents a pointer into the native C memory corresponding to "NULL",
/// e.g. a pointer with address 0.
///
/// You can compare any other pointer with this pointer using == to check
/// if it's also an nullpointer.
///
/// Any other operation than comparing (e.g. calling [Pointer.cast])
/// will result in exceptions.
final Pointer<Never> nullptr = Pointer<Never>._null();

bool _isUnsizedType<T extends NativeType>() {
  return isNativeFunctionType<T>() || isVoidType<T>();
}

/// [NativeType]'s subtypes represent a native type in C.
///
/// [NativeType]'s subtypes (except [Pointer]) are not constructible
/// in the Dart code and serve purely as markers in type signatures.
@sealed
@notConstructible
// class NativeType {}
abstract final class NativeType {}

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
abstract final class SizedNativeType implements NativeType {}

abstract final class _NativeDouble implements SizedNativeType {}

/// Represents a native 64 bit double in C.
///
/// Double is not constructible in the Dart code and serves
/// purely as marker in type signatures.
@sealed
@notConstructible
final class Double implements _NativeDouble {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const Double();
}

/// Represents a native 32 bit float in C.
///
/// Float is not constructible in the Dart code and serves
/// purely as marker in type signatures.
@sealed
@notConstructible
final class Float implements _NativeDouble {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const Float();
}

/// The C `int` type.
///
/// Int is not constructible in the Dart code and serves
/// purely as marker in type signatures.
@sealed
@notConstructible
final class Int extends AbiSpecificInteger {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const Int();
}

/// Represents a native signed 8 bit integer in C.
///
/// Int8 is not constructible in the Dart code and serves
/// purely as marker in type signatures.
@sealed
@notConstructible
final class Int8 extends NativeType {}

/// Represents a native signed 16 bit integer in C.
///
/// Int16 is not constructible in the Dart code and serves
/// purely as marker in type signatures.
@sealed
@notConstructible
final class Int16 extends NativeType {}

abstract final class _NativeInteger implements SizedNativeType {}

/// Represents a native signed 32 bit integer in C.
///
/// Int32 is not constructible in the Dart code and serves
/// purely as marker in type signatures.
@sealed
@notConstructible
// final class Int32 extends NativeType {}
//
final class Int32 implements _NativeInteger {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const Int32();
}

/// Represents a native signed 64 bit integer in C.
///
/// Int64 is not constructible in the Dart code and serves
/// purely as marker in type signatures.
@sealed
@notConstructible
final class Int64 implements _NativeInteger {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const Int64();
}

/// The C `unsigned int` type.
///
/// Int is not constructible in the Dart code and serves
/// purely as marker in type signatures.
@sealed
@notConstructible
final class UnsignedInt extends AbiSpecificInteger {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const UnsignedInt();
}

/// The C `unsigned int` type.
///
/// Int is not constructible in the Dart code and serves
/// purely as marker in type signatures.
@sealed
@notConstructible
final class Long extends AbiSpecificInteger {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const Long();
}

/// Represents a native unsigned 8 bit integer in C.
///
/// Uint8 is not constructible in the Dart code and serves
/// purely as marker in type signatures.
@sealed
@notConstructible
final class Uint8 extends NativeType {}

/// Represents a native unsigned 16 bit integer in C.
///
/// Uint16 is not constructible in the Dart code and serves
/// purely as marker in type signatures.
@sealed
@notConstructible
// final class Uint16 extends NativeType {}
final class Uint16 implements _NativeInteger {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const Uint16();
}

/// Represents a native unsigned 32 bit integer in C.
///
/// Uint32 is not constructible in the Dart code and serves
/// purely as marker in type signatures.
@sealed
@notConstructible
final class Uint32 implements _NativeInteger {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const Uint32();
}

/// Represents a native unsigned 64 bit integer in C.
///
/// Uint64 is not constructible in the Dart code and serves
/// purely as marker in type signatures.
@sealed
@notConstructible
final class Uint64 extends NativeType {}

/// Represents a native pointer-sized integer in C.
///
/// IntPtr is not constructible in the Dart code and serves
/// purely as marker in type signatures.
@sealed
@notConstructible
final class IntPtr extends NativeType {}

/// Represents a native pointer-sized unsigned integer in C.
///
/// IntPtr is not constructible in the Dart code and serves
/// purely as marker in type signatures.
@sealed
@notConstructible
final class UintPtr extends NativeType {}

/// Represents a native bool in C.
///
/// Bool is not constructible in the Dart code and serves
/// purely as marker in type signatures.
@sealed
@notConstructible
final class Bool implements SizedNativeType {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const Bool();
}

/// Represents a function type in C.
///
/// NativeFunction is not constructible in the Dart code and serves
/// purely as marker in type signatures.
@sealed
@notConstructible
@unsized
final class NativeFunction<T extends Function> extends NativeType {}

/// Opaque's subtypes represent opaque types in C.
///
/// Classes that extend Opaque MUST NOT have a type argument!
///
/// Opaque's subtypes are not constructible in the Dart code and serve
/// purely as markers in type signatures.
@noGeneric
@notConstructible
// class Opaque extends NativeType {}
abstract base class Opaque implements NativeType {}

/// Represents a void type in C.
///
/// Void is not constructible in the Dart code and serves
/// purely as marker in type signatures.
@sealed
@notConstructible
@unsized
final class Void extends NativeType {}

/// Represents a Size type in C.
///
/// Size is not constructible in the Dart code and serves
/// purely as marker in type signatures.
@sealed
@notConstructible
@unsized
final class Size extends AbiSpecificInteger {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const Size();
}

/// Miscellaneous types, defined as alias
typedef Char = Int8;

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
// typedef UnsignedChar = Uint8;

final class SignedChar extends AbiSpecificInteger {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const SignedChar();
}

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
typedef Short = Int16;

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
// typedef UnsignedShort = Uint16;
//

final class UnsignedShort extends AbiSpecificInteger {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const UnsignedShort();
}

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
// typedef Long = Int32;

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
typedef UnsignedLong = Uint32;

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
typedef LongLong = Int64;

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
typedef UnsignedLongLong = Uint64;

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
typedef WChar = Int32;

/// Represents a pointer into the native C memory. Cannot be extended.
@sealed
final class Pointer<T extends NativeType> extends NativeType {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  static Pointer<NativeFunction<T>> fromFunction<T extends Function>(
    Function f, [
    Object? exceptionalReturn,
    Memory? bindToMemory,
    WasmTable? bindToTable,
  ]) {
    final Memory? memory = bindToMemory ?? Memory.global;
    final WasmTable? table = bindToTable ?? WasmTable.global;
    return pointerFromFunctionImpl(f, table!, memory!);
  }

  /// Access to the raw pointer value.
  final int address;

  /// The [Memory] object this pointer is bound to.
  ///
  /// The `Memory` object backs this pointer, if the value of
  /// this pointer is accessed.
  @extra
  final Memory boundMemory;

  /// How much memory in bytes the type this pointer points to occupies,
  /// or `null` for @[unsized] types.
  @extra
  final int? size;

  factory Pointer._null() {
    return Pointer._(0, NullMemory(), null);
  }

  /// Constructs a pointer from an address.
  ///
  /// The optional parameter `bindTo` can be ommited, if and only if
  /// [Memory.global] is set, which is then used as `Memory` to bind to.
  factory Pointer.fromAddress(int ptr, [Memory? bindTo]) {
    final Memory? memory = bindTo ?? Memory.global;
    if (memory == null) {
      throw StateError(
        'No global memory set and no explcity memory to bind to given!',
      );
    }
    return Pointer._(ptr, memory, _isUnsizedType<T>() ? null : sizeOf<T>());
  }

  Pointer._(this.address, this.boundMemory, this.size);

  /// Casts this pointer to an other type.
  Pointer<U> cast<U extends NativeType>() => Pointer<U>._(
    address,
    boundMemory,
    _isUnsizedType<U>() ? null : sizeOf<U>(),
  );

  /// Pointer arithmetic (takes element size into account).
  ///
  /// Throws an [UnsupportedError] if called on a pointer with an @[unsized]
  /// type argument.
  Pointer<T> elementAt(int index) {
    final int? s = size;
    if (s != null) {
      return Pointer<T>._(address + index * s, boundMemory, s);
    } else {
      throw UnsupportedError('elementAt is not supported for unsized types!');
    }
  }

  /// The hash code for a Pointer only depends on its address.
  @override
  int get hashCode => address;

  /// Two pointers are equal if their address is the same, independently
  /// of their type argument and of the memory they are bound to.
  @override
  bool operator ==(Object other) =>
      (other is Pointer && other.address == address);

  /// Returns a view of a single element at [index] (takes element
  /// size into account).
  ///
  /// Any modifications to the data will also alter the [Memory] object.
  ///
  /// Throws an [UnsupportedError] if called on a pointer with an @[unsized]
  /// type argument.
  @extra
  ByteData viewSingle(int index) {
    final int? s = size;
    if (s != null) {
      return boundMemory.buffer.asByteData(address + index * s, s);
    } else {
      throw UnsupportedError('viewSingle is not supported for unsized types!');
    }
  }
}

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
typedef AllowedFunc = JSAny Function(JSAny?, JSAny?, JSAny?, JSAny?);

JSFunction _toWasmFunction(String signature, Function func) {
  // This function is ported from the JavaScript that Emscripten emits. But more
  // concise cause Dart > JavaScript.

  const typeCodes = {
    'i': 0x7f, // i32
    'j': 0x7e, // i64
    'f': 0x7d, // f32
    'd': 0x7c, // f64
  };

  // ignore: prefer_function_declarations_over_variables
  final encodeArgTypes =
      (String types) => [
        types.length,
        ...types.runes.map((c) => typeCodes[String.fromCharCode(c)]!),
      ];
  // ignore: prefer_function_declarations_over_variables
  final encodeSection =
      (int type, List<int> content) => [type, content.length, ...content];

  // The module is static, with the exception of the type section, which is
  // generated based on the signature passed in.
  final bytes = [
    0x00, 0x61, 0x73, 0x6d, // magic ("\0asm")
    0x01, 0x00, 0x00, 0x00, // version: 1
    // id section
    ...encodeSection(0x01, [
      0x01, // count: 1
      0x60, // form: func
      // input arg types
      ...encodeArgTypes(signature.substring(1)),
      // output arg types
      ...encodeArgTypes(signature[0] == 'v' ? '' : signature[0]),
    ]),
    // import section: (import "e" "f" (func 0 (type 0)))
    ...encodeSection(0x02, [0x01, 0x01, 0x65, 0x01, 0x66, 0x00, 0x00]),
    // export section: (export "f" (func 0 (type 0)))
    ...encodeSection(0x07, [0x01, 0x01, 0x66, 0x00, 0x00]),
  ];

  // We can compile this wasm module synchronously because it is very small.
  // This accepts an import (at "e.f"), that it reroutes to an export (at "f")
  final func2 = func as AllowedFunc;
  final instance = Instance.loadFromBinarySync(
    Uint8List.fromList(bytes),
    imports: {
      'e': {'f': func2.toJS},
    },
  );

  return instance.functions['f']!;
}

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
final Map<Function, Pointer> exportedFunctions = {};

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
final Map<String, String> signatures = {};

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
void initSignatures([int pointerSizeBytes = 4]) {
  signatures[typeString<Float>()] = 'f';
  signatures[typeString<Double>()] = 'd';
  signatures[typeString<Int8>()] = 'i';
  signatures[typeString<Uint8>()] = 'i';
  signatures[typeString<Int16>()] = 'i';
  signatures[typeString<Uint16>()] = 'i';
  signatures[typeString<Int32>()] = 'i';
  signatures[typeString<Uint32>()] = 'i';
  signatures[typeString<Int64>()] = 'j';
  signatures[typeString<Uint64>()] = 'j';
  signatures[typeString<Utf8>()] = 'i';
  signatures[typeString<Char>()] = 'i';
  signatures[typeString<IntPtr>()] = pointerSizeBytes == 4 ? 'i' : 'j';
  signatures[typeString<Opaque>()] = pointerSizeBytes == 4 ? 'i' : 'j';
  signatures[typeString<Void>()] = 'v';
}

String _getWasmSignature<T extends Function>() {
  final List<String> dartSignature = typeString<T>().split('=>');
  final String retType = dartSignature.last.trim();
  final String argTypes = dartSignature.first.trim();
  final List<String> argTypesList = argTypes
      .substring(1, argTypes.length - 1)
      .split(', ');

  developer.log('types: $retType $argTypesList');
  developer.log('sigs: ${signatures.keys}');

  return [retType, ...argTypesList].map((s) => signatures[s] ?? 'i').join();
}

//final Set\<Function\> theFunctions = {};

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
final List<Function Function(Function)> callbackHelpers = [
  (Function func) => () => func([]),
  (Function func) => (arg1) => func([arg1]),
  (Function func) => (arg1, arg2) => func([arg1, arg2]),
  (Function func) => (arg1, arg2, arg3) => func([arg1, arg2, arg3]),
  (Function func) => (arg1, arg2, arg3, arg4) => func([arg1, arg2, arg3, arg4]),
  (Function func) =>
      (arg1, arg2, arg3, arg4, arg5) => func([arg1, arg2, arg3, arg4, arg5]),
  (Function func) =>
      (arg1, arg2, arg3, arg4, arg5, arg6) =>
          func([arg1, arg2, arg3, arg4, arg5, arg6]),
];

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
extension ListExtension<T> on List<T> {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  Iterable<E> mapIndexed<E>(E Function(int index, T item) f) sync* {
    for (var i = 0; i < length; i++) {
      yield f(i, this[i]);
    }
  }
}

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
Pointer<NativeFunction<T>> pointerFromFunctionImpl<T extends Function>(
  /* @DartRepresentationOf('T')  */
  Function func,
  WasmTable table,
  Memory memory,
) {
  // garbage collect

  return exportedFunctions.putIfAbsent(func, () {
        developer.log('marshal from: ${func.runtimeType} to $T');
        final String dartSignature = func.runtimeType.toString();
        final String argTypes = dartSignature.split('=>').first.trim();
        final List<String> argT = argTypes
            .substring(1, argTypes.length - 1)
            .split(', ');
        developer.log('arg types: $argT');
        final List<Function> marshallers =
            argTypes
                .substring(1, argTypes.length - 1)
                .split(', ')
                .map((arg) => marshaller(arg))
                .toList();

        final String wasmSignature = _getWasmSignature<T>();

        developer.log('wasm sig: $wasmSignature');

        // ignore: prefer_function_declarations_over_variables
        final Function wrapper1 = (List args) {
          developer.log('wrapper of $T called with $args');
          final marshalledArgs =
              marshallers.mapIndexed((i, m) => m(args[i], memory)).toList();
          developer.log('which is $marshalledArgs on $func');
          Function.apply(func, marshalledArgs);
          developer.log('done!');
        };
        final Function wrapper2 = callbackHelpers[argT.length](wrapper1);

        // theFunctions.add(wrapper);

        final wasmFunc = _toWasmFunction(wasmSignature, wrapper2);
        table.grow(1.toJS);
        table.set((table.length.toDartInt - 1).toJS, wasmFunc);
        developer.log(
          'created callback with index ${table.length.toDartInt - 1}',
        );
        return Pointer<NativeFunction<T>>.fromAddress(
          table.length.toDartInt - 1,
          memory,
        );
      })
      as Pointer<NativeFunction<T>>;
}

///
///
///
///
///

/// A memory range, represented by its starting address.
///
/// Shared supertype of the FFI compound [Struct], [Union], and [Array] types.
///
/// This class is not abstract because instances can be created as an anonymous
/// representation of a memory area, with no structure on top. (In particular,
/// during the transformation of `.address` in FFI leaf calls.)
@pragma("wasm:entry-point")
final class _Compound implements NativeType {
  /// The underlying [TypedData] or [Pointer] that a subtype uses.
  // @pragma("vm:entry-point")
  // ignore: unused_field
  final Object _typedDataBase;

  /// Offset in bytes into [_typedDataBase].
  // @pragma("vm:entry-point")
  // ignore: unused_field
  final int _offsetInBytes;

  _Compound._([int? offsetInBytes, Object? typedDataBase])
    : _typedDataBase = typedDataBase ?? "",
      _offsetInBytes = offsetInBytes ?? 0 {
    throw UnimplementedError();
  }

  @pragma('vm:prefer-inline')
  _Compound._fromTypedDataBase(this._typedDataBase, this._offsetInBytes);

  /// Constructs a view on [typedData].
  ///
  /// The length in bytes of [typedData] must at least be [sizeInBytes].
  @pragma('vm:prefer-inline')
  _Compound._fromTypedData(TypedData typedData, int offset, int sizeInBytes)
    : _typedDataBase = typedData,
      _offsetInBytes = typedData.elementSizeInBytes * offset {
    if (typedData.lengthInBytes <
        typedData.elementSizeInBytes * offset + sizeInBytes) {
      throw RangeError.range(
        typedData.lengthInBytes,
        sizeInBytes + typedData.elementSizeInBytes * offset,
        null,
        'typedData.lengthInBytes',
        'The typed list is not large enough',
      );
    }
  }
}

/// The supertype of all FFI struct types.
///
/// FFI struct types should extend this class and declare fields corresponding
/// to the underlying native structure.
///
/// Field declarations in a [Struct] subclass declaration are automatically
/// given a setter and getter implementation which accesses the native struct's
/// field in memory.
///
/// All field declarations in a [Struct] subclass declaration must either have
/// type [int] or [double] and be annotated with a [NativeType] representing the
/// native type, or must be of type [Pointer], [Array] or a subtype of [Struct]
/// or [Union]. For example:
///
/// ```c
/// typedef struct {
///  int a;
///  float b;
///  void* c;
/// } my_struct;
/// ```
///
/// ```dart
/// final class MyStruct extends Struct {
///   @Int32()
///   external int a;
///
///   @Float()
///   external double b;
///
///   external Pointer<Void> c;
/// }
/// ```
///
/// The field declarations of a [Struct] subclass *must* be marked `external`. A
/// struct subclass points directly into a location of native memory ([Pointer])
/// or Dart memory ([TypedData]), and the external field's getter and setter
/// implementations directly read and write bytes at appropriate offsets from
/// that location. This does not allow for non-native fields to also exist.
///
/// An instance of a struct subclass cannot be created with a generative
/// constructor. Instead, an instance can be created by,
/// [Struct.create], FFI call return values, FFI callback arguments,
/// , and accessing [Struct] fields. To create an instance backed
/// by native memory, use . To create an instance backed by
/// Dart memory, use [Struct.create].
// @Since('2.12')
abstract base class Struct extends _Compound implements SizedNativeType {
  /// Construct a reference to the [nullptr].
  ///
  /// Use 's `.ref` to gain references to native memory backed
  /// structs.
  Struct() : super._();

  /// Creates a struct view of bytes in [typedData].
  ///
  /// The created instance of the struct subclass will then be backed by the
  /// bytes at [TypedData.offsetInBytes] plus [offset] times
  /// [TypedData.elementSizeInBytes]. That is, the getters and setters of the
  /// external instance variables declared by the subclass, will read an write
  /// their values from the bytes of the [TypedData.buffer] of [typedData],
  /// starting at [TypedData.offsetInBytes] plus [offset] times
  /// [TypedData.elementSizeInBytes]. The [TypedData.lengthInBytes] of
  /// [typedData] *must* be sufficient to contain the [sizeOf] of the struct
  /// subclass. _It doesn't matter whether the [typedData] is, for example, a
  /// [Uint8List], a [Float64List], or any other [TypedData], it's only treated
  /// as a view into a [ByteBuffer], through its [TypedData.buffer],
  /// [TypedData.offsetInBytes] and [TypedData.lengthInBytes]._
  ///
  /// If [typedData] is omitted, a fresh [ByteBuffer], with precisely enough
  /// bytes for the [sizeOf] of the created struct, is allocated on the Dart
  /// heap, and used as memory to store the struct fields.
  ///
  /// If [offset] is provided, the indexing into [typedData] is offset by
  /// [offset] times [TypedData.elementSizeInBytes].
  ///
  /// Example:
  ///
  /// ```dart import:typed_data
  /// final class Point extends Struct {
  ///   @Double()
  ///   external double x;
  ///
  ///   @Double()
  ///   external double y;
  ///
  ///   /// Creates Dart managed memory to hold a `Point` and returns the
  ///   /// `Point` view on it.
  ///   factory Point(double x, double y) {
  ///     return Struct.create()
  ///       ..x = x
  ///       ..y = y;
  ///   }
  ///
  ///   /// Creates a [Point] view on [typedData].
  ///   factory Point.fromTypedData(TypedData typedData) {
  ///     return Struct.create(typedData);
  ///   }
  /// }
  /// ```
  ///
  /// To create a struct object from a [Pointer], use .
  // @Since('3.4')
  static T create<T extends Struct>([TypedData? typedData, int? offset]) {
    throw UnimplementedError();
  }

  /// Creates a view on a [TypedData] or [Pointer].
  ///
  /// Used in , FFI calls, and FFI callbacks.
  // @pragma('vm:prefer-inline')
  // ignore: unused_element
  Struct._fromTypedDataBase(super._typedDataBase, super._offsetInBytes)
    : super._fromTypedDataBase();

  /// Creates a view on [typedData].
  ///
  /// The length in bytes of [typedData] must at least be [sizeInBytes].
  ///
  /// Used in the `external` public constructor of [Struct].
  // @pragma('vm:prefer-inline')
  // ignore: unused_element
  Struct._fromTypedData(super.typedData, super.offset, super.sizeInBytes)
    : super._fromTypedData();
}

/// Annotation to specify on `Struct` subtypes to indicate that its members
/// need to be packed.
///
/// Valid values for [memberAlignment] are 1, 2, 4, 8, and 16.
// @Since('2.13')
final class Packed {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final int memberAlignment;

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const Packed(this.memberAlignment);
}

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
base class AbiSpecificInteger implements SizedNativeType {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const AbiSpecificInteger();
}

/// Mapping for a subtype of [AbiSpecificInteger].
///
/// See documentation on [AbiSpecificInteger].
// @Since('2.16')
final class AbiSpecificIntegerMapping {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final Map<Abi, NativeType> mapping;

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const AbiSpecificIntegerMapping(this.mapping);
}

// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// part of dart.ffi;

/// The supertype of all FFI union types.
///
/// FFI union types should extend this class and declare fields corresponding to
/// the underlying native union.
///
/// Field declarations in a [Union] subclass declaration are automatically given
/// a setter and getter implementation which accesses the native union's field
/// in memory.
///
/// All field declarations in a [Union] subclass declaration must either have
/// type [int] or [double] and be annotated with a [NativeType] representing the
/// native type, or must be of type [Pointer], [Array] or a subtype of [Struct]
/// or [Union]. For example:
///
/// ```c
/// typedef union {
///  int a;
///  float b;
///  void* c;
/// } my_union;
/// ```
///
/// ```dart
/// final class MyUnion extends Union {
///   @Int32()
///   external int a;
///
///   @Float()
///   external double b;
///
///   external Pointer<Void> c;
/// }
/// ```
///
/// The field declarations of a [Union] subclass *must* be marked `external`. A
/// union subclass points directly into a location of native memory ([Pointer])
/// or Dart memory ([TypedData]), and the external field's getter and setter
/// implementations directly read and write bytes at appropriate offsets from
/// that location. This does not allow for non-native fields to also exist.
///
/// An instance of a union subclass cannot be created with a generative
/// constructor. Instead, an instance can be created by ,
/// [Union.create], FFI call return values, FFI callback arguments,
/// , and accessing [Union] fields. To create an instance backed
/// by native memory, use . To create an instance backed by
/// Dart memory, use [Union.create].
// @Since('2.14')
abstract base class Union extends _Compound implements SizedNativeType {
  /// Construct a reference to the [nullptr].
  ///
  /// Use 's `.ref` to gain references to native memory backed
  /// unions.
  Union() : super._();

  /// Creates a union view of bytes in [typedData].
  ///
  /// The created instance of the union subclass will then be backed by the
  /// bytes at [TypedData.offsetInBytes] plus [offset] times
  /// [TypedData.elementSizeInBytes]. That is, the getters and setters of the
  /// external instance variables declared by the subclass, will read an write
  /// their values from the bytes of the [TypedData.buffer] of [typedData],
  /// starting at [TypedData.offsetInBytes] plus [offset] times
  /// [TypedData.elementSizeInBytes]. The [TypedData.lengthInBytes] of
  /// [typedData] *must* be sufficient to contain the [sizeOf] of the union
  /// subclass. _It doesn't matter whether the [typedData] is, for example, a
  /// [Uint8List], a [Float64List], or any other [TypedData], it's only treated
  /// as a view into a [ByteBuffer], through its [TypedData.buffer],
  /// [TypedData.offsetInBytes] and [TypedData.lengthInBytes]._
  ///
  /// If [typedData] is omitted, a fresh [ByteBuffer], with precisely enough
  /// bytes for the [sizeOf] of the created union, is allocated on the Dart
  /// heap, and used as memory to store the union fields.
  ///
  /// If [offset] is provided, the indexing into [typedData] is offset by
  /// [offset] times [TypedData.elementSizeInBytes].
  ///
  /// Example:
  ///
  /// ```dart import:typed_data
  /// final class MyUnion extends Union {
  ///   @Int32()
  ///   external int a;
  ///
  ///   @Float()
  ///   external double b;
  ///
  ///   /// Creates Dart managed memory to hold a `MyUnion` and returns the
  ///   /// `MyUnion` view on it.
  ///   factory MyUnion.a(int a) {
  ///     return Union.create()..a = a;
  ///   }
  ///
  ///   /// Creates Dart managed memory to hold a `MyUnion` and returns the
  ///   /// `MyUnion` view on it.
  ///   factory MyUnion.b(double b) {
  ///     return Union.create()..b = b;
  ///   }
  ///
  ///   /// Creates a [MyUnion] view on [typedData].
  ///   factory MyUnion.fromTypedData(TypedData typedData) {
  ///     return Union.create(typedData);
  ///   }
  /// }
  /// ```
  ///
  /// To create a union object from a [Pointer], use .
  // @Since('3.4')
  static T create<T extends Union>([TypedData? typedData, int? offset]) {
    throw UnimplementedError();
  }

  /// Creates a view on a [TypedData] or [Pointer].
  ///
  /// Used in , FFI calls, and FFI callbacks.
  // ignore: unused_element
  Union._fromTypedDataBase(super._typedDataBase, super._offsetInBytes)
    : super._fromTypedDataBase();

  /// Creates a view on [typedData].
  ///
  /// The length in bytes of [typedData] must at least be [sizeInBytes].
  ///
  /// Used in the `external` public constructor of [Union].
  // ignore: unused_element
  Union._fromTypedData(super.typedData, super.offset, super.sizeInBytes)
    : super._fromTypedData();
}

///
///
///
///
///
///
///

/// A fixed-sized array of [T]s.
// @Since('2.13')
final class Array<T extends NativeType> extends _Compound {
  /// Annotation to specify [Array] dimensions in [Struct]s.
  ///
  /// ```dart
  /// final class MyStruct extends Struct {
  ///   @Array(8)
  ///   external Array<Uint8> inlineArray;
  ///
  ///   @Array(2, 2, 2)
  ///   external Array<Array<Array<Uint8>>> threeDimensionalInlineArray;
  /// }
  /// ```
  ///
  /// Do not invoke in normal code.
  const factory Array(
    int dimension1, [
    int dimension2,
    int dimension3,
    int dimension4,
    int dimension5,
  ]) = _ArraySize<T>;

  /// Annotation to specify [Array] dimensions in [Struct]s.
  ///
  /// ```dart
  /// final class MyStruct extends Struct {
  ///   @Array.multi([2, 2, 2])
  ///   external Array<Array<Array<Uint8>>> threeDimensionalInlineArray;
  ///
  ///   @Array.multi([2, 2, 2, 2, 2, 2, 2, 2])
  ///   external Array<Array<Array<Array<Array<Array<Array<Array<Uint8>>>>>>>> eightDimensionalInlineArray;
  /// }
  /// ```
  ///
  /// Do not invoke in normal code.
  const factory Array.multi(List<int> dimensions) = _ArraySize<T>.multi;

  /// Annotation to specify a variable length [Array] in [Struct]s.
  ///
  /// Can only be used on the last field of a struct. The last field of the
  /// struct is _not_ taken into account in [sizeOf]. Using an
  ///  will _not_ allocate any backing storage for the
  /// variable length array. Instead use [Allocator.allocate] and calculate the
  /// required number of bytes manually.
  ///
  /// ```dart
  /// import 'dart:ffi';
  /// import 'package:ffi/ffi.dart';
  ///
  /// final class MyStruct extends Struct {
  ///   @Size()
  ///   external int length;
  ///
  ///   @Array.variable()
  ///   external Array<Uint8> inlineArray;
  ///
  ///   static Pointer<MyStruct> allocate(Allocator allocator, int length) {
  ///     final lengthInBytes = sizeOf<MyStruct>() + sizeOf<Uint8>() * length;
  ///     final result = allocator.allocate<MyStruct>(lengthInBytes);
  ///     result.ref.length = length;
  ///     return result;
  ///   }
  /// }
  ///
  /// void main() {
  ///   final myStruct = MyStruct.allocate(calloc, 10);
  /// }
  /// ```
  ///
  /// The variable length is always the outermost dimension of the array.
  ///
  /// ```dart
  /// import 'dart:ffi';
  /// import 'package:ffi/ffi.dart';
  ///
  /// final class MyStruct extends Struct {
  ///   @Size()
  ///   external int length;
  ///
  ///   @Array.variable(10, 10)
  ///   external Array<Array<Array<Uint8>>> inlineArray;
  ///
  ///   static Pointer<MyStruct> allocate(Allocator allocator, int length) {
  ///     final lengthInBytes = sizeOf<MyStruct>() + sizeOf<Uint8>() * length * 100;
  ///     final result = allocator.allocate<MyStruct>(lengthInBytes);
  ///     result.ref.length = length;
  ///     return result;
  ///   }
  /// }
  /// ```
  ///
  /// Accessing variable length inline arrays of structs passed by value in FFI
  /// calls and callbacks is undefined behavior. Accessing variable length
  /// inline arrays in structs passed by value is undefined behavior in C.
  ///
  /// For more information about variable length inline arrays in C, please
  /// refer to: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html.
  ///
  /// Do not invoke in normal code.
  // @Since('3.6')
  const factory Array.variable([
    int dimension2,
    int dimension3,
    int dimension4,
    int dimension5,
  ]) = _ArraySize<T>.variable;

  /// Annotation to specify a variable length [Array] with a configurable
  /// variable dimension ([dimension1]) in [Struct]s.
  ///
  /// Can only be used on the last field of a struct. When [dimension1] is set
  /// to a value greater than zero (`0`), the last field of the struct is taken
  /// into account in [sizeOf] and . This is particularly
  /// useful when working with Windows APIs, where most structs with variable
  /// length arrays are defined to have an initial dimension of one (`1`).
  ///
  /// ```dart
  /// import 'dart:ffi';
  /// import 'package:ffi/ffi.dart';
  ///
  /// final class MyStruct extends Struct {
  ///   @Size()
  ///   external int length;
  ///
  ///   @Array.variableWithVariableDimension(1)
  ///   external Array<Uint8> inlineArray;
  ///
  ///   static Pointer<MyStruct> allocate(Allocator allocator, int length) {
  ///     final lengthInBytes = sizeOf<MyStruct>() + sizeOf<Uint8>() * (length - 1);
  ///     final result = allocator.allocate<MyStruct>(lengthInBytes);
  ///     result.ref.length = length;
  ///     return result;
  ///   }
  /// }
  ///
  /// void main() {
  ///   final myStruct = MyStruct.allocate(calloc, 10);
  /// }
  /// ```
  ///
  /// The variable length is always the outermost dimension of the array.
  ///
  /// Do not invoke in normal code.
  // @Since('3.7')
  const factory Array.variableWithVariableDimension([
    int dimension1,
    int dimension2,
    int dimension3,
    int dimension4,
    int dimension5,
  ]) = _ArraySize<T>.variableWithVariableDimension;

  /// Annotation to a variable length [Array] in [Struct]s.
  ///
  /// ```dart
  /// final class MyStruct extends Struct {
  ///   @Array.variableMulti([2, 2])
  ///   external Array<Array<Array<Uint8>>> threeDimensionalInlineArray;
  /// }
  ///
  /// final class MyStruct2 extends Struct {
  ///   @Array.variableMulti(variableDimension: 1, [2, 2, 2])
  ///   external Array<Array<Array<Array<Uint8>>>> fourDimensionalInlineArray;
  /// }
  ///
  /// final class MyStruct3 extends Struct {
  ///   @Array.variableMulti([2, 2, 2, 2, 2, 2, 2])
  ///   external Array<Array<Array<Array<Array<Array<Array<Array<Uint8>>>>>>>> eightDimensionalInlineArray;
  /// }
  /// ```
  ///
  /// The variable length is always the outermost dimension of the array.
  ///
  /// [variableDimension] is the outermost dimension of the variable length
  /// array (defaults to zero (`0`)). When [variableDimension] is set to a value
  /// greater than zero (`0`), the last field of the struct is taken into
  /// account in [sizeOf] and .
  ///
  /// Do not invoke in normal code.
  // @Since('3.6')
  const factory Array.variableMulti(
    List<int> dimensions, {
    // @Since('3.7')
    int variableDimension,
  }) = _ArraySize<T>.variableMulti;
}

final class _ArraySize<T extends NativeType> implements Array<T> {
  final int? dimension1;
  final int? dimension2;
  final int? dimension3;
  final int? dimension4;
  final int? dimension5;

  final List<int>? dimensions;

  // When non-null, [dimension1] is equal to this value, or [dimensions] should
  // be prepended with this value.
  final int? variableDimension;

  const _ArraySize(
    this.dimension1, [
    this.dimension2,
    this.dimension3,
    this.dimension4,
    this.dimension5,
  ]) : dimensions = null,
       variableDimension = null;

  const _ArraySize.multi(this.dimensions)
    : dimension1 = null,
      dimension2 = null,
      dimension3 = null,
      dimension4 = null,
      dimension5 = null,
      variableDimension = null;

  const _ArraySize.variable([
    this.dimension2,
    this.dimension3,
    this.dimension4,
    this.dimension5,
  ]) : dimension1 = 0,
       dimensions = null,
       variableDimension = 0;

  const _ArraySize.variableWithVariableDimension([
    this.dimension1,
    this.dimension2,
    this.dimension3,
    this.dimension4,
    this.dimension5,
  ]) : dimensions = null,
       variableDimension = dimension1;

  const _ArraySize.variableMulti(
    List<int> nestedDimensions, {
    int variableDimension = 0,
  }) : // Should be `[variableDimension, ...nestedDimensions]`.
       dimensions = nestedDimensions,
       dimension1 = null,
       dimension2 = null,
       dimension3 = null,
       dimension4 = null,
       dimension5 = null,
       variableDimension = variableDimension;

  // uncompleted
  @override
  // ignore: unused_element
  int get _offsetInBytes => 0;
  // uncompleted
  @override
  // ignore: unused_element
  Object get _typedDataBase => "";
}
