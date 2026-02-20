import 'package:resilio/core/proto_generated/auth.pb.dart' as pk;

import '../../domain/entities/user_entity.dart';

extension UserMapper on pk.User {
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      name: name,
      role: role,
    );
  }
}
