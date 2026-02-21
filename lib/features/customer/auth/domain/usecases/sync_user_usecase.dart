import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../data/datasources/remote/backend_auth_data_source.dart';

/// Parameters for syncing user to backend
class SyncUserParams {
  final User firebaseUser;
  final String? fcmToken;

  const SyncUserParams({
    required this.firebaseUser,
    this.fcmToken,
  });
}

/// Use case to sync Firebase user to backend database
/// Should be called after successful Firebase authentication
@injectable
class SyncUserUseCase implements UseCase<Map<String, dynamic>, SyncUserParams> {
  final BackendAuthDataSource _backendDataSource;

  SyncUserUseCase(this._backendDataSource);

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(SyncUserParams params) async {
    try {
      final result = await _backendDataSource.syncUser(
        firebaseUser: params.firebaseUser,
        fcmToken: params.fcmToken,
      );
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure('Failed to sync user: $e'));
    }
  }
}
