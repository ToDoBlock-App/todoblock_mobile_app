import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/models/todo_model.dart';

class ToDoCard extends StatefulWidget {
  String title;
  bool action;
  bool goal;
  ToDoModel? todo;
  bool later;
  ToDoCard({Key? key, required this.title, this.todo, this.action = false, this.goal = false, this.later = false}) : super(key: key){
    final todo = this.todo;
    if(todo != null) title = todo.title!;
  }

  @override
  State<ToDoCard> createState() => _ToDoCardState();
}

class _ToDoCardState extends State<ToDoCard> {

  bool _dismissStartToEnd = false;
  bool _dismissEndToStart = false;
  bool _isExpanded = false;
  double _height = 70;
  String description = "";
  int duration = 0;
  int deadline = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    description = (widget.todo == null || widget.todo?.description == null ? "" : widget.todo?.description)!;
    duration = (widget.todo == null || widget.todo?.duration == null ? 0 : widget.todo?.duration)!;
    deadline = (widget.todo == null || widget.todo?.deadline == null ? 0 : widget.todo?.deadline)!;
  }

  String _createDescription(){
    return "Deadline: $deadline Duration: $duration \n $description";
  }

  @override
  Widget build(BuildContext context) {

    if(_isExpanded || widget.action){
      return Padding(
        padding: const EdgeInsets.fromLTRB(30, 8, 30, 8),
        child: _buildCard(),
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 8, 30, 8),
      child: Dismissible(
        key: ValueKey<String>(widget.title),
        background: Container(
          decoration: BoxDecoration(
              color: Color(0xFFD9D9D9),
              borderRadius: BorderRadius.circular(12)
          ),
        ),
        secondaryBackground: Container(
          decoration: BoxDecoration(
              color: Color(0xFF858585),
              borderRadius: BorderRadius.circular(12)
          ),
        ),
        onUpdate: (DismissUpdateDetails update){
          DismissDirection dismissDirection = update.direction;

          if(dismissDirection == DismissDirection.startToEnd){
            setState(() {
              _dismissStartToEnd = true;
            });
          }

          if(dismissDirection == DismissDirection.endToStart){
            setState(() {
              _dismissEndToStart = true;
            });
          }

          if(update.progress == 0){
            setState(() {
              _dismissStartToEnd = false;
              _dismissEndToStart = false;
            });
          }

        },
        dismissThresholds: {
          DismissDirection.startToEnd: 1.0,
          DismissDirection.endToStart: 1.0
        },
        child: _buildCard(),
      ),
    );
  }

  Widget _buildCard(){
    return  Stack(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                width: double.infinity/2,
                color: _dismissStartToEnd ? Color(0xFFD9D9D9) : Colors.transparent,
                height: _height,
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity/2,
                color: _dismissEndToStart ? Color(0xFF858585) : Colors.transparent,
                height: _height,
              ),
            ),
          ],
        ),
        Card(
          color: widget.action ? Color(0xFFD9D9D9) : Colors.white,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: widget.goal ? BorderSide(

              ) : BorderSide(
                  color: Colors.transparent
              )
          ),
          elevation: widget.action ? 2 : 0,
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: _height, width: 10,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12)
                    ),
                  ),
                  Icon(
                      widget.goal ? Icons.priority_high : Icons.adjust
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(12,0,12,0),
                    child: Text(
                      widget.title,
                      style: GoogleFonts.urbanist(
                        fontSize: 18,
                        fontWeight: FontWeight.w200,
                        decoration: widget.later == false ? null : TextDecoration.lineThrough
                      ),
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: widget.action ? null : () {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    },
                    icon: Icon(
                        widget.action ? Icons.add : _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down
                    ),
                  ),
                  Container(
                    height: _height, width: 10,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12)
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: AnimatedCrossFade(
                    firstChild: Container(
                    ), // Empty container for collapsed state
                    secondChild: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12)
                        ),
                        child: Text(
                            widget.todo == null ? "No Description available" : _createDescription()
                        )
                    ),
                    crossFadeState: _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                    duration: Duration(milliseconds: 300),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}