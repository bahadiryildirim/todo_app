// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:todo_app/model/task_model.dart';

class TaskWidget extends StatefulWidget {
  TaskModel task;
  TaskWidget({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  TextEditingController _taskDetailController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _taskDetailController.text = widget.task.taskDetail;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: widget.task.isComplated
                ? Color.fromARGB(255, 233, 233, 233)
                : Color.fromARGB(255, 200, 200, 200),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(.2), blurRadius: 7)
            ]),
        child: ListTile(
          leading: GestureDetector(
            onTap: () {
              setState(() {
                widget.task.isComplated = !widget.task.isComplated;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              padding: widget.task.isComplated
                  ? const EdgeInsets.symmetric(horizontal: 13, vertical: 4)
                  : const EdgeInsets.all(1),
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 2,
                      color: widget.task.isComplated
                          ? Colors.green
                          : const Color.fromARGB(255, 217, 164, 5)),
                  shape: BoxShape.circle,
                  color: widget.task.isComplated
                      ? Colors.green
                      : const Color.fromARGB(255, 200, 200, 200)),
              child: Icon(Icons.check,
                  color: widget.task.isComplated
                      ? Colors.white
                      : const Color.fromARGB(255, 200, 200, 200)),
            ),
          ),
          title: widget.task.isComplated
              ? Text(widget.task.taskDetail,
                  style: const TextStyle(
                    fontWeight: FontWeight.w300,
                    decoration: TextDecoration.lineThrough,
                    fontStyle: FontStyle.italic,
                    color: Color.fromARGB(255, 171, 171, 171),
                    //: Color.fromARGB(255, 74, 74, 74)),
                  ))
              : TextField(
                  controller: _taskDetailController,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 74, 74, 74),
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: const InputDecoration(border: InputBorder.none),
                  onSubmitted: (value) {
                    if (value.length > 3) {
                      widget.task.taskDetail = value;
                    }
                  },
                ),
          trailing: AnimatedContainer(
            height: MediaQuery.of(context).size.height,
            duration: const Duration(milliseconds: 500),
            width: widget.task.isComplated
                ? MediaQuery.of(context).size.width / 8
                : MediaQuery.of(context).size.width / 13,
            color: widget.task.isComplated
                ? Colors.green
                : const Color.fromARGB(255, 217, 164, 5),
            child: Center(
                child:
                    Text(DateFormat('hh\nmm\na').format(widget.task.createdAt),
                        textAlign: TextAlign.center,
                        style: widget.task.isComplated
                            ? TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w300,
                              )
                            : TextStyle(
                                color: Color.fromARGB(255, 74, 74, 74),
                                fontWeight: FontWeight.w500,
                              ))),
          ),
        ),
      ),
    );
  }
}
