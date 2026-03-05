import 'package:equatable/equatable.dart';
import '../../domain/entities/tip_entity.dart';

/// Tip state base class
abstract class TipState extends Equatable {
  const TipState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class TipInitial extends TipState {}

/// Loading state
class TipLoading extends TipState {}

/// Refreshing state
class TipRefreshing extends TipState {}

/// Loaded state with tips list
class TipLoaded extends TipState {
  final List<TipEntity> tips;
  final int totalCount;
  final bool hasReachedMax;

  const TipLoaded({
    required this.tips,
    required this.totalCount,
    this.hasReachedMax = false,
  });

  @override
  List<Object?> get props => [tips, totalCount, hasReachedMax];

  TipLoaded copyWith({
    List<TipEntity>? tips,
    int? totalCount,
    bool? hasReachedMax,
  }) {
    return TipLoaded(
      tips: tips ?? this.tips,
      totalCount: totalCount ?? this.totalCount,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

/// Single tip loaded state
class TipDetailLoaded extends TipState {
  final TipEntity tip;

  const TipDetailLoaded(this.tip);

  @override
  List<Object?> get props => [tip];
}

/// Error state
class TipError extends TipState {
  final String message;

  const TipError(this.message);

  @override
  List<Object?> get props => [message];
}
