import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:chat_app_task1/main.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  List<Message> messages = [];

  ChatBloc() : super(ChatInitial()) {
    on<NewMessageEvent>((event, emit) {
      emit(MessagesUpdated(event.message));
    });

    on<DoneUpdating>(((event, emit) {
      emit(ChatInitial());
    }));

    on<ChangeUserEvent>(((event, emit) => emit(UserSwapped())));
  }
}
