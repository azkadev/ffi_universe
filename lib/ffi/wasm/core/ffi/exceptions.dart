/// Occures if it's not possible to convert dart types to JavaScript types.
///
/// This usually happens if a not allowed type is uses as a [NativeType]'s
/// type argument, or a not allowed return value of a [NativeFunction] is
/// used.
class MarshallingException implements Exception {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  final dynamic message;

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const MarshallingException([this.message]);

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  MarshallingException.noAddress(Object o) : this('Expected a address (int) but found ${o.runtimeType}');

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  MarshallingException.typeMissmatch(Type t, Object o) : this('Expected a type of $t but object has type ${o.runtimeType}');

  @override
  String toString() => Exception(message).toString();
}
