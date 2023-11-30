import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SSOButton extends StatelessWidget {
  final Provider provider;
  final VoidCallback onPressed;
  final Color backgroundColor;

  const SSOButton({
    Key? key,
    required this.provider,
    required this.onPressed,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        minimumSize: Size(80, 80),
        maximumSize: Size(80, 80),
        padding: EdgeInsets.all(0), // Adjust padding
        //padding: EdgeInsets.symmetric(horizontal: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: provider == Provider.GOOGLE ?
      SvgPicture.asset(
        provider.data,
        width: double.infinity,
        height: double.infinity,
      )
          :
      Image(
        image: AssetImage(provider.data),
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}

enum Provider {
  APPLE,
  GOOGLE
}

extension ProviderExtension on Provider {
  String get data {
    switch (this) {
      case Provider.APPLE:
        return 'assets/provider/apple_logo.png';
      case Provider.GOOGLE:
        return 'assets/provider/google_logo.svg';
      default:
        return '';
    }
  }
}
