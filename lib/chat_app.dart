import 'views/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'viewmodel/chat_bloc.dart';

import 'views/screens/chatscreen.dart';

class ChatApp extends StatefulWidget {
  const ChatApp({super.key});

  @override
  State<ChatApp> createState() => _ChatAppState();
}

class _ChatAppState extends State<ChatApp> {
  int talkingToUser = -1;

  void selectUser(int id) {
    setState(() {
      talkingToUser = id;
    });
  }

  void returnHome() {
    setState(() {
      talkingToUser = -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget curScreen = Home(0, selectUser: selectUser);
    if (talkingToUser != -1) {
      curScreen = ChatScreen(
        curUser: 0,
        chatWithUserID: talkingToUser,
        returnHome: returnHome,
      );
    }

    return MaterialApp(
      title: 'Chat App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
        create: (context) => ChatBloc(),
        child: curScreen,
      ),
    );
  }
}
