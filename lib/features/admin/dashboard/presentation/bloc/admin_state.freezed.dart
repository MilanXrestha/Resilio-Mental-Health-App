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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( Map<String, dynamic> stats,  List<dynamic> therapists,  int totalTherapists,  String therapistFilter,  String therapistSearch,  List<dynamic> users,  int totalUsers,  String userRoleFilter,  String userSearch,  List<dynamic> appointments,  int totalAppointments,  String appointmentFilter,  List<dynamic> content,  int totalContent,  String contentFilter,  bool isVerifyingTherapist,  bool isDeletingTherapist,  bool isUpdatingUser,  bool isDeletingContent)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.stats,_that.therapists,_that.totalTherapists,_that.therapistFilter,_that.therapistSearch,_that.users,_that.totalUsers,_that.userRoleFilter,_that.userSearch,_that.appointments,_that.totalAppointments,_that.appointmentFilter,_that.content,_that.totalContent,_that.contentFilter,_that.isVerifyingTherapist,_that.isDeletingTherapist,_that.isUpdatingUser,_that.isDeletingContent);case _Error() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( Map<String, dynamic> stats,  List<dynamic> therapists,  int totalTherapists,  String therapistFilter,  String therapistSearch,  List<dynamic> users,  int totalUsers,  String userRoleFilter,  String userSearch,  List<dynamic> appointments,  int totalAppointments,  String appointmentFilter,  List<dynamic> content,  int totalContent,  String contentFilter,  bool isVerifyingTherapist,  bool isDeletingTherapist,  bool isUpdatingUser,  bool isDeletingContent)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Loaded():
return loaded(_that.stats,_that.therapists,_that.totalTherapists,_that.therapistFilter,_that.therapistSearch,_that.users,_that.totalUsers,_that.userRoleFilter,_that.userSearch,_that.appointments,_that.totalAppointments,_that.appointmentFilter,_that.content,_that.totalContent,_that.contentFilter,_that.isVerifyingTherapist,_that.isDeletingTherapist,_that.isUpdatingUser,_that.isDeletingContent);case _Error():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( Map<String, dynamic> stats,  List<dynamic> therapists,  int totalTherapists,  String therapistFilter,  String therapistSearch,  List<dynamic> users,  int totalUsers,  String userRoleFilter,  String userSearch,  List<dynamic> appointments,  int totalAppointments,  String appointmentFilter,  List<dynamic> content,  int totalContent,  String contentFilter,  bool isVerifyingTherapist,  bool isDeletingTherapist,  bool isUpdatingUser,  bool isDeletingContent)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.stats,_that.therapists,_that.totalTherapists,_that.therapistFilter,_that.therapistSearch,_that.users,_that.totalUsers,_that.userRoleFilter,_that.userSearch,_that.appointments,_that.totalAppointments,_that.appointmentFilter,_that.content,_that.totalContent,_that.contentFilter,_that.isVerifyingTherapist,_that.isDeletingTherapist,_that.isUpdatingUser,_that.isDeletingContent);case _Error() when error != null:
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
  const _Loaded({required final  Map<String, dynamic> stats, final  List<dynamic> therapists = const [], this.totalTherapists = 0, this.therapistFilter = 'all', this.therapistSearch = '', final  List<dynamic> users = const [], this.totalUsers = 0, this.userRoleFilter = 'all', this.userSearch = '', final  List<dynamic> appointments = const [], this.totalAppointments = 0, this.appointmentFilter = 'all', final  List<dynamic> content = const [], this.totalContent = 0, this.contentFilter = 'all', this.isVerifyingTherapist = false, this.isDeletingTherapist = false, this.isUpdatingUser = false, this.isDeletingContent = false}): _stats = stats,_therapists = therapists,_users = users,_appointments = appointments,_content = content;
  

// Dashboard
 final  Map<String, dynamic> _stats;
// Dashboard
 Map<String, dynamic> get stats {
  if (_stats is EqualUnmodifiableMapView) return _stats;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_stats);
}

// Therapists
 final  List<dynamic> _therapists;
// Therapists
@JsonKey() List<dynamic> get therapists {
  if (_therapists is EqualUnmodifiableListView) return _therapists;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_therapists);
}

@JsonKey() final  int totalTherapists;
@JsonKey() final  String therapistFilter;
@JsonKey() final  String therapistSearch;
// Users
 final  List<dynamic> _users;
// Users
@JsonKey() List<dynamic> get users {
  if (_users is EqualUnmodifiableListView) return _users;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_users);
}

@JsonKey() final  int totalUsers;
@JsonKey() final  String userRoleFilter;
@JsonKey() final  String userSearch;
// Appointments
 final  List<dynamic> _appointments;
// Appointments
@JsonKey() List<dynamic> get appointments {
  if (_appointments is EqualUnmodifiableListView) return _appointments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_appointments);
}

@JsonKey() final  int totalAppointments;
@JsonKey() final  String appointmentFilter;
// Content
 final  List<dynamic> _content;
// Content
@JsonKey() List<dynamic> get content {
  if (_content is EqualUnmodifiableListView) return _content;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_content);
}

@JsonKey() final  int totalContent;
@JsonKey() final  String contentFilter;
// Loading states for operations
@JsonKey() final  bool isVerifyingTherapist;
@JsonKey() final  bool isDeletingTherapist;
@JsonKey() final  bool isUpdatingUser;
@JsonKey() final  bool isDeletingContent;

/// Create a copy of AdminState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&const DeepCollectionEquality().equals(other._stats, _stats)&&const DeepCollectionEquality().equals(other._therapists, _therapists)&&(identical(other.totalTherapists, totalTherapists) || other.totalTherapists == totalTherapists)&&(identical(other.therapistFilter, therapistFilter) || other.therapistFilter == therapistFilter)&&(identical(other.therapistSearch, therapistSearch) || other.therapistSearch == therapistSearch)&&const DeepCollectionEquality().equals(other._users, _users)&&(identical(other.totalUsers, totalUsers) || other.totalUsers == totalUsers)&&(identical(other.userRoleFilter, userRoleFilter) || other.userRoleFilter == userRoleFilter)&&(identical(other.userSearch, userSearch) || other.userSearch == userSearch)&&const DeepCollectionEquality().equals(other._appointments, _appointments)&&(identical(other.totalAppointments, totalAppointments) || other.totalAppointments == totalAppointments)&&(identical(other.appointmentFilter, appointmentFilter) || other.appointmentFilter == appointmentFilter)&&const DeepCollectionEquality().equals(other._content, _content)&&(identical(other.totalContent, totalContent) || other.totalContent == totalContent)&&(identical(other.contentFilter, contentFilter) || other.contentFilter == contentFilter)&&(identical(other.isVerifyingTherapist, isVerifyingTherapist) || other.isVerifyingTherapist == isVerifyingTherapist)&&(identical(other.isDeletingTherapist, isDeletingTherapist) || other.isDeletingTherapist == isDeletingTherapist)&&(identical(other.isUpdatingUser, isUpdatingUser) || other.isUpdatingUser == isUpdatingUser)&&(identical(other.isDeletingContent, isDeletingContent) || other.isDeletingContent == isDeletingContent));
}


@override
int get hashCode => Object.hashAll([runtimeType,const DeepCollectionEquality().hash(_stats),const DeepCollectionEquality().hash(_therapists),totalTherapists,therapistFilter,therapistSearch,const DeepCollectionEquality().hash(_users),totalUsers,userRoleFilter,userSearch,const DeepCollectionEquality().hash(_appointments),totalAppointments,appointmentFilter,const DeepCollectionEquality().hash(_content),totalContent,contentFilter,isVerifyingTherapist,isDeletingTherapist,isUpdatingUser,isDeletingContent]);

@override
String toString() {
  return 'AdminState.loaded(stats: $stats, therapists: $therapists, totalTherapists: $totalTherapists, therapistFilter: $therapistFilter, therapistSearch: $therapistSearch, users: $users, totalUsers: $totalUsers, userRoleFilter: $userRoleFilter, userSearch: $userSearch, appointments: $appointments, totalAppointments: $totalAppointments, appointmentFilter: $appointmentFilter, content: $content, totalContent: $totalContent, contentFilter: $contentFilter, isVerifyingTherapist: $isVerifyingTherapist, isDeletingTherapist: $isDeletingTherapist, isUpdatingUser: $isUpdatingUser, isDeletingContent: $isDeletingContent)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $AdminStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@useResult
$Res call({
 Map<String, dynamic> stats, List<dynamic> therapists, int totalTherapists, String therapistFilter, String therapistSearch, List<dynamic> users, int totalUsers, String userRoleFilter, String userSearch, List<dynamic> appointments, int totalAppointments, String appointmentFilter, List<dynamic> content, int totalContent, String contentFilter, bool isVerifyingTherapist, bool isDeletingTherapist, bool isUpdatingUser, bool isDeletingContent
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
@pragma('vm:prefer-inline') $Res call({Object? stats = null,Object? therapists = null,Object? totalTherapists = null,Object? therapistFilter = null,Object? therapistSearch = null,Object? users = null,Object? totalUsers = null,Object? userRoleFilter = null,Object? userSearch = null,Object? appointments = null,Object? totalAppointments = null,Object? appointmentFilter = null,Object? content = null,Object? totalContent = null,Object? contentFilter = null,Object? isVerifyingTherapist = null,Object? isDeletingTherapist = null,Object? isUpdatingUser = null,Object? isDeletingContent = null,}) {
  return _then(_Loaded(
stats: null == stats ? _self._stats : stats // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,therapists: null == therapists ? _self._therapists : therapists // ignore: cast_nullable_to_non_nullable
as List<dynamic>,totalTherapists: null == totalTherapists ? _self.totalTherapists : totalTherapists // ignore: cast_nullable_to_non_nullable
as int,therapistFilter: null == therapistFilter ? _self.therapistFilter : therapistFilter // ignore: cast_nullable_to_non_nullable
as String,therapistSearch: null == therapistSearch ? _self.therapistSearch : therapistSearch // ignore: cast_nullable_to_non_nullable
as String,users: null == users ? _self._users : users // ignore: cast_nullable_to_non_nullable
as List<dynamic>,totalUsers: null == totalUsers ? _self.totalUsers : totalUsers // ignore: cast_nullable_to_non_nullable
as int,userRoleFilter: null == userRoleFilter ? _self.userRoleFilter : userRoleFilter // ignore: cast_nullable_to_non_nullable
as String,userSearch: null == userSearch ? _self.userSearch : userSearch // ignore: cast_nullable_to_non_nullable
as String,appointments: null == appointments ? _self._appointments : appointments // ignore: cast_nullable_to_non_nullable
as List<dynamic>,totalAppointments: null == totalAppointments ? _self.totalAppointments : totalAppointments // ignore: cast_nullable_to_non_nullable
as int,appointmentFilter: null == appointmentFilter ? _self.appointmentFilter : appointmentFilter // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self._content : content // ignore: cast_nullable_to_non_nullable
as List<dynamic>,totalContent: null == totalContent ? _self.totalContent : totalContent // ignore: cast_nullable_to_non_nullable
as int,contentFilter: null == contentFilter ? _self.contentFilter : contentFilter // ignore: cast_nullable_to_non_nullable
as String,isVerifyingTherapist: null == isVerifyingTherapist ? _self.isVerifyingTherapist : isVerifyingTherapist // ignore: cast_nullable_to_non_nullable
as bool,isDeletingTherapist: null == isDeletingTherapist ? _self.isDeletingTherapist : isDeletingTherapist // ignore: cast_nullable_to_non_nullable
as bool,isUpdatingUser: null == isUpdatingUser ? _self.isUpdatingUser : isUpdatingUser // ignore: cast_nullable_to_non_nullable
as bool,isDeletingContent: null == isDeletingContent ? _self.isDeletingContent : isDeletingContent // ignore: cast_nullable_to_non_nullable
as bool,
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
