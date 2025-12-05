import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/screens/authScreens/sign_in_screen.dart';
import 'package:task_manager_app/ui/screens/profileScreen/update_profile_screen.dart';

import '../controller/auth_controller.dart';

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
                Navigator.pushNamed(context, ProfileScreen.routeName);
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
      actions: [
        IconButton(
          onPressed: () async {
            await AuthController.clearUserData();

            Navigator.pushNamedAndRemoveUntil(
              context,
              SignInScreen.routeName,
              (predicate) => false,
            );
          },
          icon: Icon(Icons.logout),
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
