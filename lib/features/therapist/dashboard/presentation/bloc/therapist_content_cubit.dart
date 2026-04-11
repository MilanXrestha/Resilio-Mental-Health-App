import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repositories/therapist_repository.dart';

abstract class TherapistContentState {
  const TherapistContentState();
}

class TherapistContentInitial extends TherapistContentState {
  const TherapistContentInitial();
}

class TherapistContentLoading extends TherapistContentState {
  const TherapistContentLoading();
}

class TherapistContentError extends TherapistContentState {
  final String message;
  const TherapistContentError(this.message);
}

class TherapistContentLoaded extends TherapistContentState {
  final String activeTab; // 'tips', 'quotes', 'videos', 'audio'
  final List<Map<String, dynamic>> items;
  final bool isSubmitting;
  
  const TherapistContentLoaded({
    required this.activeTab,
    required this.items,
    this.isSubmitting = false,
  });

  TherapistContentLoaded copyWith({
    String? activeTab,
    List<Map<String, dynamic>>? items,
    bool? isSubmitting,
  }) {
    return TherapistContentLoaded(
      activeTab: activeTab ?? this.activeTab,
      items: items ?? this.items,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }
}

@injectable
class TherapistContentCubit extends Cubit<TherapistContentState> {
  final TherapistRepository _repository;

  TherapistContentCubit(this._repository) : super(const TherapistContentInitial());

  Future<void> loadContent(String type) async {
    emit(const TherapistContentLoading());
    try {
      final items = await _repository.getContent(type);
      emit(TherapistContentLoaded(activeTab: type, items: items));
    } catch (e) {
      emit(TherapistContentError(e.toString()));
    }
  }

  Future<void> switchTab(String type) async {
    if (state is TherapistContentLoaded) {
      final curr = state as TherapistContentLoaded;
      if (curr.activeTab == type) return;
    }
    await loadContent(type);
  }

  Future<bool> createContent(Map<String, dynamic> data) async {
    if (state is! TherapistContentLoaded) return false;
    final curr = state as TherapistContentLoaded;
    emit(curr.copyWith(isSubmitting: true));
    try {
      final newItem = await _repository.createContent(curr.activeTab, data);
      final updatedList = [newItem, ...curr.items];
      emit(curr.copyWith(items: updatedList, isSubmitting: false));
      return true;
    } catch (e) {
      emit(curr.copyWith(isSubmitting: false));
      return false;
    }
  }

  Future<bool> updateContent(String id, Map<String, dynamic> data) async {
    if (state is! TherapistContentLoaded) return false;
    final curr = state as TherapistContentLoaded;
    emit(curr.copyWith(isSubmitting: true));
    try {
      final updatedItem = await _repository.updateContent(curr.activeTab, id, data);
      final updatedList = curr.items.map((item) => item['id'] == id ? updatedItem : item).toList();
      emit(curr.copyWith(items: updatedList, isSubmitting: false));
      return true;
    } catch (e) {
      emit(curr.copyWith(isSubmitting: false));
      return false;
    }
  }

  Future<bool> deleteContent(String id) async {
    if (state is! TherapistContentLoaded) return false;
    final curr = state as TherapistContentLoaded;
    try {
      await _repository.deleteContent(curr.activeTab, id);
      final updatedList = curr.items.where((item) => item['id'] != id).toList();
      emit(curr.copyWith(items: updatedList));
      return true;
    } catch (e) {
      return false;
    }
  }
}
