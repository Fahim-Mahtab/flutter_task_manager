import 'package:flutter/material.dart';

import '../../../data/models/task_model.dart';
import '../../../data/service/network_caller.dart';
import '../../../data/utils/urls.dart';
import '../../widgets/snack_bar_msg.dart';
import '../../widgets/task_list_container.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  @override
  void initState() {
    super.initState();
    _getNewTaskList();
  }

  List<TaskModel> _newTaskList = [];
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: Visibility(
              visible: !_isLoading,
              replacement: const Center(child: CircularProgressIndicator()),
              child: ListView.separated(
                itemCount: _newTaskList.length,
                itemBuilder: (context, index) {
                  return TaskListContainer(
                    title: _newTaskList[index].title,
                    description: _newTaskList[index].description,
                    dateText: 'Date : ${_newTaskList[index].createdDate}',

                    onEditTap: _editTaskTapped,
                    onDeleteTap: _deleteTaskTapped,
                    buttonText: _newTaskList[index].status,
                    taskStatusColor: Colors.blue,
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 10);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _getNewTaskList() async {
    setState(() {
      _isLoading = true;
    });
    NetworkResponse response = await NetworkCaller.getRequest(
      Urls.taskCompleted,
    );
    if (response.isSuccess) {
      _isLoading = false;
      List<TaskModel> list = [];
      for (Map<String, dynamic> jsonData in response.body["data"]) {
        list.add(TaskModel.fromJson(jsonData));
      }

      _newTaskList = list;
      setState(() {});
    } else {
      if (mounted) {
        showSnackBar(context, response.errorMessage);
      }
    }
    _isLoading = false;
    setState(() {});
  }
}

void _editTaskTapped() {}

void _deleteTaskTapped() {}
