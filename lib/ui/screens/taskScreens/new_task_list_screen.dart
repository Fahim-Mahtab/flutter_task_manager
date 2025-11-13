import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/screens/taskScreens/add_task_screen.dart';

import '../../widgets/task_list_container.dart';

class NewTaskListScreen extends StatefulWidget {
  const NewTaskListScreen({super.key});
  @override
  State<NewTaskListScreen> createState() => _NewTaskListScreenState();
}

class _NewTaskListScreenState extends State<NewTaskListScreen> {
  void _floatingActionButtonPressed() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AddTaskScreen.routeName,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(),
          _buildWidgetCard(),
          Expanded(
            child: ListView.separated(
              itemCount: 10,
              itemBuilder: (context, index) {
                return TaskListContainer(
                  title: 'This is new task',
                  description:
                      'Today im gonna finish my studies and work '
                      'on my project and submit it '
                      'on time to me and my team members. ',
                  dateText: 'Date : 12/12/2023',
                  onNewTap: _newTaskTapped,
                  onEditTap: _editTaskTapped,
                  onDeleteTap: _deleteTaskTapped,
                  buttonText: 'New',
                  taskStatusColor: Colors.blue,
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 10);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: Colors.green,
        onPressed: _floatingActionButtonPressed,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

Widget _buildWidgetCard() {
  return SizedBox(
    height: 100,
    child: ListView.builder(
      itemCount: 10,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.all(12), // space inside the box
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "09",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                "Cancelled",
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}

void _newTaskTapped() {}
void _editTaskTapped() {}
void _deleteTaskTapped() {}
