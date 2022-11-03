import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:loyaltyapp/message/message_response.dart';

abstract class MessageState extends Equatable {
  const MessageState();

  @override
  List<Object> get props => [];
}

class MessageInitial extends MessageState {
  const MessageInitial();
}

class MessageEmpty extends MessageState {}

class MessageLoading extends MessageState {}

class MessageLoaded extends MessageState {
  final List<LoyaltyMessage> loyaltyMessage;

  const MessageLoaded({@required this.loyaltyMessage})
      : assert(loyaltyMessage != null);

  @override
  List<Object> get props => [loyaltyMessage];
}

class MessageSubmitting extends MessageState {}

class MessageSubmitted extends MessageState {
  final LoyaltyMessageResponse loyaltyMessageResponse;
  const MessageSubmitted({@required this.loyaltyMessageResponse}): assert(loyaltyMessageResponse != null);

  @override
  List<Object> get props => [loyaltyMessageResponse];
}

class MessageReplySubmitting extends MessageState {}

class MessageReplySubmitted extends MessageState {
  final LoyaltyMessageResponse loyaltyMessageResponse;
  const MessageReplySubmitted({@required this.loyaltyMessageResponse}): assert(loyaltyMessageResponse != null);

  @override
  List<Object> get props => [loyaltyMessageResponse];
}

class MessagePriorityEmpty extends MessageState {}

class MessagePriorityLoading extends MessageState {}

class MessagePriorityLoaded extends MessageState {
  final List<MessagePriorities> messagePriority;

  const MessagePriorityLoaded({@required this.messagePriority})
      : assert(messagePriority != null);

  @override
  List<Object> get props => [messagePriority];
}

class MessageReplyEmpty extends MessageState {}

class MessageReplyLoading extends MessageState {}

class MessageReplyLoaded extends MessageState {
  final List<LoyaltyMessage> loyaltyMessage;

  const MessageReplyLoaded({@required this.loyaltyMessage})
      : assert(loyaltyMessage != null);

  @override
  List<Object> get props => [loyaltyMessage];
}

class MessageError extends MessageState {
  final String message;
  const MessageError(this.message);
}
