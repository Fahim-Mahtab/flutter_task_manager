import 'package:flutter/material.dart';
import 'package:task_manager_app/data/models/task_model.dart';
import 'package:task_manager_app/data/service/network_caller.dart';
import 'package:task_manager_app/data/utils/urls.dart';
import 'package:task_manager_app/ui/screens/taskScreens/add_task_screen.dart';
import 'package:task_manager_app/ui/widgets/snack_bar_msg.dart';

import '../../widgets/task_list_container.dart';

class NewTaskListScreen extends StatefulWidget {
  const NewTaskListScreen({super.key});
  static const String routeName = '/all-task-list';

  @override
  State<NewTaskListScreen> createState() => _NewTaskListScreenState();
}

class _NewTaskListScreenState extends State<NewTaskListScreen> {
  void _floatingActionButtonPressed() {
    Navigator.pushNamed(context, AddTaskScreen.routeName);
  }

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(),
            _buildWidgetCard(),
            Visibility(
              visible: _isLoading == false,
              replacement: Center(child: CircularProgressIndicator()),
              child: ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _newTaskList.length,
                itemBuilder: (context, index) {
                  return TaskListContainer(
                    title: _newTaskList[index].title,
                    description:
                        'Description : ${_newTaskList[index].description}',
                    dateText:
                        'Date : ${_newTaskList[index].createdDate.toString().split(".")[0]}',

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
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: Colors.green,
        onPressed: _floatingActionButtonPressed,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Future<void> _getNewTaskList() async {
    setState(() {
      _isLoading = true;
    });
    NetworkResponse response = await NetworkCaller.getRequest(
      Urls.listOfTaskByStatus,
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

void _editTaskTapped() {}

void _deleteTaskTapped() {}
