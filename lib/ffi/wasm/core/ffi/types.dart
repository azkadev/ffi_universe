import 'dart:developer' as developer;
import 'dart:js_interop';
import 'dart:typed_data';
import 'package:meta/meta.dart';
import '../ffi_utils/utf8.dart';
import '../js_utils/wasm_interop.dart';
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
class NativeType {}

/// Represents a native 64 bit double in C.
///
/// Double is not constructible in the Dart code and serves
/// purely as marker in type signatures.
@sealed
@notConstructible
class Double extends NativeType {}

/// Represents a native 32 bit float in C.
///
/// Float is not constructible in the Dart code and serves
/// purely as marker in type signatures.
@sealed
@notConstructible
class Float extends NativeType {}

/// The C `int` type.
///
/// Int is not constructible in the Dart code and serves
/// purely as marker in type signatures.
@sealed
@notConstructible
class Int extends NativeType {}

/// Represents a native signed 8 bit integer in C.
///
/// Int8 is not constructible in the Dart code and serves
/// purely as marker in type signatures.
@sealed
@notConstructible
class Int8 extends NativeType {}

/// Represents a native signed 16 bit integer in C.
///
/// Int16 is not constructible in the Dart code and serves
/// purely as marker in type signatures.
@sealed
@notConstructible
class Int16 extends NativeType {}

/// Represents a native signed 32 bit integer in C.
///
/// Int32 is not constructible in the Dart code and serves
/// purely as marker in type signatures.
@sealed
@notConstructible
class Int32 extends NativeType {}

/// Represents a native signed 64 bit integer in C.
///
/// Int64 is not constructible in the Dart code and serves
/// purely as marker in type signatures.
@sealed
@notConstructible
class Int64 extends NativeType {}

/// The C `unsigned int` type.
///
/// Int is not constructible in the Dart code and serves
/// purely as marker in type signatures.
@sealed
@notConstructible
class UnsignedInt extends NativeType {}

/// Represents a native unsigned 8 bit integer in C.
///
/// Uint8 is not constructible in the Dart code and serves
/// purely as marker in type signatures.
@sealed
@notConstructible
class Uint8 extends NativeType {}

/// Represents a native unsigned 16 bit integer in C.
///
/// Uint16 is not constructible in the Dart code and serves
/// purely as marker in type signatures.
@sealed
@notConstructible
class Uint16 extends NativeType {}

/// Represents a native unsigned 32 bit integer in C.
///
/// Uint32 is not constructible in the Dart code and serves
/// purely as marker in type signatures.
@sealed
@notConstructible
class Uint32 extends NativeType {}

/// Represents a native unsigned 64 bit integer in C.
///
/// Uint64 is not constructible in the Dart code and serves
/// purely as marker in type signatures.
@sealed
@notConstructible
class Uint64 extends NativeType {}

/// Represents a native pointer-sized integer in C.
///
/// IntPtr is not constructible in the Dart code and serves
/// purely as marker in type signatures.
@sealed
@notConstructible
class IntPtr extends NativeType {}

/// Represents a native pointer-sized unsigned integer in C.
///
/// IntPtr is not constructible in the Dart code and serves
/// purely as marker in type signatures.
@sealed
@notConstructible
class UintPtr extends NativeType {}

/// Represents a native bool in C.
///
/// Bool is not constructible in the Dart code and serves
/// purely as marker in type signatures.
@sealed
@notConstructible
class Bool extends NativeType {}

/// Represents a function type in C.
///
/// NativeFunction is not constructible in the Dart code and serves
/// purely as marker in type signatures.
@sealed
@notConstructible
@unsized
class NativeFunction<T extends Function> extends NativeType {}

/// Opaque's subtypes represent opaque types in C.
///
/// Classes that extend Opaque MUST NOT have a type argument!
///
/// Opaque's subtypes are not constructible in the Dart code and serve
/// purely as markers in type signatures.
@noGeneric
@notConstructible
class Opaque extends NativeType {}

/// Represents a void type in C.
///
/// Void is not constructible in the Dart code and serves
/// purely as marker in type signatures.
@sealed
@notConstructible
@unsized
class Void extends NativeType {}

/// Represents a Size type in C.
///
/// Size is not constructible in the Dart code and serves
/// purely as marker in type signatures.
@sealed
@notConstructible
@unsized
class Size extends NativeType {}

/// Miscellaneous types, defined as alias
typedef Char = Int8;

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
typedef UnsignedChar = Uint8;

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
typedef Short = Int16;

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
typedef UnsignedShort = Uint16;

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
typedef Long = Int32;

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
class Pointer<T extends NativeType> extends NativeType {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  static Pointer<NativeFunction<T>> fromFunction<T extends Function>(Function f, [Object? exceptionalReturn, Memory? bindToMemory, WasmTable? bindToTable]) {
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
      throw StateError('No global memory set and no explcity memory to bind to given!');
    }
    return Pointer._(ptr, memory, _isUnsizedType<T>() ? null : sizeOf<T>());
  }

  Pointer._(this.address, this.boundMemory, this.size);

  /// Casts this pointer to an other type.
  Pointer<U> cast<U extends NativeType>() => Pointer<U>._(address, boundMemory, _isUnsizedType<U>() ? null : sizeOf<U>());

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
  bool operator ==(Object other) => (other is Pointer && other.address == address);

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
  final encodeArgTypes = (String types) => [types.length, ...types.runes.map((c) => typeCodes[String.fromCharCode(c)]!)];
  // ignore: prefer_function_declarations_over_variables
  final encodeSection = (int type, List<int> content) => [type, content.length, ...content];

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
  final List<String> argTypesList = argTypes.substring(1, argTypes.length - 1).split(', ');

  developer.log('types: $retType $argTypesList');
  developer.log('sigs: ${signatures.keys}');

  return [retType, ...argTypesList].map((s) => signatures[s] ?? 'i').join();
}

//final Set<Function> theFunctions = {};

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
final List<Function Function(Function)> callbackHelpers = [
  (Function func) => () => func([]),
  (Function func) => (arg1) => func([arg1]),
  (Function func) => (arg1, arg2) => func([arg1, arg2]),
  (Function func) => (arg1, arg2, arg3) => func([arg1, arg2, arg3]),
  (Function func) => (arg1, arg2, arg3, arg4) => func([arg1, arg2, arg3, arg4]),
  (Function func) => (arg1, arg2, arg3, arg4, arg5) => func([arg1, arg2, arg3, arg4, arg5]),
  (Function func) => (arg1, arg2, arg3, arg4, arg5, arg6) => func([arg1, arg2, arg3, arg4, arg5, arg6]),
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
        final List<String> argT = argTypes.substring(1, argTypes.length - 1).split(', ');
        developer.log('arg types: $argT');
        final List<Function> marshallers = argTypes.substring(1, argTypes.length - 1).split(', ').map((arg) => marshaller(arg)).toList();

        final String wasmSignature = _getWasmSignature<T>();

        developer.log('wasm sig: $wasmSignature');

        // ignore: prefer_function_declarations_over_variables
        final Function wrapper1 = (List args) {
          developer.log('wrapper of $T called with $args');
          final marshalledArgs = marshallers.mapIndexed((i, m) => m(args[i], memory)).toList();
          developer.log('which is $marshalledArgs on $func');
          Function.apply(func, marshalledArgs);
          developer.log('done!');
        };
        final Function wrapper2 = callbackHelpers[argT.length](wrapper1);

        // theFunctions.add(wrapper);

        final wasmFunc = _toWasmFunction(wasmSignature, wrapper2);
        table.grow(1.toJS);
        table.set((table.length.toDartInt - 1).toJS, wasmFunc);
        developer.log('created callback with index ${table.length.toDartInt - 1}');
        return Pointer<NativeFunction<T>>.fromAddress(table.length.toDartInt - 1, memory);
      })
      as Pointer<NativeFunction<T>>;
}
