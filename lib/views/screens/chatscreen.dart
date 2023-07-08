import '../../data/messages.dart';
import '../../data/users.dart';
import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';
import '../../models/message.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../viewmodel/chat_bloc.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen(
      {super.key,
      required this.curUser,
      required this.chatWithUserID,
      required this.returnHome});

  final int chatWithUserID;
  final int curUser;
  final void Function() returnHome;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();

  late int chatWithID;
  late int currentUser;
  late String chatWithName;
  late String pfp;
  int selectedMessageIndex = -1;
  Message? messageToReply;

  @override
  void initState() {
    chatWithID = widget.chatWithUserID;
    currentUser = widget.curUser;
    chatWithName = users[chatWithID].username;
    pfp = users[chatWithID].pfp;
    super.initState();
  }

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
                Message msg = Message(text, currentUser, chatWithID);
                if (messageToReply is Message) {
                  msg.repliedToMessage = messageToReply as Message;
                }
                if (text.isNotEmpty) {
                  setState(() {
                    // messages.add(msg);
                    boxMessages.put(boxMessages.length,
                        msg); // key = index, value = message
                    messageToReply = null;
                  });
                }
                _textController.clear();
              }),
        ],
      ),
    );
  }

  Widget _buildMessageItem(int index) {
    Message message = boxMessages.getAt(index);
    bool isCurrentUser = (message.fromUser == currentUser);

    if (message.toUser != chatWithID || message.fromUser != currentUser) {
      return const SizedBox.shrink();
    }

    return Container(
      decoration: index == selectedMessageIndex
          ? const BoxDecoration(color: Color.fromARGB(153, 131, 245, 190))
          : const BoxDecoration(),
      child: Align(
        alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Bubble(
          margin: const BubbleEdges.only(top: 10),
          padding: isCurrentUser
              ? const BubbleEdges.only(left: 20)
              : const BubbleEdges.only(right: 20),
          alignment:
              isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
          nip: isCurrentUser ? BubbleNip.rightBottom : BubbleNip.leftBottom,
          color: isCurrentUser
              ? const Color.fromRGBO(225, 255, 199, 1.0)
              : Colors.grey[300],
          child: GestureDetector(
            onTap: () {
              setState(() {
                if (selectedMessageIndex == index) {
                  selectedMessageIndex = -1;
                } else {
                  selectedMessageIndex = index;
                }
              });
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (message.repliedToMessage != null) ...[
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      // border: Border.all(color: Colors.greenAccent),
                      color: Color.fromARGB(255, 180, 248, 183),
                    ),
                    child: Text((message.repliedToMessage as Message).text),
                  )
                ],
                Text(message.text),
                const SizedBox(height: 4.0),
                Text(
                  '${message.time.hour.toString().padLeft(2, '0')}:${message.time.minute.toString().padLeft(2, '0')}',
                  style: const TextStyle(fontSize: 12.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: (selectedMessageIndex == -1)
          ? AppBar(
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 10,
                  foregroundImage: AssetImage(pfp),
                ),
              ),
              title: Text(users[chatWithID].username),
              actions: [
                IconButton(
                  onPressed: () {
                    widget.returnHome();
                  },
                  icon: const Icon(Icons.arrow_back_ios_new),
                ),
              ],
            )
          : AppBar(
              leading: IconButton(
                onPressed: () {
                  setState(() {
                    selectedMessageIndex = -1;
                  });
                },
                icon: const Icon(Icons.arrow_back),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      messageToReply = boxMessages.get(selectedMessageIndex);
                      selectedMessageIndex = -1;
                    });
                  },
                  icon: const Icon(Icons.reply),
                ),
              ],
            ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              reverse: false,
              itemBuilder: (_, int index) => _buildMessageItem(index),
              itemCount: boxMessages.length,
            ),
          ),
          if (messageToReply is Message) ...[
            Row(
              children: [
                const SizedBox(width: 20),
                Container(
                  height: 30,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(205, 108, 215, 112)),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 10),
                        Text((messageToReply as Message).text),
                        const SizedBox(width: 20),
                      ]),
                ),
              ],
            ),
          ],
          const Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }
}
