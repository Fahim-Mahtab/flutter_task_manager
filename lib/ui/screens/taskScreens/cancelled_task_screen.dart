import 'package:flutter/material.dart';

import '../../widgets/task_list_container.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 10),
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
                  buttonText: 'Cancelled',
                  taskStatusColor: Colors.red,
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 10);
              },
            ),
          ),
        ],
      ),
    );
  }
}

void _newTaskTapped() {}

void _editTaskTapped() {}

void _deleteTaskTapped() {}
