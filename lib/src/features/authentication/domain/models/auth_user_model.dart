import 'package:todoblock_mobile_app/src/features/authentication/domain/models/user_model.dart';

class AuthUserModel{
  late String email;
  late String password;
  late UserModel? assocUser;

  AuthUserModel({required this.email, required this.password, this.assocUser});
}