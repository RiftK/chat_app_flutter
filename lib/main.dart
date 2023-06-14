import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      home: ChatScreen(),
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
  String pfp =
      "https://i.pinimg.com/736x/6b/bb/80/6bbb802fe57d9bccbe24dece69e87ab0.jpg";

  void _handleSubmitted(String text) {
    _textController.clear();
    if (text == "") return;
    setState(() {
      messages.add(Message(text, chatWith, user));
    });
  }

  Widget _buildTextComposer() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: _textController,
              onSubmitted: _handleSubmitted,
              decoration: InputDecoration.collapsed(hintText: 'Message'),
            ),
          ),
          IconButton(
              icon: Icon(Icons.send),
              onPressed: () {
                setState(() {
                  _handleSubmitted(_textController.text);
                });
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
        margin: BubbleEdges.only(top: 10),
        padding: isCurrentUser
            ? BubbleEdges.only(left: 20)
            : BubbleEdges.only(right: 20),
        alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
        nip: isCurrentUser ? BubbleNip.rightBottom : BubbleNip.leftBottom,
        color: isCurrentUser
            ? Color.fromRGBO(225, 255, 199, 1.0)
            : Colors.grey[300],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // if (!isCurrentUser)
            //   Text(
            //     message.userName,
            //     style: TextStyle(fontWeight: FontWeight.bold),
            //   ),
            Text(message.text),
            SizedBox(height: 4.0),
            Text(
              '${message.time.hour.toString().padLeft(2, '0')}:${message.time.minute.toString().padLeft(2, '0')}',
              style: TextStyle(fontSize: 12.0),
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
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 10,
            foregroundImage: NetworkImage(pfp),
          ),
        ),
        title: Text(chatWith),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  user = 1 - user;
                  if (user == 1) {
                    chatWith = "Goku";
                    pfp =
                        "https://i.pinimg.com/564x/e7/68/46/e76846ec30e1c9a1b804499e2368ac6b.jpg";
                  } else {
                    chatWith = "Vegeta";
                    pfp =
                        "https://i.pinimg.com/736x/6b/bb/80/6bbb802fe57d9bccbe24dece69e87ab0.jpg";
                  }
                });
              },
              icon: Icon(user == 0 ? Icons.person : Icons.swap_horiz))
        ],
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              reverse: false,
              itemBuilder: (_, int index) => _buildMessageItem(messages[index]),
              itemCount: messages.length,
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
