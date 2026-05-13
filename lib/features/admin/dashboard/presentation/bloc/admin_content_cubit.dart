import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:Resilio/features/admin/dashboard/domain/repositories/admin_repository.dart';
import 'admin_content_state.dart';

@injectable
class AdminContentCubit extends Cubit<AdminContentState> {
  final AdminRepository _repository;

  AdminContentCubit(this._repository) : super(const AdminContentState.initial());

  AdminContentState _loaded() {
    return state.maybeMap(
      loaded: (s) => s,
      orElse: () => const AdminContentState.loaded(),
    );
  }

  void setTab(int index) {
    emit(state.maybeMap(
      loaded: (s) => s.copyWith(selectedContentTab: index),
      orElse: () => AdminContentState.loaded(selectedContentTab: index),
    ));
  }

  // ─── Tips ───────────────────────────────────────────
  Future<void> loadTips({String search = ''}) async {
    try {
      final result = await _repository.getTips(search: search);
      final tips = result['tips'] as List<dynamic>? ?? [];
      final total = result['total'] as int? ?? 0;
      emit(state.maybeMap(
        loaded: (s) => s.copyWith(tips: tips, totalTips: total, tipSearch: search),
        orElse: () => AdminContentState.loaded(tips: tips, totalTips: total, tipSearch: search),
      ));
    } catch (e) {
      emit(AdminContentState.error(e.toString()));
    }
  }

  Future<bool> createTip(Map<String, dynamic> data) async {
    emit(state.maybeMap(loaded: (s) => s.copyWith(isCreating: true), orElse: () => _loaded()));
    try {
      await _repository.createTip(data);
      await loadTips();
      return true;
    } catch (e) {
      emit(AdminContentState.error(e.toString()));
      return false;
    } finally {
      emit(state.maybeMap(loaded: (s) => s.copyWith(isCreating: false), orElse: () => _loaded()));
    }
  }

  Future<bool> updateTip(String id, Map<String, dynamic> data) async {
    emit(state.maybeMap(loaded: (s) => s.copyWith(isUpdating: true), orElse: () => _loaded()));
    try {
      await _repository.updateTip(id, data);
      await loadTips();
      return true;
    } catch (e) {
      emit(AdminContentState.error(e.toString()));
      return false;
    } finally {
      emit(state.maybeMap(loaded: (s) => s.copyWith(isUpdating: false), orElse: () => _loaded()));
    }
  }

  Future<bool> deleteTip(String id) async {
    emit(state.maybeMap(loaded: (s) => s.copyWith(isDeleting: true), orElse: () => _loaded()));
    try {
      await _repository.deleteTip(id);
      await loadTips();
      return true;
    } catch (e) {
      emit(AdminContentState.error(e.toString()));
      return false;
    } finally {
      emit(state.maybeMap(loaded: (s) => s.copyWith(isDeleting: false), orElse: () => _loaded()));
    }
  }

  // ─── Quotes ─────────────────────────────────────────
  Future<void> loadQuotes({String search = ''}) async {
    try {
      final result = await _repository.getQuotes(search: search);
      final quotes = result['quotes'] as List<dynamic>? ?? [];
      final total = result['total'] as int? ?? 0;
      emit(state.maybeMap(
        loaded: (s) => s.copyWith(quotes: quotes, totalQuotes: total, quoteSearch: search),
        orElse: () => AdminContentState.loaded(quotes: quotes, totalQuotes: total, quoteSearch: search),
      ));
    } catch (e) {
      emit(AdminContentState.error(e.toString()));
    }
  }

  Future<bool> createQuote(Map<String, dynamic> data) async {
    emit(state.maybeMap(loaded: (s) => s.copyWith(isCreating: true), orElse: () => _loaded()));
    try {
      await _repository.createQuote(data);
      await loadQuotes();
      return true;
    } catch (e) {
      emit(AdminContentState.error(e.toString()));
      return false;
    } finally {
      emit(state.maybeMap(loaded: (s) => s.copyWith(isCreating: false), orElse: () => _loaded()));
    }
  }

  Future<bool> updateQuote(String id, Map<String, dynamic> data) async {
    emit(state.maybeMap(loaded: (s) => s.copyWith(isUpdating: true), orElse: () => _loaded()));
    try {
      await _repository.updateQuote(id, data);
      await loadQuotes();
      return true;
    } catch (e) {
      emit(AdminContentState.error(e.toString()));
      return false;
    } finally {
      emit(state.maybeMap(loaded: (s) => s.copyWith(isUpdating: false), orElse: () => _loaded()));
    }
  }

  Future<bool> deleteQuote(String id) async {
    emit(state.maybeMap(loaded: (s) => s.copyWith(isDeleting: true), orElse: () => _loaded()));
    try {
      await _repository.deleteQuote(id);
      await loadQuotes();
      return true;
    } catch (e) {
      emit(AdminContentState.error(e.toString()));
      return false;
    } finally {
      emit(state.maybeMap(loaded: (s) => s.copyWith(isDeleting: false), orElse: () => _loaded()));
    }
  }

  // ─── Audio ──────────────────────────────────────────
  Future<void> loadAudio({String search = ''}) async {
    try {
      final result = await _repository.getAudio(search: search);
      final audio = result['audio'] as List<dynamic>? ?? [];
      final total = result['total'] as int? ?? 0;
      emit(state.maybeMap(
        loaded: (s) => s.copyWith(audio: audio, totalAudio: total, audioSearch: search),
        orElse: () => AdminContentState.loaded(audio: audio, totalAudio: total, audioSearch: search),
      ));
    } catch (e) {
      emit(AdminContentState.error(e.toString()));
    }
  }

  Future<bool> createAudio(Map<String, dynamic> data) async {
    emit(state.maybeMap(loaded: (s) => s.copyWith(isCreating: true), orElse: () => _loaded()));
    try {
      await _repository.createAudio(data);
      await loadAudio();
      return true;
    } catch (e) {
      emit(AdminContentState.error(e.toString()));
      return false;
    } finally {
      emit(state.maybeMap(loaded: (s) => s.copyWith(isCreating: false), orElse: () => _loaded()));
    }
  }

  Future<bool> updateAudio(String id, Map<String, dynamic> data) async {
    emit(state.maybeMap(loaded: (s) => s.copyWith(isUpdating: true), orElse: () => _loaded()));
    try {
      await _repository.updateAudio(id, data);
      await loadAudio();
      return true;
    } catch (e) {
      emit(AdminContentState.error(e.toString()));
      return false;
    } finally {
      emit(state.maybeMap(loaded: (s) => s.copyWith(isUpdating: false), orElse: () => _loaded()));
    }
  }

  Future<bool> deleteAudio(String id) async {
    emit(state.maybeMap(loaded: (s) => s.copyWith(isDeleting: true), orElse: () => _loaded()));
    try {
      await _repository.deleteAudio(id);
      await loadAudio();
      return true;
    } catch (e) {
      emit(AdminContentState.error(e.toString()));
      return false;
    } finally {
      emit(state.maybeMap(loaded: (s) => s.copyWith(isDeleting: false), orElse: () => _loaded()));
    }
  }

  // ─── Videos ─────────────────────────────────────────
  Future<void> loadVideos({String search = '', String videoType = 'all'}) async {
    try {
      final result = await _repository.getVideos(search: search, videoType: videoType);
      final videos = result['videos'] as List<dynamic>? ?? [];
      final total = result['total'] as int? ?? 0;
      emit(state.maybeMap(
        loaded: (s) => s.copyWith(videos: videos, totalVideos: total, videoSearch: search, videoTypeFilter: videoType),
        orElse: () => AdminContentState.loaded(videos: videos, totalVideos: total, videoSearch: search, videoTypeFilter: videoType),
      ));
    } catch (e) {
      emit(AdminContentState.error(e.toString()));
    }
  }

  Future<bool> createVideo(Map<String, dynamic> data) async {
    emit(state.maybeMap(loaded: (s) => s.copyWith(isCreating: true), orElse: () => _loaded()));
    try {
      await _repository.createVideo(data);
      await loadVideos();
      return true;
    } catch (e) {
      emit(AdminContentState.error(e.toString()));
      return false;
    } finally {
      emit(state.maybeMap(loaded: (s) => s.copyWith(isCreating: false), orElse: () => _loaded()));
    }
  }

  Future<bool> updateVideo(String id, Map<String, dynamic> data) async {
    emit(state.maybeMap(loaded: (s) => s.copyWith(isUpdating: true), orElse: () => _loaded()));
    try {
      await _repository.updateVideo(id, data);
      await loadVideos();
      return true;
    } catch (e) {
      emit(AdminContentState.error(e.toString()));
      return false;
    } finally {
      emit(state.maybeMap(loaded: (s) => s.copyWith(isUpdating: false), orElse: () => _loaded()));
    }
  }

  Future<bool> deleteVideo(String id) async {
    emit(state.maybeMap(loaded: (s) => s.copyWith(isDeleting: true), orElse: () => _loaded()));
    try {
      await _repository.deleteVideo(id);
      await loadVideos();
      return true;
    } catch (e) {
      emit(AdminContentState.error(e.toString()));
      return false;
    } finally {
      emit(state.maybeMap(loaded: (s) => s.copyWith(isDeleting: false), orElse: () => _loaded()));
    }
  }

  // ─── Images ─────────────────────────────────────────
  Future<void> loadImages({String search = ''}) async {
    try {
      final result = await _repository.getImages(search: search);
      final images = result['images'] as List<dynamic>? ?? [];
      final total = result['total'] as int? ?? 0;
      emit(state.maybeMap(
        loaded: (s) => s.copyWith(images: images, totalImages: total, imageSearch: search),
        orElse: () => AdminContentState.loaded(images: images, totalImages: total, imageSearch: search),
      ));
    } catch (e) {
      emit(AdminContentState.error(e.toString()));
    }
  }

  Future<bool> createImage(Map<String, dynamic> data) async {
    emit(state.maybeMap(loaded: (s) => s.copyWith(isCreating: true), orElse: () => _loaded()));
    try {
      await _repository.createImage(data);
      await loadImages();
      return true;
    } catch (e) {
      emit(AdminContentState.error(e.toString()));
      return false;
    } finally {
      emit(state.maybeMap(loaded: (s) => s.copyWith(isCreating: false), orElse: () => _loaded()));
    }
  }

  Future<bool> updateImage(String id, Map<String, dynamic> data) async {
    emit(state.maybeMap(loaded: (s) => s.copyWith(isUpdating: true), orElse: () => _loaded()));
    try {
      await _repository.updateImage(id, data);
      await loadImages();
      return true;
    } catch (e) {
      emit(AdminContentState.error(e.toString()));
      return false;
    } finally {
      emit(state.maybeMap(loaded: (s) => s.copyWith(isUpdating: false), orElse: () => _loaded()));
    }
  }

  Future<bool> deleteImage(String id) async {
    emit(state.maybeMap(loaded: (s) => s.copyWith(isDeleting: true), orElse: () => _loaded()));
    try {
      await _repository.deleteImage(id);
      await loadImages();
      return true;
    } catch (e) {
      emit(AdminContentState.error(e.toString()));
      return false;
    } finally {
      emit(state.maybeMap(loaded: (s) => s.copyWith(isDeleting: false), orElse: () => _loaded()));
    }
  }
}
