import 'package:todoblock_mobile_app/src/features/authentication/domain/models/user_model.dart';

abstract class AuthRepository {

  UserModel login();

  UserModel register();

  bool validateSession();

}