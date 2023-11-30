import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TDBLink extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final TextStyle? style;

  const TDBLink({
    Key? key,
    required this.text,
    required this.onTap,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: TextButton(
        onPressed: () {onTap();},
        child: Text(
          text,
          style: style ?? GoogleFonts.urbanist(
            color: Colors.black, // Default color for link
             decoration: TextDecoration.underline, // Underline decoration
        ),),
      ),
    );
  }
}
