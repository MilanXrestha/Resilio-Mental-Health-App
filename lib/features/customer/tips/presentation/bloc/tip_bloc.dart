import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repositories/tip_repository.dart';
import 'tip_event.dart';
import 'tip_state.dart';

/// Tip BLoC - manages tip state and business logic
@injectable
class TipBloc extends Bloc<TipEvent, TipState> {
  final TipRepository tipRepository;

  TipBloc(this.tipRepository) : super(TipInitial()) {
    on<LoadFeaturedTips>(_onLoadFeaturedTips);
    on<LoadTipById>(_onLoadTipById);
    on<ListTips>(_onListTips);
    on<GetTipsByType>(_onGetTipsByType);
    on<RefreshTips>(_onRefreshTips);
  }

  /// Handle LoadFeaturedTips event
  Future<void> _onLoadFeaturedTips(
    LoadFeaturedTips event,
    Emitter<TipState> emit,
  ) async {
    try {
      emit(TipLoading());

      final result = await tipRepository.getFeaturedTips(
        limit: event.limit,
        preferenceIds: event.preferenceIds,
        tipType: event.tipType,
      );

      result.fold(
        (failure) => emit(TipError(failure.toString())),
        (tips) {
          emit(TipLoaded(
            tips: tips,
            totalCount: tips.length,
            hasReachedMax: tips.length < event.limit,
          ));
        },
      );
    } catch (e) {
      emit(TipError(e.toString()));
    }
  }

  /// Handle LoadTipById event
  Future<void> _onLoadTipById(
    LoadTipById event,
    Emitter<TipState> emit,
  ) async {
    try {
      emit(TipLoading());

      final result = await tipRepository.getTipById(event.tipId);

      result.fold(
        (failure) => emit(TipError(failure.toString())),
        (tip) => emit(TipDetailLoaded(tip)),
      );
    } catch (e) {
      emit(TipError(e.toString()));
    }
  }

  /// Handle ListTips event
  Future<void> _onListTips(
    ListTips event,
    Emitter<TipState> emit,
  ) async {
    try {
      emit(TipLoading());

      final result = await tipRepository.listTips(
        limit: event.limit,
        offset: event.offset,
        categoryId: event.categoryId,
        isFeatured: event.isFeatured,
        isPremium: event.isPremium,
        tipType: event.tipType,
        preferenceIds: event.preferenceIds,
      );

      result.fold(
        (failure) => emit(TipError(failure.toString())),
        (listResult) {
          emit(TipLoaded(
            tips: listResult.tips,
            totalCount: listResult.totalCount,
            hasReachedMax: listResult.tips.length < event.limit,
          ));
        },
      );
    } catch (e) {
      emit(TipError(e.toString()));
    }
  }

  /// Handle GetTipsByType event
  Future<void> _onGetTipsByType(
    GetTipsByType event,
    Emitter<TipState> emit,
  ) async {
    try {
      emit(TipLoading());

      final result = await tipRepository.getTipsByType(
        tipType: event.tipType,
        limit: event.limit,
        offset: event.offset,
      );

      result.fold(
        (failure) => emit(TipError(failure.toString())),
        (listResult) {
          emit(TipLoaded(
            tips: listResult.tips,
            totalCount: listResult.totalCount,
            hasReachedMax: listResult.tips.length < event.limit,
          ));
        },
      );
    } catch (e) {
      emit(TipError(e.toString()));
    }
  }

  /// Handle RefreshTips event
  Future<void> _onRefreshTips(
    RefreshTips event,
    Emitter<TipState> emit,
  ) async {
    try {
      if (state is TipLoaded) {
        emit(TipRefreshing());

        final currentState = state as TipLoaded;
        
        // Re-load featured tips
        final result = await tipRepository.getFeaturedTips(
          limit: currentState.tips.isNotEmpty ? currentState.tips.length : 10,
        );

        result.fold(
          (failure) => emit(TipError(failure.toString())),
          (tips) {
            emit(TipLoaded(
              tips: tips,
              totalCount: tips.length,
              hasReachedMax: tips.length < 10,
            ));
          },
        );
      }
    } catch (e) {
      emit(TipError(e.toString()));
    }
  }
}
