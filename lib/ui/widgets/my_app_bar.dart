import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/screens/profileScreen/profile_screen.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool tappable;
  const MyAppBar({super.key, this.tappable = true});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      title: GestureDetector(
        onTap: tappable
            ? () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  ProfileScreen.routeName,
                  (route) => false,
                );
              }
            : null,
        child: Row(
          children: [
            const CircleAvatar(),
            const SizedBox(width: 8),
            Column(
              mainAxisSize: MainAxisSize.min,
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
                  ).textTheme.bodySmall?.copyWith(color: Colors.white70),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
