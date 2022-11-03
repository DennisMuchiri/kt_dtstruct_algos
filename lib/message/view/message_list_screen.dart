import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loyaltyapp/message/bloc/MessageState.dart';
import 'package:loyaltyapp/message/bloc/message_cubit.dart';
import 'package:loyaltyapp/message/message_repository.dart';
import 'package:loyaltyapp/message/message_response.dart';
import 'package:loyaltyapp/widgets/bottom_navigator.dart';
import 'package:loyaltyapp/widgets/destination.dart';
import 'message.dart';
import 'package:loyaltyapp/widgets/drawer.dart';
import 'package:loyaltyapp/message/view/message_thread.dart';

class MessageListScreen extends StatefulWidget {
  static const String routeName = '/messages';
  const MessageListScreen({Key key, this.destination}) : super(key: key);

  final Destination destination;
  @override
  _MessageListState createState() => _MessageListState();
}

class _MessageListState extends State<MessageListScreen> {
  final _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Messages", textAlign: TextAlign.center),
      ),
      drawer: AppDrawer(),
      //bottomNavigationBar: BottomNavigator(),
      body: BlocProvider(
        create: (context) => MessageCubit(MessageRepository())..fetchMessages(),
        child: Container(
          //color: Colors.grey[300],
          child: BlocConsumer<MessageCubit, MessageState>(
            listener: (context, state) {
              if (state is MessageError) {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(state.message),
                ));
              }
            },
            builder: (context, state) {
              if (state is MessageInitial) {

                return Container();
              } else if (state is MessageLoading) {

                return Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is MessageLoaded) {
                return RefreshIndicator(
                  onRefresh: () async {
                    BlocProvider.of<MessageCubit>(context)..fetchMessages();
                  },
                  child: MessageList(
                      messageList: state.loyaltyMessage,
                      messageController: _messageController,
                      cubitContext: context,
                      msgState: state),
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          /*Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => MessageScreen())).then((value) => setState(() {}));*/
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MessageScreen()),
          ).then(onGoBack);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void refreshData() async {
    MessageCubit(MessageRepository())..fetchMessages();
  }

  onGoBack(dynamic value) {
    refreshData();
    setState(() {});
  }
}

class MessageList extends StatelessWidget {
  final List<LoyaltyMessage> messageList;
  final TextEditingController messageController;
  final BuildContext cubitContext;
  final MessageState msgState;
  const MessageList(
      {Key key,
      this.messageList,
      this.messageController,
      this.cubitContext,
      this.msgState})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String categoryTxt = "";
    int color = 0xff00966b;

    if (messageList == null || messageList.length == 0) {
      return Container(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height *0.5),
                  child: Text(
                    "No messages yet",
                    style: TextStyle(
                      color: Color(0xff00966b),
                      fontSize: 24,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: Text(
                    "Kindly click the button below \nto start a conversation",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xcc1f2430),
                      fontSize: 16,
                    ),
                  ),
                )
              ],
            )

          ],
        ),
      );
    } else {
      return ListView.builder(
        itemCount: messageList == null ? 1 : messageList.length, // + 1,
        itemBuilder: (context, index) {
          //String firstChar = messageList[index].category[0];
          String priority = messageList[index].priority;

          /*switch (firstChar) {
            case "C":
              categoryTxt = "C";
              color = 0xffef453a;
              break;
            case "I":
              categoryTxt = "I";
              color = 0xff37c978;
              break;
            case "S":
              categoryTxt = "S";
              color = 0xff00966b;
              break;
          }*/
          switch (priority) {
            case "High":
              categoryTxt = "C";
              color = 0xffef453a;
              break;
            case "Low":
              categoryTxt = "I";
              color = 0xff00966b;
              break;
            case "Medium":
              categoryTxt = "S";
              color = 0xFFFFC107;//0xff37c978;
              break;
          }

          return GestureDetector(
            child: Container(
                //color: Colors.grey.withOpacity(0.10),
                decoration: BoxDecoration(
                    border: Border(
                  bottom: BorderSide(color: Colors.grey),
                )),
                child: Card(
                  elevation: 0.0,
                  color: (index % 2 == 0) ? Colors.grey[100] : Colors.grey[100],
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.15,
                        height: MediaQuery.of(context).size.height * 0.09,
                        child: Container(
                          width: 40,
                          height: 40,
                          child: Stack(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(
                                      left: 10, top: 15, bottom: 15),
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(color),
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      categoryTxt,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  )),
                              /*Positioned(

                           child:Container(
                             margin: EdgeInsets.only(left: 23,top: 5),
                             child: Text(
                               categoryTxt,
                               textAlign: TextAlign.center,
                               style: TextStyle(
                                 color: Colors.white,
                                 fontSize: 24,
                                 fontFamily: "Poppins",
                                 fontWeight: FontWeight.w600,

                               ),
                             ),
                           )

                       )*/
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  messageList[index].subject ?? "",
                                  style: new TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff00966b)),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 10, bottom: 5),
                                  child: new Text(
                                    messageList[index].date ?? "",
                                    style: new TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Text(
                              '${messageList[index].priority ?? ""} Priority',
                              style: new TextStyle(
                                  fontSize: 13.0, fontWeight: FontWeight.w400),
                            ),
                            /* new Text(
                       "location",
                       style: new TextStyle(
                         fontSize: 14.0,
                         fontWeight: FontWeight.normal,
                       ),
                     ),*/
                            Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Container(
                           margin: EdgeInsets.only(top:5),
                           child: Text(
                             messageList[index].message.substring(0, messageList[index].message.length > 36 ? 36 : messageList[index].message.length),
                             style: TextStyle(
                               fontSize: 13.0,
                               fontWeight: FontWeight.normal,
                             ),
                           ),
                         ),

                         Padding(
                           padding:
                           const EdgeInsets.symmetric(horizontal: 8.0),
                           //child: Icon(Icons.data_usage),
                         ),
                       ],
                     ),/**/
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MessageThread(messageList[index])));
            },
          );
        },
      );
    }
  }

  _reply(BuildContext context, MessageState state, String message,
      String messageId) {
    print(messageId);
    BlocProvider.of<MessageCubit>(context)
        .reply(Reply(message: message, messageId: messageId))
        .then((value) => Fluttertoast.showToast(
            msg: value.result.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0))
        .catchError((onError) {
      Fluttertoast.showToast(
          msg: onError.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }).whenComplete(() => Navigator.of(context).pop());
  }
}

class MessageReplyForm extends StatefulWidget {
  @override
  _MessageReplyState createState() => _MessageReplyState();
}

class _MessageReplyState extends State<MessageReplyForm> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
