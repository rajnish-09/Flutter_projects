import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/bloc/chat/chat_event.dart';
import 'package:whatsapp_clone/bloc/chat/chat_state.dart';
import 'package:whatsapp_clone/models/chat_model.dart';
import 'package:whatsapp_clone/services/firebase_service.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  FirebaseService firebaseService;
  ChatBloc(this.firebaseService) : super(ChatInitial()) {
    on<LoadChat>((event, emit) async {
      try {
        emit(ChatLoading());
        await emit.forEach(
          firebaseService.getChats(event.uid),
          onData: (List<ChatModel> chat) {
            return ChatLoaded(chats: chat);
          },
          onError: (error, stackTrace) {
            return ChatError(error: error.toString());
          },
        );
      } catch (e) {
        debugPrint(e.toString());
      }
    });

    on<DeleteChat>((event, emit) async {
      try {
        await firebaseService.deleteChat(event.chatId);
        emit(ChatDeleted(msg: 'Deleted successfully'));
      } catch (e) {
        emit(ChatError(error: e.toString()));
      }
    });
  }
}
