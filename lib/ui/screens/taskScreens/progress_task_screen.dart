import 'package:flutter/material.dart';
import 'package:task_manager_app/data/models/task_model.dart';
import 'package:task_manager_app/data/service/network_caller.dart';
import 'package:task_manager_app/data/utils/urls.dart';
import 'package:task_manager_app/ui/widgets/snack_bar_msg.dart';
import '../../widgets/task_list_container.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});
  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  @override
  void initState() {
    super.initState();
    _getProgressTaskList();
  }

  List<TaskModel> _progressTaskList = [];
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _onRefresh,
              child: Visibility(
                visible: !_isLoading,
                replacement: const Center(child: CircularProgressIndicator()),
                child: ListView.separated(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: _progressTaskList.length,
                  itemBuilder: (context, index) {
                    return TaskListContainer(
                      title: _progressTaskList[index].title,
                      description: _progressTaskList[index].description,
                      dateText:
                          'Date : ${_progressTaskList[index].createdDate}',
                      onEditTap: _editTaskTapped,
                      onDeleteTap: _deleteTaskTapped,
                      buttonText: _progressTaskList[index].status,
                      taskStatusColor: Colors.purple,
                      onStatusChange: (status) {
                        _changeTaskStatus(_progressTaskList[index].id, status);
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 10);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onRefresh() async {
    _getProgressTaskList();
  }

  Future<void> _changeTaskStatus(String taskId, String status) async {
    _isLoading = true;
    setState(() {});
    NetworkResponse response = await NetworkCaller.getRequest(
      Urls.updateTaskStatus(taskId, status),
    );
    if (response.isSuccess) {
      _getProgressTaskList();
    } else {
      _isLoading = false;
      setState(() {});
      if (mounted) {
        showSnackBar(context, response.errorMessage);
      }
    }
  }

  Future<void> _getProgressTaskList() async {
    setState(() {
      _isLoading = true;
    });
    NetworkResponse response = await NetworkCaller.getRequest(
      Urls.taskProgress,
    );
    if (response.isSuccess) {
      _isLoading = false;
      List<TaskModel> list = [];
      for (Map<String, dynamic> jsonData in response.body["data"]) {
        list.add(TaskModel.fromJson(jsonData));
      }

      _progressTaskList = list;
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
