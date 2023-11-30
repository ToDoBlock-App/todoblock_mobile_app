import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoblock_mobile_app/src/common/widget/tdb_snackbar.dart';

class InAppNotification {

  static void showTDBSnackbar(BuildContext context, String? title, String? message, {Color color = Colors.grey, Duration duration = const Duration(seconds: 3)}) {
    Widget content;

    final style = TextStyle(
      color: Colors.white
    );

    if (title != null && message != null) {
      content = Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text('$title', style: GoogleFonts.urbanist(
              fontWeight: FontWeight.bold,
              color: Colors.white
          )),
          Text('$message', style: style)
        ],
      );    } else if (title != null) {
      content = Text(title, style: style);
    } else if (message != null) {
      content = Text(message, style: style,);
    } else {
      content = Text('No message', style: style);
    }

    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => TDBSnackbar(content: content, duration: duration, color: color),
    );

    Overlay.of(context)!.insert(overlayEntry);

  }

  static void showPopup(BuildContext context, String? title, String? message) {
    Widget content;

    final style = TextStyle(
        color: Colors.white
    );

    if (title != null && message != null) {
      content = Column(
        children: [
          Text('$title', style: GoogleFonts.urbanist(
            fontWeight: FontWeight.bold
          )),
          Text('$message', style: style)
        ],
      );
    } else if (title != null) {
      content = Text(title, style: style);
    } else if (message != null) {
      content = Text(message, style: style,);
    } else {
      content = Text('No message', style: style);
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: title == null ? Text("Achtung") : Text(title) ,
          content: content,
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
