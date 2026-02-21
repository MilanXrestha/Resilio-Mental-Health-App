import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String email;
  final String name;
  final String role;

  final bool preferencesCompleted;

  const UserEntity({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    this.preferencesCompleted = false,
  });

  @override
  List<Object?> get props => [id, email, name, role, preferencesCompleted];
}
