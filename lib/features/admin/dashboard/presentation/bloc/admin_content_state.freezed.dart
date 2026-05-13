// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_content_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AdminContentState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminContentState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AdminContentState()';
}


}

/// @nodoc
class $AdminContentStateCopyWith<$Res>  {
$AdminContentStateCopyWith(AdminContentState _, $Res Function(AdminContentState) __);
}


/// Adds pattern-matching-related methods to [AdminContentState].
extension AdminContentStatePatterns on AdminContentState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Error value)?  error,TResult Function( _Loaded value)?  loaded,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Error() when error != null:
return error(_that);case _Loaded() when loaded != null:
return loaded(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Error value)  error,required TResult Function( _Loaded value)  loaded,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Error():
return error(_that);case _Loaded():
return loaded(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Error value)?  error,TResult? Function( _Loaded value)?  loaded,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Error() when error != null:
return error(_that);case _Loaded() when loaded != null:
return loaded(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( String message)?  error,TResult Function( List<dynamic> tips,  int totalTips,  String tipSearch,  List<dynamic> quotes,  int totalQuotes,  String quoteSearch,  List<dynamic> audio,  int totalAudio,  String audioSearch,  List<dynamic> videos,  int totalVideos,  String videoSearch,  String videoTypeFilter,  List<dynamic> images,  int totalImages,  String imageSearch,  bool isCreating,  bool isUpdating,  bool isDeleting,  int selectedContentTab)?  loaded,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Error() when error != null:
return error(_that.message);case _Loaded() when loaded != null:
return loaded(_that.tips,_that.totalTips,_that.tipSearch,_that.quotes,_that.totalQuotes,_that.quoteSearch,_that.audio,_that.totalAudio,_that.audioSearch,_that.videos,_that.totalVideos,_that.videoSearch,_that.videoTypeFilter,_that.images,_that.totalImages,_that.imageSearch,_that.isCreating,_that.isUpdating,_that.isDeleting,_that.selectedContentTab);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( String message)  error,required TResult Function( List<dynamic> tips,  int totalTips,  String tipSearch,  List<dynamic> quotes,  int totalQuotes,  String quoteSearch,  List<dynamic> audio,  int totalAudio,  String audioSearch,  List<dynamic> videos,  int totalVideos,  String videoSearch,  String videoTypeFilter,  List<dynamic> images,  int totalImages,  String imageSearch,  bool isCreating,  bool isUpdating,  bool isDeleting,  int selectedContentTab)  loaded,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Error():
return error(_that.message);case _Loaded():
return loaded(_that.tips,_that.totalTips,_that.tipSearch,_that.quotes,_that.totalQuotes,_that.quoteSearch,_that.audio,_that.totalAudio,_that.audioSearch,_that.videos,_that.totalVideos,_that.videoSearch,_that.videoTypeFilter,_that.images,_that.totalImages,_that.imageSearch,_that.isCreating,_that.isUpdating,_that.isDeleting,_that.selectedContentTab);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( String message)?  error,TResult? Function( List<dynamic> tips,  int totalTips,  String tipSearch,  List<dynamic> quotes,  int totalQuotes,  String quoteSearch,  List<dynamic> audio,  int totalAudio,  String audioSearch,  List<dynamic> videos,  int totalVideos,  String videoSearch,  String videoTypeFilter,  List<dynamic> images,  int totalImages,  String imageSearch,  bool isCreating,  bool isUpdating,  bool isDeleting,  int selectedContentTab)?  loaded,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Error() when error != null:
return error(_that.message);case _Loaded() when loaded != null:
return loaded(_that.tips,_that.totalTips,_that.tipSearch,_that.quotes,_that.totalQuotes,_that.quoteSearch,_that.audio,_that.totalAudio,_that.audioSearch,_that.videos,_that.totalVideos,_that.videoSearch,_that.videoTypeFilter,_that.images,_that.totalImages,_that.imageSearch,_that.isCreating,_that.isUpdating,_that.isDeleting,_that.selectedContentTab);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements AdminContentState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AdminContentState.initial()';
}


}




/// @nodoc


class _Loading implements AdminContentState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AdminContentState.loading()';
}


}




/// @nodoc


class _Error implements AdminContentState {
  const _Error(this.message);
  

 final  String message;

/// Create a copy of AdminContentState
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
  return 'AdminContentState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $AdminContentStateCopyWith<$Res> {
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

/// Create a copy of AdminContentState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _Loaded implements AdminContentState {
  const _Loaded({final  List<dynamic> tips = const [], this.totalTips = 0, this.tipSearch = '', final  List<dynamic> quotes = const [], this.totalQuotes = 0, this.quoteSearch = '', final  List<dynamic> audio = const [], this.totalAudio = 0, this.audioSearch = '', final  List<dynamic> videos = const [], this.totalVideos = 0, this.videoSearch = '', this.videoTypeFilter = 'all', final  List<dynamic> images = const [], this.totalImages = 0, this.imageSearch = '', this.isCreating = false, this.isUpdating = false, this.isDeleting = false, this.selectedContentTab = 0}): _tips = tips,_quotes = quotes,_audio = audio,_videos = videos,_images = images;
  

// Tips
 final  List<dynamic> _tips;
// Tips
@JsonKey() List<dynamic> get tips {
  if (_tips is EqualUnmodifiableListView) return _tips;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tips);
}

@JsonKey() final  int totalTips;
@JsonKey() final  String tipSearch;
// Quotes
 final  List<dynamic> _quotes;
// Quotes
@JsonKey() List<dynamic> get quotes {
  if (_quotes is EqualUnmodifiableListView) return _quotes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_quotes);
}

@JsonKey() final  int totalQuotes;
@JsonKey() final  String quoteSearch;
// Audio
 final  List<dynamic> _audio;
// Audio
@JsonKey() List<dynamic> get audio {
  if (_audio is EqualUnmodifiableListView) return _audio;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_audio);
}

@JsonKey() final  int totalAudio;
@JsonKey() final  String audioSearch;
// Videos
 final  List<dynamic> _videos;
// Videos
@JsonKey() List<dynamic> get videos {
  if (_videos is EqualUnmodifiableListView) return _videos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_videos);
}

@JsonKey() final  int totalVideos;
@JsonKey() final  String videoSearch;
@JsonKey() final  String videoTypeFilter;
// Images
 final  List<dynamic> _images;
// Images
@JsonKey() List<dynamic> get images {
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_images);
}

@JsonKey() final  int totalImages;
@JsonKey() final  String imageSearch;
// Operation states
@JsonKey() final  bool isCreating;
@JsonKey() final  bool isUpdating;
@JsonKey() final  bool isDeleting;
@JsonKey() final  int selectedContentTab;

/// Create a copy of AdminContentState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&const DeepCollectionEquality().equals(other._tips, _tips)&&(identical(other.totalTips, totalTips) || other.totalTips == totalTips)&&(identical(other.tipSearch, tipSearch) || other.tipSearch == tipSearch)&&const DeepCollectionEquality().equals(other._quotes, _quotes)&&(identical(other.totalQuotes, totalQuotes) || other.totalQuotes == totalQuotes)&&(identical(other.quoteSearch, quoteSearch) || other.quoteSearch == quoteSearch)&&const DeepCollectionEquality().equals(other._audio, _audio)&&(identical(other.totalAudio, totalAudio) || other.totalAudio == totalAudio)&&(identical(other.audioSearch, audioSearch) || other.audioSearch == audioSearch)&&const DeepCollectionEquality().equals(other._videos, _videos)&&(identical(other.totalVideos, totalVideos) || other.totalVideos == totalVideos)&&(identical(other.videoSearch, videoSearch) || other.videoSearch == videoSearch)&&(identical(other.videoTypeFilter, videoTypeFilter) || other.videoTypeFilter == videoTypeFilter)&&const DeepCollectionEquality().equals(other._images, _images)&&(identical(other.totalImages, totalImages) || other.totalImages == totalImages)&&(identical(other.imageSearch, imageSearch) || other.imageSearch == imageSearch)&&(identical(other.isCreating, isCreating) || other.isCreating == isCreating)&&(identical(other.isUpdating, isUpdating) || other.isUpdating == isUpdating)&&(identical(other.isDeleting, isDeleting) || other.isDeleting == isDeleting)&&(identical(other.selectedContentTab, selectedContentTab) || other.selectedContentTab == selectedContentTab));
}


@override
int get hashCode => Object.hashAll([runtimeType,const DeepCollectionEquality().hash(_tips),totalTips,tipSearch,const DeepCollectionEquality().hash(_quotes),totalQuotes,quoteSearch,const DeepCollectionEquality().hash(_audio),totalAudio,audioSearch,const DeepCollectionEquality().hash(_videos),totalVideos,videoSearch,videoTypeFilter,const DeepCollectionEquality().hash(_images),totalImages,imageSearch,isCreating,isUpdating,isDeleting,selectedContentTab]);

@override
String toString() {
  return 'AdminContentState.loaded(tips: $tips, totalTips: $totalTips, tipSearch: $tipSearch, quotes: $quotes, totalQuotes: $totalQuotes, quoteSearch: $quoteSearch, audio: $audio, totalAudio: $totalAudio, audioSearch: $audioSearch, videos: $videos, totalVideos: $totalVideos, videoSearch: $videoSearch, videoTypeFilter: $videoTypeFilter, images: $images, totalImages: $totalImages, imageSearch: $imageSearch, isCreating: $isCreating, isUpdating: $isUpdating, isDeleting: $isDeleting, selectedContentTab: $selectedContentTab)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $AdminContentStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@useResult
$Res call({
 List<dynamic> tips, int totalTips, String tipSearch, List<dynamic> quotes, int totalQuotes, String quoteSearch, List<dynamic> audio, int totalAudio, String audioSearch, List<dynamic> videos, int totalVideos, String videoSearch, String videoTypeFilter, List<dynamic> images, int totalImages, String imageSearch, bool isCreating, bool isUpdating, bool isDeleting, int selectedContentTab
});




}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of AdminContentState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tips = null,Object? totalTips = null,Object? tipSearch = null,Object? quotes = null,Object? totalQuotes = null,Object? quoteSearch = null,Object? audio = null,Object? totalAudio = null,Object? audioSearch = null,Object? videos = null,Object? totalVideos = null,Object? videoSearch = null,Object? videoTypeFilter = null,Object? images = null,Object? totalImages = null,Object? imageSearch = null,Object? isCreating = null,Object? isUpdating = null,Object? isDeleting = null,Object? selectedContentTab = null,}) {
  return _then(_Loaded(
tips: null == tips ? _self._tips : tips // ignore: cast_nullable_to_non_nullable
as List<dynamic>,totalTips: null == totalTips ? _self.totalTips : totalTips // ignore: cast_nullable_to_non_nullable
as int,tipSearch: null == tipSearch ? _self.tipSearch : tipSearch // ignore: cast_nullable_to_non_nullable
as String,quotes: null == quotes ? _self._quotes : quotes // ignore: cast_nullable_to_non_nullable
as List<dynamic>,totalQuotes: null == totalQuotes ? _self.totalQuotes : totalQuotes // ignore: cast_nullable_to_non_nullable
as int,quoteSearch: null == quoteSearch ? _self.quoteSearch : quoteSearch // ignore: cast_nullable_to_non_nullable
as String,audio: null == audio ? _self._audio : audio // ignore: cast_nullable_to_non_nullable
as List<dynamic>,totalAudio: null == totalAudio ? _self.totalAudio : totalAudio // ignore: cast_nullable_to_non_nullable
as int,audioSearch: null == audioSearch ? _self.audioSearch : audioSearch // ignore: cast_nullable_to_non_nullable
as String,videos: null == videos ? _self._videos : videos // ignore: cast_nullable_to_non_nullable
as List<dynamic>,totalVideos: null == totalVideos ? _self.totalVideos : totalVideos // ignore: cast_nullable_to_non_nullable
as int,videoSearch: null == videoSearch ? _self.videoSearch : videoSearch // ignore: cast_nullable_to_non_nullable
as String,videoTypeFilter: null == videoTypeFilter ? _self.videoTypeFilter : videoTypeFilter // ignore: cast_nullable_to_non_nullable
as String,images: null == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<dynamic>,totalImages: null == totalImages ? _self.totalImages : totalImages // ignore: cast_nullable_to_non_nullable
as int,imageSearch: null == imageSearch ? _self.imageSearch : imageSearch // ignore: cast_nullable_to_non_nullable
as String,isCreating: null == isCreating ? _self.isCreating : isCreating // ignore: cast_nullable_to_non_nullable
as bool,isUpdating: null == isUpdating ? _self.isUpdating : isUpdating // ignore: cast_nullable_to_non_nullable
as bool,isDeleting: null == isDeleting ? _self.isDeleting : isDeleting // ignore: cast_nullable_to_non_nullable
as bool,selectedContentTab: null == selectedContentTab ? _self.selectedContentTab : selectedContentTab // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
