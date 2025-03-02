import 'types.dart';

/// A native callable which listens for calls to a native function.
///
/// Creates a native function linked to a Dart function, so that calling the
/// native function will call the Dart function in some way, with the arguments
/// converted to Dart values.
// @Since('3.1')
abstract final class NativeCallable<T extends Function> {
  /// Constructs a [NativeCallable] that must be invoked from the same thread
  /// that created it.
  ///
  /// If an exception is thrown by the [callback], the native function will
  /// return the `exceptionalReturn`, which must be assignable to the return
  /// type of the [callback].
  ///
  /// The returned function address can only be invoked on the mutator (main)
  /// thread of the current isolate. It will abort the process if invoked on any
  /// other thread. Use [NativeCallable.listener] to create callbacks that can
  /// be invoked from any thread.
  ///
  /// Unlike [Pointer.fromFunction], [NativeCallable]s can be constructed from
  /// any Dart function or closure, not just static or top level functions.
  ///
  /// This callback must be [close]d when it is no longer needed. The [Isolate]
  /// that created the callback will be kept alive until [close] is called.
  /// After [NativeCallable.close] is called, invoking the [nativeFunction] from
  /// native code will cause undefined behavior.
  factory NativeCallable.isolateLocal(
    // @DartRepresentationOf("T")
    Function callback, {
    Object? exceptionalReturn,
  }) {
    throw UnsupportedError("NativeCallable cannot be constructed dynamically.");
  }

  /// Constructs a [NativeCallable] that can be invoked from any thread.
  ///
  /// When the native code invokes the function [nativeFunction], the arguments
  /// will be sent over a [SendPort] to the [Isolate] that created the
  /// [NativeCallable], and the callback will be invoked.
  ///
  /// The native code does not wait for a response from the callback, so only
  /// functions returning void are supported.
  ///
  /// The callback will be invoked at some time in the future. The native caller
  /// cannot assume the callback will be run immediately. Resources passed to
  /// the callback (such as pointers to malloc'd memory, or output parameters)
  /// must be valid until the call completes.
  ///
  /// This callback must be [close]d when it is no longer needed. The [Isolate]
  /// that created the callback will be kept alive until [close] is called.
  /// After [NativeCallable.close] is called, invoking the [nativeFunction] from
  /// native code will cause undefined behavior.
  ///
  /// For example:
  ///
  /// ```dart
  /// import 'dart:async';
  /// import 'dart:ffi';
  /// import 'package:ffi/ffi.dart';
  ///
  /// // Processes a simple HTTP GET request using a native HTTP library that
  /// // processes the request on a background thread.
  /// Future<String> httpGet(String uri) async {
  ///   final uriPointer = uri.toNativeUtf8();
  ///
  ///   // Create the NativeCallable.listener.
  ///   final completer = Completer<String>();
  ///   late final NativeCallable<NativeHttpCallback> callback;
  ///   void onResponse(Pointer<Utf8> responsePointer) {
  ///     completer.complete(responsePointer.toDartString());
  ///     calloc.free(responsePointer);
  ///     calloc.free(uriPointer);
  ///
  ///     // Remember to close the NativeCallable once the native API is
  ///     // finished with it, otherwise this isolate will stay alive
  ///     // indefinitely.
  ///     callback.close();
  ///   }
  ///   callback = NativeCallable<NativeHttpCallback>.listener(onResponse);
  ///
  ///   // Invoke the native HTTP API. Our example HTTP library processes our
  ///   // request on a background thread, and calls the callback on that same
  ///   // thread when it receives the response.
  ///   nativeHttpGet(uriPointer, callback.nativeFunction);
  ///
  ///   return completer.future;
  /// }
  ///
  /// // Load the native functions from a DynamicLibrary.
  /// final DynamicLibrary dylib = DynamicLibrary.process();
  /// typedef NativeHttpCallback = Void Function(Pointer<Utf8>);
  ///
  /// typedef HttpGetFunction = void Function(
  ///     Pointer<Utf8>, Pointer<NativeFunction<NativeHttpCallback>>);
  /// typedef HttpGetNativeFunction = Void Function(
  ///     Pointer<Utf8>, Pointer<NativeFunction<NativeHttpCallback>>);
  /// final nativeHttpGet =
  ///     dylib.lookupFunction<HttpGetNativeFunction, HttpGetFunction>(
  ///         'http_get');
  /// ```
  factory NativeCallable.listener(
    // @DartRepresentationOf("T")
    Function callback,
  ) {
    throw UnsupportedError("NativeCallable cannot be constructed dynamically.");
  }

  /// The native function pointer which can be used to invoke the `callback`
  /// passed to the constructor.
  ///
  /// This pointer must not be read after the callable has been [close]d.
  Pointer<NativeFunction<T>> get nativeFunction;

  /// Closes this callback and releases its resources.
  ///
  /// Further calls to existing [nativeFunction]s will result in undefined
  /// behavior.
  ///
  /// Subsequent calls to [close] will be ignored.
  ///
  /// It is safe to call [close] inside the [callback].
  void close();

  /// Whether this [NativeCallable] keeps its [Isolate] alive.
  ///
  /// By default, [NativeCallable]s keep the [Isolate] that created them alive
  /// until [close] is called. If [keepIsolateAlive] is set to `false`, the
  /// isolate may exit even if the [NativeCallable] isn't closed.
  bool keepIsolateAlive = true;
}
