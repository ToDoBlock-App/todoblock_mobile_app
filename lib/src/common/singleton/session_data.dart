import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todoblock_mobile_app/src/features/authentication/domain/models/user_model.dart';
import 'package:todoblock_mobile_app/src/features/authentication/domain/repositories/auth_repo.dart';

class SessionData {

  final supabase = Supabase.instance.client;
  final AuthRepository authRepository = Get.find();

  UserModel? _currentUser;
  get currentUser {
    return _currentUser;
  }

  Session? _currentSession;
  get currentSession {
    return _currentSession;
  }

  static final SessionData _instance = SessionData._internal(null, null);
  factory SessionData() => _instance;

  SessionData._internal(this._currentUser, this._currentSession){
    _currentSession = supabase.auth.currentSession;
    supabase.auth.onAuthStateChange.listen((data) {
      final Session? session = data.session;
      _setCurrent(session);
    });
  }

  Future<void> _setCurrent(Session? currentSession) async {
    _currentSession = currentSession;
    if(_currentSession == null){
      _currentUser = null;
      return;
    }
    _currentUser = await authRepository.getUser(currentSession!.user.id);
  }

  Future<bool> sessionIsValid() async {
    if(currentSession != null && !currentSession.isExpired){
      await supabase.auth.refreshSession();
      return true;
    }
    return false;
  }

}