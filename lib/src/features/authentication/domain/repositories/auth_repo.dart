import 'package:flutter/cupertino.dart';
import 'package:todoblock_mobile_app/src/features/authentication/domain/models/auth_user_model.dart';
import 'package:todoblock_mobile_app/src/features/authentication/domain/models/user_model.dart';
export 'auth_repo.dart';

abstract class AuthRepository {

  Future<UserModel> login(AuthUserModel authUserModel);

  Future<UserModel> register(AuthUserModel authUserModel);

  Future<bool> validateSession(String session);

  Future<void> logout(Function? callback);

  Future<void> createUser(UserModel userModel);

  Future<UserModel> getUser(String uuid);
}
