import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_content_state.freezed.dart';

@freezed
class AdminContentState with _$AdminContentState {
  const factory AdminContentState.initial() = _Initial;
  const factory AdminContentState.loading() = _Loading;
  const factory AdminContentState.error(String message) = _Error;

  const factory AdminContentState.loaded({
    // Tips
    @Default([]) List<dynamic> tips,
    @Default(0) int totalTips,
    @Default('') String tipSearch,

    // Quotes
    @Default([]) List<dynamic> quotes,
    @Default(0) int totalQuotes,
    @Default('') String quoteSearch,

    // Audio
    @Default([]) List<dynamic> audio,
    @Default(0) int totalAudio,
    @Default('') String audioSearch,

    // Videos
    @Default([]) List<dynamic> videos,
    @Default(0) int totalVideos,
    @Default('') String videoSearch,
    @Default('all') String videoTypeFilter,

    // Images
    @Default([]) List<dynamic> images,
    @Default(0) int totalImages,
    @Default('') String imageSearch,

    // Operation states
    @Default(false) bool isCreating,
    @Default(false) bool isUpdating,
    @Default(false) bool isDeleting,
    @Default(0) int selectedContentTab,
  }) = _Loaded;
}
