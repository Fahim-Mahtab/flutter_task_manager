import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/screens/taskScreens/cancelled_task_screen.dart';
import 'package:task_manager_app/ui/screens/taskScreens/completed_task_screen.dart';
import 'package:task_manager_app/ui/screens/taskScreens/new_task_list_screen.dart';
import 'package:task_manager_app/ui/screens/taskScreens/progress_task_screen.dart';

import '../widgets/my_app_bar.dart';

class MainBottomNavBar extends StatefulWidget {
  const MainBottomNavBar({super.key});
  static const String routeName = "/mainBottomNavBar";
  @override
  State<MainBottomNavBar> createState() => _MainBottomNavBarState();
}

class _MainBottomNavBarState extends State<MainBottomNavBar> {
  int _selectedIndex = 0;
  static const List<Widget> _screens = <Widget>[
    NewTaskListScreen(),
    CompletedTaskScreen(),
    CancelledTaskScreen(),
    ProgressTaskScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: MyAppBar(),
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: [
          NavigationDestination(icon: Icon(Icons.task), label: "New Task"),
          NavigationDestination(
            icon: Icon(Icons.cloud_done_outlined),
            label: "Completed",
          ),
          NavigationDestination(
            icon: Icon(Icons.cancel_outlined),
            label: "Cancelled",
          ),
          NavigationDestination(
            icon: Icon(Icons.timelapse_outlined),
            label: "Progress",
          ),
        ],
      ),
    );
  }
}
