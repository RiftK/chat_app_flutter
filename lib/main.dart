import 'package:chat_app_task1/models/message.dart';
import 'package:flutter/material.dart';
import 'chat_app.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'data/messages.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(MessageAdapter());
  boxMessages = await Hive.openBox<Message>('messageBox');
  runApp(const ChatApp());
}
