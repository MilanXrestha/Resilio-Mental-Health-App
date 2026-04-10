// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'therapist_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TherapistState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TherapistState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TherapistState()';
}


}

/// @nodoc
class $TherapistStateCopyWith<$Res>  {
$TherapistStateCopyWith(TherapistState _, $Res Function(TherapistState) __);
}


/// Adds pattern-matching-related methods to [TherapistState].
extension TherapistStatePatterns on TherapistState {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( Map<String, dynamic> profile,  List<dynamic> todayAppointments,  List<dynamic> upcomingAppointments)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.profile,_that.todayAppointments,_that.upcomingAppointments);case _Error() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( Map<String, dynamic> profile,  List<dynamic> todayAppointments,  List<dynamic> upcomingAppointments)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Loaded():
return loaded(_that.profile,_that.todayAppointments,_that.upcomingAppointments);case _Error():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( Map<String, dynamic> profile,  List<dynamic> todayAppointments,  List<dynamic> upcomingAppointments)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.profile,_that.todayAppointments,_that.upcomingAppointments);case _Error() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements TherapistState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TherapistState.initial()';
}


}




/// @nodoc


class _Loading implements TherapistState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TherapistState.loading()';
}


}




/// @nodoc


class _Loaded implements TherapistState {
  const _Loaded({required final  Map<String, dynamic> profile, final  List<dynamic> todayAppointments = const [], final  List<dynamic> upcomingAppointments = const []}): _profile = profile,_todayAppointments = todayAppointments,_upcomingAppointments = upcomingAppointments;
  

 final  Map<String, dynamic> _profile;
 Map<String, dynamic> get profile {
  if (_profile is EqualUnmodifiableMapView) return _profile;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_profile);
}

 final  List<dynamic> _todayAppointments;
@JsonKey() List<dynamic> get todayAppointments {
  if (_todayAppointments is EqualUnmodifiableListView) return _todayAppointments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_todayAppointments);
}

 final  List<dynamic> _upcomingAppointments;
@JsonKey() List<dynamic> get upcomingAppointments {
  if (_upcomingAppointments is EqualUnmodifiableListView) return _upcomingAppointments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_upcomingAppointments);
}


/// Create a copy of TherapistState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&const DeepCollectionEquality().equals(other._profile, _profile)&&const DeepCollectionEquality().equals(other._todayAppointments, _todayAppointments)&&const DeepCollectionEquality().equals(other._upcomingAppointments, _upcomingAppointments));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_profile),const DeepCollectionEquality().hash(_todayAppointments),const DeepCollectionEquality().hash(_upcomingAppointments));

@override
String toString() {
  return 'TherapistState.loaded(profile: $profile, todayAppointments: $todayAppointments, upcomingAppointments: $upcomingAppointments)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $TherapistStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@useResult
$Res call({
 Map<String, dynamic> profile, List<dynamic> todayAppointments, List<dynamic> upcomingAppointments
});




}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of TherapistState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? profile = null,Object? todayAppointments = null,Object? upcomingAppointments = null,}) {
  return _then(_Loaded(
profile: null == profile ? _self._profile : profile // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,todayAppointments: null == todayAppointments ? _self._todayAppointments : todayAppointments // ignore: cast_nullable_to_non_nullable
as List<dynamic>,upcomingAppointments: null == upcomingAppointments ? _self._upcomingAppointments : upcomingAppointments // ignore: cast_nullable_to_non_nullable
as List<dynamic>,
  ));
}


}

/// @nodoc


class _Error implements TherapistState {
  const _Error(this.message);
  

 final  String message;

/// Create a copy of TherapistState
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
  return 'TherapistState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $TherapistStateCopyWith<$Res> {
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

/// Create a copy of TherapistState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
