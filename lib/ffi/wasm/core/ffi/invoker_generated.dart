import 'marshaller.dart' show execute;
import 'memory.dart';
import 'types.dart';

/// https://stackoverflow.com/questions/26122009/is-there-a-maximum-number-of-parameters-for-functions-in-c-with-the-gcc-resp-m
/// the C Standard 5.2.4.1 says:
/// 4095 characters in a logical source line
/// 127 parameters in one function definition
/// 127 arguments in one function call

class OpaqueInvokeHelper<T extends Opaque> extends InvokeHelper<Pointer<T>> {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  OpaqueInvokeHelper(super.base, super.memory);

  @override
  InvokeHelper<Pointer<T>> copyWith(Function base, Memory memory) {
    return OpaqueInvokeHelper<T>(base, memory);
  }

  @override
  Pointer<T> run([dynamic arg0, dynamic arg1, dynamic arg2, dynamic arg3, dynamic arg4, dynamic arg5, dynamic arg6, dynamic arg7, dynamic arg8, dynamic arg9, dynamic arg10, dynamic arg11, dynamic arg12, dynamic arg13, dynamic arg14, dynamic arg15, dynamic arg16, dynamic arg17, dynamic arg18, dynamic arg19, dynamic arg20, dynamic arg21, dynamic arg22, dynamic arg23, dynamic arg24, dynamic arg25, dynamic arg26, dynamic arg27, dynamic arg28, dynamic arg29, dynamic arg30, dynamic arg31, dynamic arg32, dynamic arg33, dynamic arg34, dynamic arg35, dynamic arg36, dynamic arg37, dynamic arg38, dynamic arg39, dynamic arg40, dynamic arg41, dynamic arg42, dynamic arg43, dynamic arg44, dynamic arg45, dynamic arg46, dynamic arg47, dynamic arg48, dynamic arg49, dynamic arg50, dynamic arg51, dynamic arg52, dynamic arg53, dynamic arg54, dynamic arg55, dynamic arg56, dynamic arg57, dynamic arg58, dynamic arg59, dynamic arg60, dynamic arg61, dynamic arg62, dynamic arg63, dynamic arg64, dynamic arg65, dynamic arg66, dynamic arg67, dynamic arg68, dynamic arg69, dynamic arg70, dynamic arg71, dynamic arg72, dynamic arg73, dynamic arg74, dynamic arg75, dynamic arg76, dynamic arg77, dynamic arg78, dynamic arg79, dynamic arg80, dynamic arg81, dynamic arg82, dynamic arg83, dynamic arg84, dynamic arg85, dynamic arg86, dynamic arg87, dynamic arg88, dynamic arg89, dynamic arg90, dynamic arg91, dynamic arg92, dynamic arg93, dynamic arg94, dynamic arg95, dynamic arg96, dynamic arg97, dynamic arg98, dynamic arg99, dynamic arg100, dynamic arg101, dynamic arg102, dynamic arg103, dynamic arg104, dynamic arg105, dynamic arg106, dynamic arg107, dynamic arg108, dynamic arg109, dynamic arg110, dynamic arg111, dynamic arg112, dynamic arg113, dynamic arg114, dynamic arg115, dynamic arg116, dynamic arg117, dynamic arg118, dynamic arg119, dynamic arg120, dynamic arg121, dynamic arg122, dynamic arg123, dynamic arg124, dynamic arg125, dynamic arg126]) => InvokeHelper<Pointer<Opaque>>(_base, _memory).run(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25, arg26, arg27, arg28, arg29, arg30, arg31, arg32, arg33, arg34, arg35, arg36, arg37, arg38, arg39, arg40, arg41, arg42, arg43, arg44, arg45, arg46, arg47, arg48, arg49, arg50, arg51, arg52, arg53, arg54, arg55, arg56, arg57, arg58, arg59, arg60, arg61, arg62, arg63, arg64, arg65, arg66, arg67, arg68, arg69, arg70, arg71, arg72, arg73, arg74, arg75, arg76, arg77, arg78, arg79, arg80, arg81, arg82, arg83, arg84, arg85, arg86, arg87, arg88, arg89, arg90, arg91, arg92, arg93, arg94, arg95, arg96, arg97, arg98, arg99, arg100, arg101, arg102, arg103, arg104, arg105, arg106, arg107, arg108, arg109, arg110, arg111, arg112, arg113, arg114, arg115, arg116, arg117, arg118, arg119, arg120, arg121, arg122, arg123, arg124, arg125, arg126).cast<T>();
}

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
class OpaqueInvokeHelperSquare<T extends Opaque> extends InvokeHelper<Pointer<Pointer<T>>> {
  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  OpaqueInvokeHelperSquare(super.base, super.memory);

  @override
  InvokeHelper<Pointer<Pointer<T>>> copyWith(Function base, Memory memory) {
    return OpaqueInvokeHelperSquare<T>(base, memory);
  }

  @override
  Pointer<Pointer<T>> run([dynamic arg0, dynamic arg1, dynamic arg2, dynamic arg3, dynamic arg4, dynamic arg5, dynamic arg6, dynamic arg7, dynamic arg8, dynamic arg9, dynamic arg10, dynamic arg11, dynamic arg12, dynamic arg13, dynamic arg14, dynamic arg15, dynamic arg16, dynamic arg17, dynamic arg18, dynamic arg19, dynamic arg20, dynamic arg21, dynamic arg22, dynamic arg23, dynamic arg24, dynamic arg25, dynamic arg26, dynamic arg27, dynamic arg28, dynamic arg29, dynamic arg30, dynamic arg31, dynamic arg32, dynamic arg33, dynamic arg34, dynamic arg35, dynamic arg36, dynamic arg37, dynamic arg38, dynamic arg39, dynamic arg40, dynamic arg41, dynamic arg42, dynamic arg43, dynamic arg44, dynamic arg45, dynamic arg46, dynamic arg47, dynamic arg48, dynamic arg49, dynamic arg50, dynamic arg51, dynamic arg52, dynamic arg53, dynamic arg54, dynamic arg55, dynamic arg56, dynamic arg57, dynamic arg58, dynamic arg59, dynamic arg60, dynamic arg61, dynamic arg62, dynamic arg63, dynamic arg64, dynamic arg65, dynamic arg66, dynamic arg67, dynamic arg68, dynamic arg69, dynamic arg70, dynamic arg71, dynamic arg72, dynamic arg73, dynamic arg74, dynamic arg75, dynamic arg76, dynamic arg77, dynamic arg78, dynamic arg79, dynamic arg80, dynamic arg81, dynamic arg82, dynamic arg83, dynamic arg84, dynamic arg85, dynamic arg86, dynamic arg87, dynamic arg88, dynamic arg89, dynamic arg90, dynamic arg91, dynamic arg92, dynamic arg93, dynamic arg94, dynamic arg95, dynamic arg96, dynamic arg97, dynamic arg98, dynamic arg99, dynamic arg100, dynamic arg101, dynamic arg102, dynamic arg103, dynamic arg104, dynamic arg105, dynamic arg106, dynamic arg107, dynamic arg108, dynamic arg109, dynamic arg110, dynamic arg111, dynamic arg112, dynamic arg113, dynamic arg114, dynamic arg115, dynamic arg116, dynamic arg117, dynamic arg118, dynamic arg119, dynamic arg120, dynamic arg121, dynamic arg122, dynamic arg123, dynamic arg124, dynamic arg125, dynamic arg126]) => InvokeHelper<Pointer<Pointer<Opaque>>>(_base, _memory).run(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25, arg26, arg27, arg28, arg29, arg30, arg31, arg32, arg33, arg34, arg35, arg36, arg37, arg38, arg39, arg40, arg41, arg42, arg43, arg44, arg45, arg46, arg47, arg48, arg49, arg50, arg51, arg52, arg53, arg54, arg55, arg56, arg57, arg58, arg59, arg60, arg61, arg62, arg63, arg64, arg65, arg66, arg67, arg68, arg69, arg70, arg71, arg72, arg73, arg74, arg75, arg76, arg77, arg78, arg79, arg80, arg81, arg82, arg83, arg84, arg85, arg86, arg87, arg88, arg89, arg90, arg91, arg92, arg93, arg94, arg95, arg96, arg97, arg98, arg99, arg100, arg101, arg102, arg103, arg104, arg105, arg106, arg107, arg108, arg109, arg110, arg111, arg112, arg113, arg114, arg115, arg116, arg117, arg118, arg119, arg120, arg121, arg122, arg123, arg124, arg125, arg126).cast<Pointer<T>>();
}

/// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
class InvokeHelper<T> {
  final Memory? _memory;
  final Function? _base;

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  const InvokeHelper(this._base, this._memory);

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  InvokeHelper<T> copyWith(Function base, Memory memory) {
    return InvokeHelper(base, memory);
  }

  /// General Library Documentation Undocument By General Corporation & Global Corporation & General Developer
  T run([dynamic arg0, dynamic arg1, dynamic arg2, dynamic arg3, dynamic arg4, dynamic arg5, dynamic arg6, dynamic arg7, dynamic arg8, dynamic arg9, dynamic arg10, dynamic arg11, dynamic arg12, dynamic arg13, dynamic arg14, dynamic arg15, dynamic arg16, dynamic arg17, dynamic arg18, dynamic arg19, dynamic arg20, dynamic arg21, dynamic arg22, dynamic arg23, dynamic arg24, dynamic arg25, dynamic arg26, dynamic arg27, dynamic arg28, dynamic arg29, dynamic arg30, dynamic arg31, dynamic arg32, dynamic arg33, dynamic arg34, dynamic arg35, dynamic arg36, dynamic arg37, dynamic arg38, dynamic arg39, dynamic arg40, dynamic arg41, dynamic arg42, dynamic arg43, dynamic arg44, dynamic arg45, dynamic arg46, dynamic arg47, dynamic arg48, dynamic arg49, dynamic arg50, dynamic arg51, dynamic arg52, dynamic arg53, dynamic arg54, dynamic arg55, dynamic arg56, dynamic arg57, dynamic arg58, dynamic arg59, dynamic arg60, dynamic arg61, dynamic arg62, dynamic arg63, dynamic arg64, dynamic arg65, dynamic arg66, dynamic arg67, dynamic arg68, dynamic arg69, dynamic arg70, dynamic arg71, dynamic arg72, dynamic arg73, dynamic arg74, dynamic arg75, dynamic arg76, dynamic arg77, dynamic arg78, dynamic arg79, dynamic arg80, dynamic arg81, dynamic arg82, dynamic arg83, dynamic arg84, dynamic arg85, dynamic arg86, dynamic arg87, dynamic arg88, dynamic arg89, dynamic arg90, dynamic arg91, dynamic arg92, dynamic arg93, dynamic arg94, dynamic arg95, dynamic arg96, dynamic arg97, dynamic arg98, dynamic arg99, dynamic arg100, dynamic arg101, dynamic arg102, dynamic arg103, dynamic arg104, dynamic arg105, dynamic arg106, dynamic arg107, dynamic arg108, dynamic arg109, dynamic arg110, dynamic arg111, dynamic arg112, dynamic arg113, dynamic arg114, dynamic arg115, dynamic arg116, dynamic arg117, dynamic arg118, dynamic arg119, dynamic arg120, dynamic arg121, dynamic arg122, dynamic arg123, dynamic arg124, dynamic arg125, dynamic arg126]) {
    if (_base == null || _memory == null) {
      throw StateError('Call copyWith first!');
    }
    final Function base = _base;
    final Memory memory = _memory;
    final List<Object> args = [
      arg0,
      arg1,
      arg2,
      arg3,
      arg4,
      arg5,
      arg6,
      arg7,
      arg8,
      arg9,
      arg10,
      arg11,
      arg12,
      arg13,
      arg14,
      arg15,
      arg16,
      arg17,
      arg18,
      arg19,
      arg20,
      arg21,
      arg22,
      arg23,
      arg24,
      arg25,
      arg26,
      arg27,
      arg28,
      arg29,
      arg30,
      arg31,
      arg32,
      arg33,
      arg34,
      arg35,
      arg36,
      arg37,
      arg38,
      arg39,
      arg40,
      arg41,
      arg42,
      arg43,
      arg44,
      arg45,
      arg46,
      arg47,
      arg48,
      arg49,
      arg50,
      arg51,
      arg52,
      arg53,
      arg54,
      arg55,
      arg56,
      arg57,
      arg58,
      arg59,
      arg60,
      arg61,
      arg62,
      arg63,
      arg64,
      arg65,
      arg66,
      arg67,
      arg68,
      arg69,
      arg70,
      arg71,
      arg72,
      arg73,
      arg74,
      arg75,
      arg76,
      arg77,
      arg78,
      arg79,
      arg80,
      arg81,
      arg82,
      arg83,
      arg84,
      arg85,
      arg86,
      arg87,
      arg88,
      arg89,
      arg90,
      arg91,
      arg92,
      arg93,
      arg94,
      arg95,
      arg96,
      arg97,
      arg98,
      arg99,
      arg100,
      arg101,
      arg102,
      arg103,
      arg104,
      arg105,
      arg106,
      arg107,
      arg108,
      arg109,
      arg110,
      arg111,
      arg112,
      arg113,
      arg114,
      arg115,
      arg116,
      arg117,
      arg118,
      arg119,
      arg120,
      arg121,
      arg122,
      arg123,
      arg124,
      arg125,
      arg126,
    ].where((item) => item != null).map((item) => item as Object).toList();
    return execute<T>(base, args, memory);
  }
}
