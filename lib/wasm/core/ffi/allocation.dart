import 'annotations.dart';
import 'types.dart';

/// Manages memory on the native heap.
abstract class Allocator {
  /// Allocates byteCount bytes of memory on the native heap.
  ///
  /// The parameter `alignment` is ignored.
  Pointer<T> allocate<T extends NativeType>(int byteCount, {int? alignment});

  /// Releases memory allocated on the native heap.
  void free(Pointer<NativeType> pointer);
}

/// Extension on [Allocator] to provide allocation with [NativeType].
extension AllocatorAlloc on Allocator {
  /// Allocates `sizeOf<T>() * count` bytes of memory using [Allocator.allocate].
  ///
  /// Since this calls [sizeOf<T>] internally, an exception will be thrown if this
  /// method is called with an @[unsized] type or before [initTypes] was called.
  Pointer<T> call<T extends NativeType>([int count = 1]) =>
      allocate(sizeOf<T>() * count);
}
