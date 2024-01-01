// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Activity {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get iconName => throw _privateConstructorUsedError;
  ActColor get color => throw _privateConstructorUsedError;
  DateTime get createAt => throw _privateConstructorUsedError;
  DateTime? get deletedAt => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ActivityCopyWith<Activity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActivityCopyWith<$Res> {
  factory $ActivityCopyWith(Activity value, $Res Function(Activity) then) =
      _$ActivityCopyWithImpl<$Res, Activity>;
  @useResult
  $Res call(
      {int id,
      String name,
      String iconName,
      ActColor color,
      DateTime createAt,
      DateTime? deletedAt});
}

/// @nodoc
class _$ActivityCopyWithImpl<$Res, $Val extends Activity>
    implements $ActivityCopyWith<$Res> {
  _$ActivityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? iconName = null,
    Object? color = null,
    Object? createAt = null,
    Object? deletedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      iconName: null == iconName
          ? _value.iconName
          : iconName // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as ActColor,
      createAt: null == createAt
          ? _value.createAt
          : createAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ActivityImplCopyWith<$Res>
    implements $ActivityCopyWith<$Res> {
  factory _$$ActivityImplCopyWith(
          _$ActivityImpl value, $Res Function(_$ActivityImpl) then) =
      __$$ActivityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String iconName,
      ActColor color,
      DateTime createAt,
      DateTime? deletedAt});
}

/// @nodoc
class __$$ActivityImplCopyWithImpl<$Res>
    extends _$ActivityCopyWithImpl<$Res, _$ActivityImpl>
    implements _$$ActivityImplCopyWith<$Res> {
  __$$ActivityImplCopyWithImpl(
      _$ActivityImpl _value, $Res Function(_$ActivityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? iconName = null,
    Object? color = null,
    Object? createAt = null,
    Object? deletedAt = freezed,
  }) {
    return _then(_$ActivityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      iconName: null == iconName
          ? _value.iconName
          : iconName // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as ActColor,
      createAt: null == createAt
          ? _value.createAt
          : createAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$ActivityImpl implements _Activity {
  const _$ActivityImpl(
      {required this.id,
      required this.name,
      required this.iconName,
      required this.color,
      required this.createAt,
      this.deletedAt});

  @override
  final int id;
  @override
  final String name;
  @override
  final String iconName;
  @override
  final ActColor color;
  @override
  final DateTime createAt;
  @override
  final DateTime? deletedAt;

  @override
  String toString() {
    return 'Activity(id: $id, name: $name, iconName: $iconName, color: $color, createAt: $createAt, deletedAt: $deletedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActivityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.iconName, iconName) ||
                other.iconName == iconName) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.createAt, createAt) ||
                other.createAt == createAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, iconName, color, createAt, deletedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ActivityImplCopyWith<_$ActivityImpl> get copyWith =>
      __$$ActivityImplCopyWithImpl<_$ActivityImpl>(this, _$identity);
}

abstract class _Activity implements Activity {
  const factory _Activity(
      {required final int id,
      required final String name,
      required final String iconName,
      required final ActColor color,
      required final DateTime createAt,
      final DateTime? deletedAt}) = _$ActivityImpl;

  @override
  int get id;
  @override
  String get name;
  @override
  String get iconName;
  @override
  ActColor get color;
  @override
  DateTime get createAt;
  @override
  DateTime? get deletedAt;
  @override
  @JsonKey(ignore: true)
  _$$ActivityImplCopyWith<_$ActivityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}