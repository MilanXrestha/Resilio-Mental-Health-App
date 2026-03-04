import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../domain/entities/user_profile_entity.dart';
import '../../domain/repositories/dashboard_repository.dart';

@injectable
class GetDashboardUserProfileUseCase {
  final DashboardRepository _repository;

  GetDashboardUserProfileUseCase(this._repository);

  Future<Either<Failure, UserProfile>> call(String userId, String idToken) async {
    return await _repository.getUserProfile(userId, idToken);
  }
}
