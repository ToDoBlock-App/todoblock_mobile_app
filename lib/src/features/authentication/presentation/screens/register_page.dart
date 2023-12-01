import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'package:todoblock_mobile_app/src/common/widget/logo_text.dart';
import 'package:todoblock_mobile_app/src/common/widget/tdb_button.dart';
import 'package:todoblock_mobile_app/src/common/widget/tdb_link.dart';
import 'package:todoblock_mobile_app/src/common/widget/tdb_input.dart';
import 'package:todoblock_mobile_app/src/utils/inapp_notification.dart';
import '../../provider/auth_cubit.dart';
import '../widgets/sso.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  AuthCubit authCubit = Get.find();

  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _confirmPassword = '';

  Future<void> _register() async {
    context.loaderOverlay.show();
    if (_formKey.currentState!.validate()) {
      await authCubit.signUp(_email, _password);
    }
  }

  @override
  void initState() {
    super.initState();
    authCubit.stream.listen((state) {
      if(state is SignedUp){
        context.go("/list");
      }
      if(state is SignUpFailed){
        InAppNotification.showTDBSnackbar(context, "Sign Up Failed", "Please try it again.", color: Colors.red);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/TDB_SplashScreen.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 55),
            Spacer(),
            Column(
              children: [
                LogoText(text: "ToDo\nBlock", animation: false,),
                Text(
                  "The Productivity App",
                  style: GoogleFonts.urbanist(
                      fontSize: 20,
                      fontWeight: FontWeight.w200,
                      letterSpacing: 3
                  ),
                )
              ],
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(58, 24.0, 58, 24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TDBInput(
                      labelText: 'E-Mail',
                      onChanged: (value) {
                        _email = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your E-Mail';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TDBInput(
                      hideText: true,
                      labelText: 'Password',
                      onChanged: (value) {
                        _password = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TDBInput(
                      hideText: true,
                      labelText: 'Confirm Password',
                      onChanged: (value) {
                        _confirmPassword = value;
                      },
                      validator: (value) {
                        if (value != _password) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24.0),
                    TDBButton(
                      text: 'Register',
                      onPressed: (){
                        _register();
                      },
                      textStyle: GoogleFonts.urbanist(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SSORow(onGoogleSignIn: () {
              InAppNotification.showTDBSnackbar(context, "Not Supported", "The requested function is not supported yet.");
            }, onAppleSignIn: () {
              InAppNotification.showTDBSnackbar(context, "Not Supported", "The requested function is not supported yet.");
            },),
            Spacer(),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: Get.width, height: 55, color: Colors.black,
                  child: Center(
                      child: TDBLink(text: "Sign In", onTap: () => context.go("/login"), style: GoogleFonts.urbanist(
                          decoration: TextDecoration.underline,
                          fontSize: 20,
                          fontWeight: FontWeight.w200,
                          color: Colors.white,
                          height: .001
                      ))
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}