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
        emit(MessageSending());
        await firebaseService.sendMessage(event.msg, event.chatId, event.chat);
      } catch (e) {
        debugPrint(e.toString());
      }
    });

    on<LoadMessages>((event, emit) async {
      emit(MessageLoading());
      // final response = await firebaseService.getMessages(event.chatId);
      await emit.forEach<List<MessageModel>>(
        firebaseService.getMessages(event.chatId),
        onData: (List<MessageModel> messages) {
          return MessageLoaded(msgs: messages);
        },
        onError: (error, stackTrace) {
          return MessageError(error: error.toString());
        },
      );
      // _messagesSub?.cancel();
      // final chatRef = FirebaseFirestore.instance
      //     .collection('chats')
      //     .doc(event.chatId);
      // _messagesSub = chatRef
      //     .collection('messages')
      //     .orderBy('timestamp', descending: true)
      //     .snapshots()
      //     .listen(
      //       (snapshot) {
      //         final messages = snapshot.docs
      //             .map((doc) => MessageModel.fromJson(doc.data()))
      //             .toList();
      //         add(MessagesUpdated(messages));
      //       },
      //       onError: (error) {
      //         emit(MessageError(error: error.toString()));
      //       },
      //     );
    });
  }
}
