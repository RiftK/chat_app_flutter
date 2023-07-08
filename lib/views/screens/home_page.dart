import 'package:chat_app_task1/data/messages.dart';
import 'package:chat_app_task1/views/widgets/user_chat_button.dart';
import 'package:flutter/material.dart';
import '../../data/users.dart';

class Home extends StatefulWidget {
  const Home(this.currentUserID, {super.key, required this.selectUser});

  final int currentUserID;

  final void Function(int id) selectUser;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          const Center(child: Text('Delete All Chats')),
          IconButton(
            onPressed: () {
              setState(() => boxMessages.clear());
            },
            icon: const Icon(Icons.delete_forever),
          ),
        ],
      ),
      backgroundColor: Colors.green,
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...users.map((user) {
              if (user.id != widget.currentUserID) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    UserChatButton(user, selectUser: widget.selectUser),
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
