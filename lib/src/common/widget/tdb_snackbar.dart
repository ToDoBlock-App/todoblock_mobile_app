import 'package:flutter/material.dart';

class TDBSnackbar extends StatefulWidget {
  final Widget content;
  final Duration duration;
  final Color color;

  const TDBSnackbar({
    Key? key,
    required this.content,
    this.duration = const Duration(seconds: 3),
    this.color = Colors.grey
  }) : super(key: key);

  @override
  _TDBSnackbarState createState() => _TDBSnackbarState();
}

class _TDBSnackbarState extends State<TDBSnackbar> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, -1), // Start above the screen
      end: Offset(0, -0.9),     // Ends at 10% down from the top of the screen
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _animationController.forward();

    //Schedule the reverse animation
    Future.delayed(widget.duration, () {
      _animationController.reverse().then((value) => null); // Remove the overlay entry
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: Material(
        elevation: 4.0,
        color: widget.color.withOpacity(0.8), // Neutral color
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          //margin: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top), // Adjust for status bar height
          child: Align(
            alignment: Alignment.bottomCenter,
            child: widget.content,
          )
        ),
      ),
    );
  }
}
