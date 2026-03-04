import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/quote_entity.dart';
import '../../domain/usecases/quote_usecases.dart';

part 'quote_event.dart';
part 'quote_state.dart';

@injectable
class QuoteBloc extends Bloc<QuoteEvent, QuoteState> {
  final GetFeaturedQuotes _getFeaturedQuotes;

  QuoteBloc(this._getFeaturedQuotes) : super(QuoteInitial()) {
    on<LoadFeaturedQuotes>(_onLoadFeaturedQuotes);
    on<RefreshFeaturedQuotes>(_onRefreshFeaturedQuotes);
  }

  Future<void> _onLoadFeaturedQuotes(
    LoadFeaturedQuotes event,
    Emitter<QuoteState> emit,
  ) async {
    emit(QuoteLoading());

    final result = await _getFeaturedQuotes(
      limit: event.limit,
      preferenceIds: event.preferenceIds,
    );

    result.fold(
      (failure) => emit(QuoteError(failure.message)),
      (quotes) {
        // Filter only featured quotes of type "quote"
        final featuredQuotes = quotes
            .where((quote) => quote.isFeatured && quote.quoteType == 'quote')
            .toList();
        
        emit(QuoteLoaded(quotes: featuredQuotes));
      },
    );
  }

  Future<void> _onRefreshFeaturedQuotes(
    RefreshFeaturedQuotes event,
    Emitter<QuoteState> emit,
  ) async {
    // Don't emit loading state to keep UI smooth
    final result = await _getFeaturedQuotes(
      limit: event.limit,
      preferenceIds: event.preferenceIds,
    );

    result.fold(
      (failure) => emit(QuoteError(failure.message)),
      (quotes) {
        // Filter only featured quotes of type "quote"
        final featuredQuotes = quotes
            .where((quote) => quote.isFeatured && quote.quoteType == 'quote')
            .toList();
        
        emit(QuoteLoaded(quotes: featuredQuotes));
      },
    );
  }
}
