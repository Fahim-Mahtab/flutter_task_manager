import 'package:flutter/material.dart';

import '../../widgets/task_list_container.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
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
              //    onNewTap: _newTaskTapped,
                  onEditTap: _editTaskTapped,
                  onDeleteTap: _deleteTaskTapped,
                  buttonText: 'Completed',
                  taskStatusColor: Colors.green,
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


void _editTaskTapped() {}

void _deleteTaskTapped() {}
