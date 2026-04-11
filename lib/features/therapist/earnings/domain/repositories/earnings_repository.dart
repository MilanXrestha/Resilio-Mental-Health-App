import '../entities/therapist_earnings_entity.dart';

abstract class EarningsRepository {
  Future<TherapistEarningsEntity> getEarnings();
}
