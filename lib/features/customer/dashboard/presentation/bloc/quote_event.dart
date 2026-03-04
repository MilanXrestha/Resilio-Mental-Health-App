part of 'quote_bloc.dart';

abstract class QuoteEvent extends Equatable {
  const QuoteEvent();

  @override
  List<Object?> get props => [];
}

class LoadFeaturedQuotes extends QuoteEvent {
  final int limit;
  final List<String>? preferenceIds;

  const LoadFeaturedQuotes({
    this.limit = 10,
    this.preferenceIds,
  });

  @override
  List<Object?> get props => [limit, preferenceIds];
}

class RefreshFeaturedQuotes extends QuoteEvent {
  final int limit;
  final List<String>? preferenceIds;

  const RefreshFeaturedQuotes({
    this.limit = 10,
    this.preferenceIds,
  });

  @override
  List<Object?> get props => [limit, preferenceIds];
}
