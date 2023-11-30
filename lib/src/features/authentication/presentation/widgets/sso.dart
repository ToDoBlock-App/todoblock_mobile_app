import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoblock_mobile_app/src/features/authentication/presentation/widgets/sso_button.dart';

class SSORow extends StatelessWidget {
  final VoidCallback onGoogleSignIn;
  final VoidCallback onAppleSignIn;

  const SSORow({
    Key? key,
    required this.onGoogleSignIn,
    required this.onAppleSignIn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 32,),
        Center(
          child: Text(
            "Continue with:",
            style: GoogleFonts.urbanist(
              fontWeight: FontWeight.bold,
              fontSize: 16
            ),
          ),
        ),
        SizedBox(height: 32,),
        Row(
          children: [
            Spacer(),
            SSOButton(
              provider: Provider.GOOGLE,
              onPressed: onGoogleSignIn,
              backgroundColor: Colors.white
            ),
            SizedBox(width: 20,),
            SSOButton(
              provider: Provider.APPLE,
              onPressed: onAppleSignIn,
              backgroundColor: Colors.white
            ),
            Spacer()
          ],
        ),
      ],
    );
  }
}
