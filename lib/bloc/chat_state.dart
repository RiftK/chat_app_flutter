part of 'chat_bloc.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class UserSwapped extends ChatState {}

class MessagesUpdated extends ChatState {
  final Message latestMessage;

  MessagesUpdated(this.latestMessage);
}
