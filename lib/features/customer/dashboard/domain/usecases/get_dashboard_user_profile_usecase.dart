import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../entities/user_profile_entity.dart';
import '../repositories/dashboard_repository.dart';

@injectable
class GetDashboardUserProfileUseCase {
  final DashboardRepository _repository;

  GetDashboardUserProfileUseCase(this._repository);

  Future<Either<Failure, UserProfile>> call() {
    return _repository.getUserProfile();
  }
}