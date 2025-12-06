import 'package:flutter/material.dart';
import 'package:task_manager_app/data/models/task_model.dart';
import 'package:task_manager_app/data/service/network_caller.dart';
import 'package:task_manager_app/data/utils/urls.dart';
import 'package:task_manager_app/ui/widgets/snack_bar_msg.dart';
import '../../widgets/task_list_container.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  @override
  void initState() {
    super.initState();
    _getCancelledTaskList();
  }

  List<TaskModel> _cancelledTaskList = [];
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
                  itemCount: _cancelledTaskList.length,
                  itemBuilder: (context, index) {
                    return TaskListContainer(
                      title: _cancelledTaskList[index].title,
                      description: _cancelledTaskList[index].description,
                      dateText:
                          'Date : ${_cancelledTaskList[index].createdDate}',
                      onEditTap: _editTaskTapped,
                      onDeleteTap: _deleteTaskTapped,
                      buttonText: _cancelledTaskList[index].status,
                      taskStatusColor: Colors.red,
                      onStatusChange: (status) {
                        _changeTaskStatus(_cancelledTaskList[index].id, status);
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
    _getCancelledTaskList();
  }

  Future<void> _changeTaskStatus(String taskId, String status) async {
    _isLoading = true;
    setState(() {});
    NetworkResponse response = await NetworkCaller.getRequest(
      Urls.updateTaskStatus(taskId, status),
    );
    if (response.isSuccess) {
      _getCancelledTaskList();
    } else {
      _isLoading = false;
      setState(() {});
      if (mounted) {
        showSnackBar(context, response.errorMessage);
      }
    }
  }

  Future<void> _getCancelledTaskList() async {
    setState(() {
      _isLoading = true;
    });
    NetworkResponse response = await NetworkCaller.getRequest(
      Urls.taskCancelled,
    );
    if (response.isSuccess) {
      _isLoading = false;
      List<TaskModel> list = [];
      for (Map<String, dynamic> jsonData in response.body["data"]) {
        list.add(TaskModel.fromJson(jsonData));
      }

      _cancelledTaskList = list;
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
