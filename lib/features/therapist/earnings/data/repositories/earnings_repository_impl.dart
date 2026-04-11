import 'package:injectable/injectable.dart';

import '../datasources/remote/earnings_remote_datasource.dart';
import '../../domain/entities/therapist_earnings_entity.dart';
import '../../domain/repositories/earnings_repository.dart';

@LazySingleton(as: EarningsRepository)
class EarningsRepositoryImpl implements EarningsRepository {
  final EarningsRemoteDataSource _dataSource;

  EarningsRepositoryImpl(this._dataSource);

  @override
  Future<TherapistEarningsEntity> getEarnings() async {
    try {
      final map = await _dataSource.getEarnings();
      return TherapistEarningsEntity.fromMap(map);
    } catch (e) {
      rethrow;
    }
  }
}
