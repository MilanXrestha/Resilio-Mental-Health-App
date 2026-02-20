import 'package:dartz/dartz.dart';

import '../../../../../core/proto_generated/auth.pb.dart' as pk;
import '../../domain/entities/user_entity.dart';

extension UserMapper on pk.User {
  UserEntity toEntity() {
    return UserEntity(id: '', email: '', name: '', role: ''

    );
  }
}
