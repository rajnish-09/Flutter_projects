import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/bloc/message/message_event.dart';
import 'package:whatsapp_clone/bloc/message/message_state.dart';
import 'package:whatsapp_clone/services/firebase_service.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  FirebaseService firebaseService;
  MessageBloc(this.firebaseService) : super(MessageInitial()) {
    on<SendMessage>((event, emit) async {
      try {
        emit(MessageSending());
        await firebaseService.sendMessage(event.msg, event.chatId, event.chat);
      } catch (e) {
        debugPrint(e.toString());
      }
    });
  }
}
