import 'package:whatsapp_clone/models/message_model.dart';

abstract class MessageState {}

class MessageInitial extends MessageState{}

class MessageLoading extends MessageState{}

class MessageSending extends MessageState{}

class MessageLoaded extends MessageState{
  final List<MessageModel> msgs;
  MessageLoaded({required this.msgs});
}

class MessageError extends MessageState {
  final String error;
  MessageError({required this.error});
}