// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'records.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$recordsNotifierHash() => r'7d2310634e84ed7099baae63481feb93cfde8f2c';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$RecordsNotifier
    extends BuildlessAutoDisposeAsyncNotifier<List<Record>> {
  late final String actId;

  FutureOr<List<Record>> build(
    String actId,
  );
}

/// See also [RecordsNotifier].
@ProviderFor(RecordsNotifier)
const recordsNotifierProvider = RecordsNotifierFamily();

/// See also [RecordsNotifier].
class RecordsNotifierFamily extends Family<AsyncValue<List<Record>>> {
  /// See also [RecordsNotifier].
  const RecordsNotifierFamily();

  /// See also [RecordsNotifier].
  RecordsNotifierProvider call(
    String actId,
  ) {
    return RecordsNotifierProvider(
      actId,
    );
  }

  @override
  RecordsNotifierProvider getProviderOverride(
    covariant RecordsNotifierProvider provider,
  ) {
    return call(
      provider.actId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'recordsNotifierProvider';
}

/// See also [RecordsNotifier].
class RecordsNotifierProvider extends AutoDisposeAsyncNotifierProviderImpl<
    RecordsNotifier, List<Record>> {
  /// See also [RecordsNotifier].
  RecordsNotifierProvider(
    String actId,
  ) : this._internal(
          () => RecordsNotifier()..actId = actId,
          from: recordsNotifierProvider,
          name: r'recordsNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$recordsNotifierHash,
          dependencies: RecordsNotifierFamily._dependencies,
          allTransitiveDependencies:
              RecordsNotifierFamily._allTransitiveDependencies,
          actId: actId,
        );

  RecordsNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.actId,
  }) : super.internal();

  final String actId;

  @override
  FutureOr<List<Record>> runNotifierBuild(
    covariant RecordsNotifier notifier,
  ) {
    return notifier.build(
      actId,
    );
  }

  @override
  Override overrideWith(RecordsNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: RecordsNotifierProvider._internal(
        () => create()..actId = actId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        actId: actId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<RecordsNotifier, List<Record>>
      createElement() {
    return _RecordsNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RecordsNotifierProvider && other.actId == actId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, actId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin RecordsNotifierRef on AutoDisposeAsyncNotifierProviderRef<List<Record>> {
  /// The parameter `actId` of this provider.
  String get actId;
}

class _RecordsNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<RecordsNotifier,
        List<Record>> with RecordsNotifierRef {
  _RecordsNotifierProviderElement(super.provider);

  @override
  String get actId => (origin as RecordsNotifierProvider).actId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
