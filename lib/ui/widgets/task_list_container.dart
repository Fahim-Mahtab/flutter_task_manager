import 'package:flutter/material.dart';

class TaskListContainer extends StatelessWidget {
  final String title;
  final String description;
  final String dateText;
  final String buttonText;
  final VoidCallback onNewTap;
  final VoidCallback onEditTap;
  final VoidCallback onDeleteTap;
  final Color taskStatusColor;

  // final VoidCallback? onDeleteTap; Makes it optional use
  const TaskListContainer({
    super.key,
    required this.title,
    required this.description,
    required this.dateText,
    required this.onNewTap,
    required this.onEditTap,
    required this.onDeleteTap,
    required this.buttonText,
    required this.taskStatusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: EdgeInsets.all(10),
        title: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(color: Colors.grey),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 20),
                Text(
                  dateText,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    GestureDetector(
                      onTap: onNewTap,
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        width: 100,
                        decoration: BoxDecoration(
                          color: taskStatusColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          buttonText,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: onEditTap,
                      icon: Icon(Icons.edit_note_outlined, color: Colors.green),
                    ),
                    IconButton(
                      onPressed: onDeleteTap,
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
}
