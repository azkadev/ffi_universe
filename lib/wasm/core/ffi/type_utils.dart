// ignore_for_file: non_constant_identifier_names

import 'types.dart';

/// Hacky workadround, see https://github.com/dart-lang/language/issues/123
Type _extractType<T>() => T;
String typeString<T>() => _extractType<T>().toString();

final Type DartVoidType = _extractType<void>();
final Type FfiVoidType = _extractType<Void>();

final String _dynamicTypeString = typeString<dynamic>();

final String pointerPointerPointerPrefix =
    typeString<Pointer<Pointer<Pointer<dynamic>>>>()
        .split(_dynamicTypeString)
        .first;

final String pointerNativeFunctionPrefix =
    typeString<Pointer<NativeFunction<dynamic>>>()
        .split(_dynamicTypeString)
        .first;

final String _nativeFunctionPrefix =
    typeString<NativeFunction<dynamic>>().split(_dynamicTypeString).first;
bool isNativeFunctionType<T extends NativeType>() =>
    typeString<T>().startsWith(_nativeFunctionPrefix);

final String _pointerPrefix =
    typeString<Pointer<dynamic>>().split(_dynamicTypeString).first;
bool isPointerType<T extends NativeType>() =>
    typeString<T>().startsWith(_pointerPrefix);

bool isVoidType<T extends NativeType>() => _extractType<T>() == FfiVoidType;
