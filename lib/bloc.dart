import 'package:bloc/bloc.dart';
import 'main.dart';

class ChatBloc extends Bloc<Object, ChatState> {
  ChatBloc() : super(ChatState());

  @override
  Stream<ChatState> mapEventToState(Object event) async* {
    if (event is ToggleUserEvent) {
      yield state.copyWith(
          user: 1 - state.user,
          chatWith: state.user == 0 ? "Goku" : "Vegeta",
          pfp: state.user == 0
              ? "https://i.pinimg.com/736x/6b/bb/80/6bbb802fe57d9bccbe24dece69e87ab0.jpg"
              : "https://i.pinimg.com/564x/e7/68/46/e76846ec30e1c9a1b804499e2368ac6b.jpg");
    }
  }
}

class ChatState {
  final int user;
  final String chatWith;
  final String pfp;

  ChatState(
      {this.user = 0,
      this.chatWith = "Vegeta",
      this.pfp =
          "https://i.pinimg.com/736x/6b/bb/80/6bbb802fe57d9bccbe24dece69e87ab0.jpg"});

  ChatState copyWith({int? user, String? chatWith, String? pfp}) {
    return ChatState(
      user: user ?? this.user,
      chatWith: chatWith ?? this.chatWith,
      pfp: pfp ?? this.pfp,
    );
  }
}

class ToggleUserEvent {}
