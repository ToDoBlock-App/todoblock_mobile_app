import 'package:todoblock_mobile_app/src/features/authentication/domain/models/user_model.dart';

class SessionData {
  late UserModel currentUser;

  SessionData({required this.currentUser});
}