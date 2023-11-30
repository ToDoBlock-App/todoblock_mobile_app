import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TDBButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final TextStyle textStyle;
  final Icon? leadingIcon;

  const TDBButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.textStyle,
    this.leadingIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 4, // Small blur radius
            offset: Offset(0, 0), // No offset for the shadow
          ),
        ],
        borderRadius: BorderRadius.circular(24), // Rounded corners
      ),
      child: ElevatedButton.icon(
        icon: leadingIcon ?? SizedBox.shrink(),
        label: Text(
          text,
          style: textStyle,
        ),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: Colors.white, // Button color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24), // Same rounded corners
          ),
          elevation: 0,
          minimumSize: Size(230, 55),// Remove default elevation
          padding: EdgeInsets.zero, // Ensure padding is handled by the container
        ),
      ),
    );
  }
}
