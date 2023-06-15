part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}

class DoneUpdating extends ChatEvent {}

class ChangeUserEvent extends ChatEvent {}

class NewMessageEvent extends ChatEvent {
  final Message message;
  NewMessageEvent({required this.message});
}
