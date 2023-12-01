import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LogoText extends StatefulWidget {
  final String text;
  bool animation = true;
  Function? animationDone;
  LogoText({Key? key, required this.text, this.animation = true, this.animationDone}) : super(key: key);

  @override
  State<LogoText> createState() => _LogoTextState();
}

class _LogoTextState extends State<LogoText> with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: widget.animation ? 600 : 0),
      vsync: this,
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller)
    ..addStatusListener((status) {
      if(status == AnimationStatus.completed && widget.animationDone != null){
        widget.animationDone!();
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return FadeTransition(
      opacity: _animation,
      child: Text(
        widget.text,
        style: GoogleFonts.vibes(
          height: 1,
          letterSpacing:3,
          fontWeight: FontWeight.normal,
          fontSize: 64,
          color: Colors.black,
        ),
      ),
    );
  }
}
