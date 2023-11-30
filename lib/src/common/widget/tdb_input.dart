import 'package:flutter/material.dart';

class TDBInput extends StatelessWidget {
  final String labelText;
  final ValueChanged<String> onChanged;
  final FormFieldValidator<String>? validator;
  final bool hideText;

  const TDBInput({
    Key? key,
    required this.labelText,
    required this.onChanged,
    this.validator,
    this.hideText = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12), // Rounded corners with a radius of 24
        boxShadow: [
          BoxShadow(
            blurRadius: 4, // Small blur radius
            spreadRadius: 0, // No spread
            color: Colors.black.withOpacity(0.2), // Shadow color with some transparency
            offset: Offset(0, 0), // No offset for the shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: TextFormField(
          obscureText: hideText,
          decoration: InputDecoration(
            labelText: labelText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12), // Rounded corners for input border
              borderSide: BorderSide.none, // No border side
            ),
            filled: true, // Needed for fillColor to take effect
            fillColor: Colors.white, // Background color of the input field
            contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0), // Adjust padding as needed
          ),
          validator: validator,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
