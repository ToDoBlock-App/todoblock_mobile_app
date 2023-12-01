import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:todoblock_mobile_app/src/common/widget/logo_text.dart';
import 'package:todoblock_mobile_app/src/common/widget/tdb_button.dart';
import 'package:todoblock_mobile_app/src/common/widget/tdb_link.dart';
import 'package:todoblock_mobile_app/src/features/authentication/presentation/widgets/sso.dart';
import 'package:todoblock_mobile_app/src/features/authentication/provider/auth_cubit.dart';
import 'package:todoblock_mobile_app/src/utils/inapp_notification.dart';

import '../../../../common/widget/tdb_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthCubit authCubit = Get.find();

  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

   Future<void> _login() async {
     context.loaderOverlay.show();
     if (_formKey.currentState!.validate()) {
      await authCubit.signIn(_email, _password);
    }
  }

  @override
  void initState() {
    Timer(Duration(milliseconds: 400), (){
      FlutterNativeSplash.remove();
    });
    super.initState();
    authCubit.stream.listen((state) {
      if(state is SignedIn){
        context.go("/list");
      }

      if(state is SignInFailed){
        InAppNotification.showTDBSnackbar(context, "Login Failed", "Check your E-Mail and Password", color: Colors.red);
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
                fit: BoxFit.cover
            ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 55,),
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
              padding: const EdgeInsets.fromLTRB(58,24.0,58,24),
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
                        // Add validation logic if needed
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
                        // Add validation logic if needed
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 12,),
                    Center(
                      child: TDBLink(text: "Forgot Password?", onTap: (){
                        InAppNotification.showTDBSnackbar(context, "Not Supported", "The requested function is not supported yet.");
                      }),
                    ),
                    SizedBox(height: 24,),
                    TDBButton(
                      text: "Login",
                      onPressed: (){
                        _login();
                      },
                      textStyle: GoogleFonts.urbanist(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //Spacer(),
            SSORow(onGoogleSignIn: () {
              InAppNotification.showTDBSnackbar(context, "Not Supported", "The requested function is not supported yet.");
            }, onAppleSignIn: () {
              InAppNotification.showTDBSnackbar(context, "Not Supported", "The requested function is not supported yet.");
            },),
            // Column(
            //   children: [
            //     SizedBox(height: 10,),
            //     TDBButton(
            //       text: "Sign In with Google",
            //       onPressed: (){},
            //       textStyle: GoogleFonts.urbanist(
            //           color: Colors.black,
            //           fontSize: 16,
            //           fontWeight: FontWeight.w300
            //       ),
            //       leadingIcon: Icon(Icons.add, color: Colors.black,),
            //     ),
            //     SizedBox(height: 10,),
            //     TDBButton(
            //       text: "Sign In with Apple",
            //       onPressed: (){},
            //       textStyle: GoogleFonts.urbanist(
            //         color: Colors.black,
            //         fontSize: 16,
            //         fontWeight: FontWeight.w300
            //       ),
            //       leadingIcon: Icon(Icons.add, color: Colors.black,),
            //     ),
            //   ],
            // ),
            Spacer(),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: Get.width, height: 55, color: Colors.black,
                  child: Center(
                    child: TDBLink(text: "Sign Up", onTap: () => context.go("/register"), style: GoogleFonts.urbanist(
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
