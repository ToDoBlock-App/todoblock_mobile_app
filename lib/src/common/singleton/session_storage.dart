import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todoblock_mobile_app/src/features/authentication/domain/models/user_model.dart';
import 'package:todoblock_mobile_app/src/features/authentication/domain/repositories/auth_repo.dart';
import 'package:todoblock_mobile_app/src/features/todos/domain/models/todo_model.dart';

import '../../features/todoblocks/domain/models/to_do_block_model.dart';

class SessionStorageManager {

  final supabase = Supabase.instance.client;
  final AuthRepository authRepository = Get.find();
  List<ToDoBlockModel>? todoblocks;
  List<ToDoModel>? todos;

  UserModel? _currentUser;
  get currentUser {
    return _currentUser;
  }

  Session? _currentSession;
  get currentSession {
    return _currentSession;
  }

  static final SessionStorageManager _instance = SessionStorageManager._internal();
  factory SessionStorageManager() => _instance;

  SessionStorageManager._internal(){
    _currentSession = supabase.auth.currentSession;
    _setCurrent(_currentSession);
    startListeningToAuthChanges();
  }

  void startListeningToAuthChanges(){
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
      _currentSession = supabase.auth.currentSession;
      _setCurrent(_currentSession);
      return true;
    }
    return false;
  }

}