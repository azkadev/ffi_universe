// ignore_for_file: non_constant_identifier_names

import 'types.dart';

/// Hacky workadround, see https://github.com/dart-lang/language/issues/123
Type _extractType<T>() => T;

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
String typeString<T>() => _extractType<T>().toString();

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
final Type DartVoidType = _extractType<void>();

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
final Type FfiVoidType = _extractType<Void>();

final String _dynamicTypeString = typeString<dynamic>();

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
final String pointerPointerPointerPrefix = typeString<Pointer<Pointer<Pointer<dynamic>>>>().split(_dynamicTypeString).first;

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
final String pointerNativeFunctionPrefix = typeString<Pointer<NativeFunction<dynamic>>>().split(_dynamicTypeString).first;

final String _nativeFunctionPrefix = typeString<NativeFunction<dynamic>>().split(_dynamicTypeString).first;

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
bool isNativeFunctionType<T extends NativeType>() => typeString<T>().startsWith(_nativeFunctionPrefix);

final String _pointerPrefix = typeString<Pointer<dynamic>>().split(_dynamicTypeString).first;

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
bool isPointerType<T extends NativeType>() => typeString<T>().startsWith(_pointerPrefix);

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
bool isVoidType<T extends NativeType>() => _extractType<T>() == FfiVoidType;
