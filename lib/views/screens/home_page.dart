import 'package:chat_app_task1/views/widgets/user_chat_button.dart';
import 'package:flutter/material.dart';
import '../../data/users.dart';

class Home extends StatelessWidget {
  const Home(this.currentUserID, {super.key, required this.selectUser});

  final int currentUserID;

  final void Function(int id) selectUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...users.map((user) {
              if (user.id != currentUserID) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    UserChatButton(user, selectUser: selectUser),
                    const SizedBox(height: 5),
                  ],
                );
              } else {
                return const SizedBox.shrink();
              }
            })
          ],
        ),
      ),
    );
  }
}
