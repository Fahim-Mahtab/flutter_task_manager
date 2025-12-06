import 'package:flutter/material.dart';

import '../../data/models/task_model.dart';

class TaskListContainer extends StatefulWidget {
  final String title;
  final String description;
  final String dateText;
  final String buttonText;
  //  final VoidCallback onNewTap;
  final VoidCallback onEditTap;
  final VoidCallback onDeleteTap;
  final Color taskStatusColor;
  // 1. Add the property definition

  // final VoidCallback? onDeleteTap; Makes it optional use
  const TaskListContainer({
    super.key,
    required this.title,
    required this.description,
    required this.dateText,

    required this.onEditTap,
    required this.onDeleteTap,
    required this.buttonText,
    required this.taskStatusColor,

  });

  @override
  State<TaskListContainer> createState() => _TaskListContainerState();
}

class _TaskListContainerState extends State<TaskListContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: EdgeInsets.all(10),
        title: Text(
          widget.title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.description,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(color: Colors.grey),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 20),
                Text(
                  widget.dateText,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      width: 100,
                      decoration: BoxDecoration(
                        color: widget.taskStatusColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        widget.buttonText,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    Spacer(),
                    IconButton(
                      onPressed: () {
                        _showChangeStatusDialog();
                      },
                      icon: Icon(Icons.edit_note_outlined, color: Colors.green),
                    ),
                    IconButton(
                      onPressed: widget.onDeleteTap,
                      icon: Icon(
                        Icons.delete_outline_outlined,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showChangeStatusDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Change Status"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                // trailing:  ,
                title: Text("Completed"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text("Cancelled"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text("Pending"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text("In Progress"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  /* bool _isCurrentStatus(String status) {
    return widget.taskModel.status == status;
  }*/
}
