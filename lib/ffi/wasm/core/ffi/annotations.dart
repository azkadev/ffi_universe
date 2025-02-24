///
class Extra {
  ///
  const Extra();
}

/// A class, field or method annotated with extra is present in `wasm_ffi`,
/// but not in `dart:ffi`.
const Extra extra = Extra();

///
class Different {
  ///
  const Different();
}

/// A class, field or method annotated with different is present in `wasm_ffi`,
/// but behavior is different from that of `dart:ffi`.
const Different different = Different();

///
class NoGeneric {
  ///
  const NoGeneric();
}

/// If a class which is annotead with [noGeneric] is extended or implemented,
/// the derived class MUST NOT impose a type argument!
const NoGeneric noGeneric = NoGeneric();

///
class NotConstructible {
  ///
  const NotConstructible();
}

/// A [NativeType] annotated with unsized should not be instantiated.
///
/// However, they are not marked as `abstract` to meet the dart:ffi API.
const NotConstructible notConstructible = NotConstructible();

///
class Unsized {
  ///
  const Unsized();
}

/// A [NativeType] annotated with unsized does not have a predefined size.
///
/// Unsized [NativeType]s do not support [sizeOf] because their size is unknown,
/// so calling [sizeOf] with an @[unsized] [NativeType] will throw an exception.
/// Consequently, [Pointer.elementAt] is not available and will also throw an exception.
const Unsized unsized = Unsized();

///
class DartRepresentationOf {
  /// Represents the Dart type corresponding to a [NativeType].
  ///
  /// [Int8]                               -> [int]
  /// [Int16]                              -> [int]
  /// [Int32]                              -> [int]
  /// [Int64]                              -> [int]
  /// [Uint8]                              -> [int]
  /// [Uint16]                             -> [int]
  /// [Uint32]                             -> [int]
  /// [Uint64]                             -> [int]
  /// [IntPtr]                             -> [int]
  /// [Double]                             -> [double]
  /// [Float]                              -> [double]
  /// [Pointer]<T>                         -> [Pointer]<T>
  /// [NativeFunction]<T1 Function(T2, T3) -> S1 Function(S2, S3)
  ///    where DartRepresentationOf(Tn) -> Sn
  /// T extends Struct                  -> T
  const DartRepresentationOf();
}
