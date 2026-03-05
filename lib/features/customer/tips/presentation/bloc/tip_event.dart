import 'package:equatable/equatable.dart';

/// Tip event base class
abstract class TipEvent extends Equatable {
  const TipEvent();

  @override
  List<Object?> get props => [];
}

/// Load featured tips
class LoadFeaturedTips extends TipEvent {
  final int limit;
  final List<String>? preferenceIds;
  final String? tipType;

  const LoadFeaturedTips({
    this.limit = 10,
    this.preferenceIds,
    this.tipType,
  });

  @override
  List<Object?> get props => [limit, preferenceIds, tipType];
}

/// Load tip by ID
class LoadTipById extends TipEvent {
  final String tipId;

  const LoadTipById(this.tipId);

  @override
  List<Object?> get props => [tipId];
}

/// List tips with filters
class ListTips extends TipEvent {
  final int limit;
  final int offset;
  final String? categoryId;
  final bool? isFeatured;
  final bool? isPremium;
  final String? tipType;
  final List<String>? preferenceIds;

  const ListTips({
    this.limit = 20,
    this.offset = 0,
    this.categoryId,
    this.isFeatured,
    this.isPremium,
    this.tipType,
    this.preferenceIds,
  });

  @override
  List<Object?> get props => [limit, offset, categoryId, isFeatured, isPremium, tipType, preferenceIds];
}

/// Get tips by type
class GetTipsByType extends TipEvent {
  final String tipType;
  final int limit;
  final int offset;

  const GetTipsByType({
    required this.tipType,
    this.limit = 20,
    this.offset = 0,
  });

  @override
  List<Object?> get props => [tipType, limit, offset];
}

/// Refresh tips
class RefreshTips extends TipEvent {}
