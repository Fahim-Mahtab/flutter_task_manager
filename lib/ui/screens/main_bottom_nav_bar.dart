import 'package:flutter/material.dart';

class MainBottomNavBar extends StatefulWidget {
  const MainBottomNavBar({super.key});
  static const String routeName = "/mainBottomNavBar";
  @override
  State<MainBottomNavBar> createState() => _MainBottomNavBarState();
}

class _MainBottomNavBarState extends State<MainBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        backgroundColor: Colors.green,

        title: Column(
          children: [
            Row(
              spacing: 8,
              children: [
                CircleAvatar(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "User Name",
                      style: Theme.of(
                        context,
                      ).textTheme.titleSmall?.copyWith(color: Colors.white),
                    ),
                    Text(
                      "user@gmail.com",
                      style: Theme.of(
                        context,
                      ).textTheme.titleSmall?.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
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
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: Colors.green,
        onPressed: () {},
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
