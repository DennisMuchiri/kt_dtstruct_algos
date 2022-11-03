
import 'package:bloc/bloc.dart';
import 'package:loyaltyapp/message/message_repository.dart';
import 'package:loyaltyapp/message/message_response.dart';

import 'MessageState.dart';

class MessageCubit extends Cubit<MessageState> {
    final MessageRepository messageRepository;

    MessageCubit(this.messageRepository):super(MessageInitial());

    Future<List<LoyaltyMessage>> fetchMessages() async {
      try{
        emit(MessageLoading());
        final List<LoyaltyMessage> messages = await messageRepository.fetchMessageList();
        var list = messages == null ? new List<LoyaltyMessage>() : messages;
        emit(MessageLoaded(loyaltyMessage: list));
      }catch (e) {
        print(e.toString());
        emit(MessageError("No Network"));
      }
    }

    Future<LoyaltyMessageResponse> postMessage(LoyaltyMessage loyaltyMessage)async{
      try{
        emit(MessageSubmitting());
        final LoyaltyMessageResponse loyaltyMessageResponse = await messageRepository.postMessage(loyaltyMessage);
        //print("CUBIT");
        print(loyaltyMessageResponse.result.message);
        emit(MessageSubmitted(loyaltyMessageResponse: loyaltyMessageResponse));
      }catch(e) {
        print(e.toString());
        emit(MessageError("Unable to post message"));
      }
    }

    Future<LoyaltyMessageResponse> reply(Reply reply)async{
      try{
        //emit(MessageReplySubmitting());
        final LoyaltyMessageResponse loyaltyMessageResponse = await messageRepository.reply(reply);
        //print("CUBIT");
        //print(loyaltyMessageResponse.result.message);
        //emit(MessageReplySubmitted(loyaltyMessageResponse: loyaltyMessageResponse));
        fetchMessages();
        return loyaltyMessageResponse;
      }catch(e) {
        print(e.toString());
        emit(MessageError("Unable to post message"));
      }
    }

    Future<List<MessagePriorities>> fetchMessagePriorities() async {
      try{
        emit(MessagePriorityLoading());
        final List<MessagePriorities> priorities = await messageRepository.fetchPriorities();
        var list = priorities == null ? new List<MessagePriorities>() : priorities;
        emit(MessagePriorityLoaded(messagePriority: priorities));
      }catch (e) {
        print(e.toString());
        emit(MessageError("No Network"));
      }
    }

    Future<List<LoyaltyMessage>> fetchMessageReplies(String msgId) async {
      try{
        emit(MessageReplyLoading());
        final List<LoyaltyMessage> replies = await messageRepository.fetchMessageReplies(msgId);
        var list = replies == null ? new List<LoyaltyMessage>() : replies;
        emit(MessageReplyLoaded(loyaltyMessage:  replies));
      }catch (e) {
        print(e.toString());
        emit(MessageError("No Network"));
      }
    }
}

