import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/chat_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
        create: (context) => ChatBloc(),
        child: ChatScreen(),
      ),
    );
  }
}

class Message {
  final String text;
  final String userName;
  final int user;
  final DateTime time;

  Message(this.text, this.userName, this.user, {DateTime? time})
      : time = time ?? DateTime.now();
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Message> messages = [];
  final TextEditingController _textController = TextEditingController();
  int user = 0;
  String chatWith = "Vegeta";
  String pfp = 'images/vegeta.jpg';

  Widget _buildTextComposer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: _textController,
              decoration: const InputDecoration.collapsed(hintText: 'Message'),
            ),
          ),
          IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {
                String text = _textController.text;
                ChatBloc bloc = BlocProvider.of<ChatBloc>(context);
                String name = user == 0 ? "Goku" : "Vegeta";
                Message msg = Message(text, name, user);
                if (text.isNotEmpty) {
                  bloc.add(NewMessageEvent(message: msg));
                }
                _textController.clear();
              }),
        ],
      ),
    );
  }

  Widget _buildMessageItem(Message message) {
    bool isCurrentUser = message.user == user;

    return Align(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Bubble(
        margin: const BubbleEdges.only(top: 10),
        padding: isCurrentUser
            ? const BubbleEdges.only(left: 20)
            : const BubbleEdges.only(right: 20),
        alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
        nip: isCurrentUser ? BubbleNip.rightBottom : BubbleNip.leftBottom,
        color: isCurrentUser
            ? const Color.fromRGBO(225, 255, 199, 1.0)
            : Colors.grey[300],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message.text),
            const SizedBox(height: 4.0),
            Text(
              '${message.time.hour.toString().padLeft(2, '0')}:${message.time.minute.toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 12.0),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        leading: BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            if (state is UserSwapped) {
              if (user == 1) {
                pfp = "images/goku.jpg";
              } else {
                pfp = "images/vegeta.jpg";
              }
              ChatBloc bloc = BlocProvider.of<ChatBloc>(context);
              bloc.add(DoneUpdating());
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 10,
                foregroundImage: AssetImage(pfp),
              ),
            );
          },
        ),
        title: BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            if (state is UserSwapped) {
              if (user == 1) {
                chatWith = "Goku";
              } else {
                chatWith = "Vegeta";
              }
            }
            return Text(chatWith);
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                ChatBloc bloc = BlocProvider.of<ChatBloc>(context);
                bloc.add(ChangeUserEvent());
              },
              icon: Icon(user == 0 ? Icons.person : Icons.swap_horiz))
        ],
      ),
      body: Column(
        children: [
          Flexible(
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                if (state is MessagesUpdated) {
                  messages.add(state.latestMessage);
                  ChatBloc bloc = BlocProvider.of<ChatBloc>(context);
                  bloc.add(DoneUpdating());
                }
                if (state is UserSwapped) {
                  user = 1 - user;
                  ChatBloc bloc = BlocProvider.of<ChatBloc>(context);
                  bloc.add(DoneUpdating());
                }
                return ListView.builder(
                  padding: EdgeInsets.all(8.0),
                  reverse: false,
                  itemBuilder: (_, int index) =>
                      _buildMessageItem(messages[index]),
                  itemCount: messages.length,
                );
              },
            ),
          ),
          Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }
}
