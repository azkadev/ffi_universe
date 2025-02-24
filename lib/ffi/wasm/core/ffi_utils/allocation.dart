// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../ffi/allocation.dart';
import '../ffi/extensions.dart';
import '../ffi/memory.dart';
import '../ffi/native_finalizer.dart';
import '../ffi/types.dart';

/// Uses global memory instance to manage memory.
///
/// Does not initialize newly allocated memory to zero. Use [_CallocAllocator]
/// for zero-initialized memory on allocation.
final class MallocAllocator implements Allocator {
  const MallocAllocator._();

  /// Allocates [byteCount] bytes of of unitialized memory on the native heap.
  ///
  /// [alignment] is ignored.
  @override
  Pointer<T> allocate<T extends NativeType>(int byteCount, {int? alignment}) {
    final Pointer<T>? result = Memory.global?.allocate(byteCount, alignment: alignment);
    if (result == null || result.address == 0) {
      throw ArgumentError('Could not allocate $byteCount bytes.');
    }
    return result;
  }

  /// Releases memory allocated on the native heap.
  @override
  void free(Pointer pointer) {
    Memory.global?.free(pointer);
  }

  /// Returns a pointer to a native free function.
  ///
  /// This function can be used to release memory allocated by [allocated]
  /// from the native side. It can also be used as a finalization callback
  /// passed to `NativeFinalizer` constructor or `Pointer.atTypedList`
  /// method.
  ///
  /// For example to automatically free native memory when the Dart object
  /// wrapping it is reclaimed by GC:
  ///
  /// ```dart
  /// class Wrapper implements Finalizable {
  ///   static final finalizer = NativeFinalizer(malloc.nativeFree);
  ///
  ///   final Pointer<Uint8> data;
  ///
  ///   Wrapper() : data = malloc.allocate<Uint8>(length) {
  ///     finalizer.attach(this, data);
  ///   }
  /// }
  /// ```
  ///
  /// or to free native memory that is owned by a typed list:
  ///
  /// ```dart
  /// malloc.allocate<Uint8>(n).asTypedList(n, finalizer: malloc.nativeFree)
  /// ```
  ///
  Pointer<NativeFinalizerFunction> get nativeFree => throw UnimplementedError();
}

/// Uses global memory instance to manage memory.
///
/// Does not initialize newly allocated memory to zero. Use [calloc] for
/// zero-initialized memory allocation.
const MallocAllocator malloc = MallocAllocator._();

/// Uses global memory instance to manage memory.
///
/// Initializes newly allocated memory to zero.
final class CallocAllocator implements Allocator {
  const CallocAllocator._();

  /// Fills a block of memory with a specified value.
  void _fillMemory(Pointer destination, int length, int fill) {
    final ptr = destination.cast<Uint8>();
    for (var i = 0; i < length; i++) {
      ptr[i] = fill;
    }
  }

  /// Fills a block of memory with zeros.
  ///
  void _zeroMemory(Pointer destination, int length) => _fillMemory(destination, length, 0);

  /// Allocates [byteCount] bytes of zero-initialized of memory on the native
  /// heap.
  /// [alignment] is ignored.
  @override
  Pointer<T> allocate<T extends NativeType>(int byteCount, {int? alignment}) {
    final Pointer<T>? result = Memory.global?.allocate(byteCount, alignment: alignment);
    if (result == null || result.address == 0) {
      throw ArgumentError('Could not allocate $byteCount bytes.');
    }
    _zeroMemory(result, byteCount);
    return result;
  }

  /// Releases memory allocated on the native heap.
  @override
  void free(Pointer pointer) {
    Memory.global?.free(pointer);
  }

  /// Returns a pointer to a native free function.
  ///
  /// This function can be used to release memory allocated by [allocated]
  /// from the native side. It can also be used as a finalization callback
  /// passed to `NativeFinalizer` constructor or `Pointer.atTypedList`
  /// method.
  ///
  /// For example to automatically free native memory when the Dart object
  /// wrapping it is reclaimed by GC:
  ///
  /// ```dart
  /// class Wrapper implements Finalizable {
  ///   static final finalizer = NativeFinalizer(calloc.nativeFree);
  ///
  ///   final Pointer<Uint8> data;
  ///
  ///   Wrapper() : data = calloc.allocate<Uint8>(length) {
  ///     finalizer.attach(this, data);
  ///   }
  /// }
  /// ```
  ///
  /// or to free native memory that is owned by a typed list:
  ///
  /// ```dart
  /// calloc.allocate<Uint8>(n).asTypedList(n, finalizer: calloc.nativeFree)
  /// ```
  ///
  Pointer<NativeFinalizerFunction> get nativeFree => throw UnimplementedError();
}

/// Uses global memory instance to manage memory.
///
/// Initializes newly allocated memory to zero. Use [malloc] for uninitialized
/// memory allocation.
const CallocAllocator calloc = CallocAllocator._();
