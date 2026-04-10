// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AdminState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AdminState()';
}


}

/// @nodoc
class $AdminStateCopyWith<$Res>  {
$AdminStateCopyWith(AdminState _, $Res Function(AdminState) __);
}


/// Adds pattern-matching-related methods to [AdminState].
extension AdminStatePatterns on AdminState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Loaded value)?  loaded,TResult Function( _Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Error() when error != null:
return error(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Loaded value)  loaded,required TResult Function( _Error value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Loaded():
return loaded(_that);case _Error():
return error(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Loaded value)?  loaded,TResult? Function( _Error value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Error() when error != null:
return error(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( Map<String, dynamic> stats,  List<dynamic> users,  List<dynamic> pendingTherapists,  List<dynamic> approvedTherapists)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.stats,_that.users,_that.pendingTherapists,_that.approvedTherapists);case _Error() when error != null:
return error(_that.message);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( Map<String, dynamic> stats,  List<dynamic> users,  List<dynamic> pendingTherapists,  List<dynamic> approvedTherapists)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Loaded():
return loaded(_that.stats,_that.users,_that.pendingTherapists,_that.approvedTherapists);case _Error():
return error(_that.message);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( Map<String, dynamic> stats,  List<dynamic> users,  List<dynamic> pendingTherapists,  List<dynamic> approvedTherapists)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.stats,_that.users,_that.pendingTherapists,_that.approvedTherapists);case _Error() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements AdminState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AdminState.initial()';
}


}




/// @nodoc


class _Loading implements AdminState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AdminState.loading()';
}


}




/// @nodoc


class _Loaded implements AdminState {
  const _Loaded({required final  Map<String, dynamic> stats, final  List<dynamic> users = const [], final  List<dynamic> pendingTherapists = const [], final  List<dynamic> approvedTherapists = const []}): _stats = stats,_users = users,_pendingTherapists = pendingTherapists,_approvedTherapists = approvedTherapists;
  

 final  Map<String, dynamic> _stats;
 Map<String, dynamic> get stats {
  if (_stats is EqualUnmodifiableMapView) return _stats;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_stats);
}

 final  List<dynamic> _users;
@JsonKey() List<dynamic> get users {
  if (_users is EqualUnmodifiableListView) return _users;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_users);
}

 final  List<dynamic> _pendingTherapists;
@JsonKey() List<dynamic> get pendingTherapists {
  if (_pendingTherapists is EqualUnmodifiableListView) return _pendingTherapists;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pendingTherapists);
}

 final  List<dynamic> _approvedTherapists;
@JsonKey() List<dynamic> get approvedTherapists {
  if (_approvedTherapists is EqualUnmodifiableListView) return _approvedTherapists;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_approvedTherapists);
}


/// Create a copy of AdminState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&const DeepCollectionEquality().equals(other._stats, _stats)&&const DeepCollectionEquality().equals(other._users, _users)&&const DeepCollectionEquality().equals(other._pendingTherapists, _pendingTherapists)&&const DeepCollectionEquality().equals(other._approvedTherapists, _approvedTherapists));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_stats),const DeepCollectionEquality().hash(_users),const DeepCollectionEquality().hash(_pendingTherapists),const DeepCollectionEquality().hash(_approvedTherapists));

@override
String toString() {
  return 'AdminState.loaded(stats: $stats, users: $users, pendingTherapists: $pendingTherapists, approvedTherapists: $approvedTherapists)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $AdminStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@useResult
$Res call({
 Map<String, dynamic> stats, List<dynamic> users, List<dynamic> pendingTherapists, List<dynamic> approvedTherapists
});




}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of AdminState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? stats = null,Object? users = null,Object? pendingTherapists = null,Object? approvedTherapists = null,}) {
  return _then(_Loaded(
stats: null == stats ? _self._stats : stats // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,users: null == users ? _self._users : users // ignore: cast_nullable_to_non_nullable
as List<dynamic>,pendingTherapists: null == pendingTherapists ? _self._pendingTherapists : pendingTherapists // ignore: cast_nullable_to_non_nullable
as List<dynamic>,approvedTherapists: null == approvedTherapists ? _self._approvedTherapists : approvedTherapists // ignore: cast_nullable_to_non_nullable
as List<dynamic>,
  ));
}


}

/// @nodoc


class _Error implements AdminState {
  const _Error(this.message);
  

 final  String message;

/// Create a copy of AdminState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AdminState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $AdminStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of AdminState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
