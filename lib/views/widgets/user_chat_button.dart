import 'package:chat_app_task1/models/user.dart';
import 'package:flutter/material.dart';

class UserChatButton extends StatelessWidget {
  const UserChatButton(this.user, {super.key, required this.selectUser});
  final User user;

  final void Function(int id) selectUser;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.green[300])),
      onPressed: () {
        selectUser(user.id);
      },
      child: Row(
        children: [
          Image.asset(user.pfp, height: 50, width: 50),
          const SizedBox(width: 10),
          Text(
            user.username,
            style: const TextStyle(color: Colors.white, fontSize: 23),
          ),
        ],
      ),
    );
  }
}
