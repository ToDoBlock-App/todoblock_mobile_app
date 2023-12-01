import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:todoblock_mobile_app/src/common/singleton/session_data.dart';

import '../../../authentication/domain/models/user_model.dart';

class ToDoListPage extends StatefulWidget {
  const ToDoListPage({Key? key}) : super(key: key);

  @override
  State<ToDoListPage> createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  final UserModel user = SessionData().currentUser;

  @override
  void initState() {
    super.initState();
    if(context.loaderOverlay.visible){
      context.loaderOverlay.hide();
    }
  }

  @override
  Widget build(BuildContext context) {
    final String uuid = user.uuid ?? "Error";

    return Container(
      child: Center(child: Text(uuid)),
    );
  }
}
