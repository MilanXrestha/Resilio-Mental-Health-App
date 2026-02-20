import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:resilio/core/errors/failures.dart';

/// Base class for all use cases
abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

/// No parameters use case
class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object?> get props => [];
}
