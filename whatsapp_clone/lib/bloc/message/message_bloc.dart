import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/bloc/message/message_event.dart';
import 'package:whatsapp_clone/bloc/message/message_state.dart';
import 'package:whatsapp_clone/models/message_model.dart';
import 'package:whatsapp_clone/services/firebase_service.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  FirebaseService firebaseService;
  // StreamSubscription? _messagesSub;
  MessageBloc(this.firebaseService) : super(MessageInitial()) {
    on<SendMessage>((event, emit) async {
      try {
        await firebaseService.sendMessage(event.msg, event.chatId, event.chat);
      } catch (e) {
        debugPrint(e.toString());
      }
    });

    on<LoadMessages>((event, emit) async {
      // emit(MessageLoading());
      await emit.forEach<List<MessageModel>>(
        firebaseService.getMessages(event.chatId),
        onData: (List<MessageModel> messages) {
          return MessageLoaded(msgs: messages);
        },
        onError: (error, stackTrace) {
          return MessageError(error: error.toString());
        },
      );
    });
  }
}
