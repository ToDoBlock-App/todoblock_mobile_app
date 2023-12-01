import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todoblock_mobile_app/src/features/authentication/domain/models/auth_user_model.dart';
import 'package:todoblock_mobile_app/src/features/authentication/domain/models/user_model.dart';

import '../repositories/auth_repo.dart';

class SupabaseAuthService extends AuthRepository{

  final supabase = Supabase.instance.client;

  @override
  Future<UserModel> login(AuthUserModel authUserModel) async {
    await supabase.auth.signInWithPassword(
      email: authUserModel.email,
      password: authUserModel.password,
    );

    if(supabase.auth.currentUser == null){
      throw AuthException("User login failed");
    }

    return await getUser(supabase.auth.currentUser!.id);
  }

  @override
  Future<void> logout() async {
    await supabase.auth.signOut();
  }

  @override
  Future<UserModel> register(AuthUserModel authUserModel) async {

    try{
      await supabase.auth.signUp(
        email: authUserModel.email,
        password: authUserModel.password,
      );
    }catch(authException){
      print(authException);
    }


    if(supabase.auth.currentUser == null){
      throw AuthException("User login failed");
    }

    await createUser(null);

    return await getUser(supabase.auth.currentUser!.id);
  }

  @override
  Future<bool> validateSession(String session) async {
    if(supabase.auth.currentSession == null) return false;
    if(supabase.auth.currentSession!.isExpired) return false;
    return true;
  }

  @override
  Future<void> createUser(UserModel? userModel) async {
    if(userModel == null){
      await supabase.from("user_data").insert({});
      return;
    }
    await supabase.from("user_data").insert(userModel.toJson());
  }

  @override
  Future<UserModel> getUser(String uuid) async {
    final query = await supabase.from("user_data").select<List<Map<String, dynamic>>>().eq('uuid', uuid);
    final data = query[0];
    return UserModel.fromJson(data);
  }
}