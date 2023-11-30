 import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:todoblock_mobile_app/src/features/authentication/domain/models/auth_user_model.dart';
import '../domain/models/user_model.dart';
import '../domain/repositories/auth_repo.dart';

 part 'auth_states.dart';


class AuthCubit extends Cubit<AuthState>{

  AuthRepository repository = Get.find();

  AuthCubit(super.initialState);

  Future<void> signUp(String email, String password) async{
    emit(SigningUp());
    AuthUserModel authUserModel = AuthUserModel(email: email, password: password);
    try{
      UserModel userModel = await repository.register(authUserModel);
      emit(SignedUp(userModel));
    }catch(authException){
      emit(SignUpFailed());
    }
  }

  Future<void> signIn(String email, String password) async{
    emit(SigningIn());
    AuthUserModel authUserModel = AuthUserModel(email: email, password: password);
    try{
      UserModel userModel = await repository.login(authUserModel);
      emit(SignedIn(userModel));
    }catch(authException){
      emit(SignInFailed());
    }
  }

}