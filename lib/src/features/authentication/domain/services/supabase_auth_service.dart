import 'package:todoblock_mobile_app/src/features/authentication/domain/models/user_model.dart';

import '../repositories/auth_repo.dart';

class SupabaseAuthService extends AuthRepository{

  @override
  UserModel login() {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  UserModel register() {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  bool validateSession() {
    // TODO: implement validateSession
    throw UnimplementedError();
  }

}