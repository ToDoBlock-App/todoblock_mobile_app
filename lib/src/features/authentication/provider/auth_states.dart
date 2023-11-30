part of 'auth_cubit.dart';

abstract class AuthState{}

class Landing extends AuthState{}

class ValidSession extends AuthState{}

class InvalidSession extends AuthState{}

class SigningIn extends AuthState{}

class SignedIn extends AuthState{
  final UserModel userModel;

  SignedIn(this.userModel);
}

class SignInFailed extends AuthState{}

class SigningUp extends AuthState{}

class SignedUp extends AuthState{
  final UserModel userModel;

  SignedUp(this.userModel);
}

class SignUpFailed extends AuthState{}

