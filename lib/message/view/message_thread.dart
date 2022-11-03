import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loyaltyapp/message/bloc/message_cubit.dart';
import 'package:loyaltyapp/message/message_response.dart';
import 'package:loyaltyapp/message/message_repository.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MessageThread extends StatefulWidget {
  final LoyaltyMessage selectedMsg;
  const MessageThread(this.selectedMsg);
  @override
  _MessageThreadState createState() => _MessageThreadState();
}

class _MessageThreadState extends State<MessageThread> {
  MessageRepository repository = new MessageRepository();
  TextEditingController messageController = new TextEditingController();
  List<LoyaltyMessage> messageThreadList;
  Future<void> _initMessageThreadData;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _initMessageThreadData = initMessageThread();
  }

  @override
  Widget build(BuildContext context) {
    LoyaltyMessage selectedMessage = widget.selectedMsg;
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            title: Text(
              'Message Thread',
              style: TextStyle(fontSize: 20.0),
            )),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Form(
          key: _formKey,
          child: Container(
            height: MediaQuery.of(context).size.height * 1,
            //color: Colors.grey[300],

            child: Column(children: [
              Row(
                children: [
                  Card(
                      elevation: 0.0,
                      //color: Colors.grey[200],
                      margin: EdgeInsets.all(3),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.980,
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: widget.selectedMsg.priority == "High"
                              ? Colors.red
                              : widget.selectedMsg.priority == "Medium"
                                  ? Colors.yellow
                                  : Colors.blue,
                        )),
                        child: Row(
                          //mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.13,
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                color: widget.selectedMsg.priority == "High"
                                    ? Colors.red
                                    : widget.selectedMsg.priority == "Medium"
                                        ? Colors.yellow
                                        : Colors.blue,
                                //child: Icon(Icons.info)

                                child: Icon(widget.selectedMsg.priority ==
                                        "High"
                                    ? Icons.dangerous
                                    : widget.selectedMsg.priority == "Medium"
                                        ? Icons.info_outline
                                        : Icons.info_outline),
                              ),
                            ),
                            Flexible(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.only(left: 10, top: 1),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                        ),
                                        child: Text(
                                          widget.selectedMsg.subject,
                                          style: new TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 2),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          color: Color(0x33ffcc33),
                                        ),
                                        child: new Text(
                                          "",
                                          style: new TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.orangeAccent),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ))
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.70,
                margin: EdgeInsets.only(left: 10, right: 10, top: 5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300], width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  //color: Colors.grey[200]
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(left: 10, top: 10, bottom: 50),
                          child: Text(widget.selectedMsg.message ?? ""),
                        )
                        /* ],
                                ),
                              )*/
                      ],
                    ),
                    SingleChildScrollView(
                      child: Container(
                          height: MediaQuery.of(context).size.height * 0.33,
                          color: Colors.grey[100],
                          child: RefreshIndicator(
                              onRefresh: () =>
                                  _refreshMessageThread(), // repository.fetchMessageReplies(widget.selectedMsg.id.toString()),
                              child: ThreadList(
                                  data:
                                      messageThreadList) /*FutureBuilder(
                                    future: repository
                                        .fetchMessageReplies(widget.selectedMsg.id.toString()),
                                    builder: (context, snapshot) {
                                      return ThreadList(data: snapshot.data);
                                    }
                                ),*/
                              ) /*FutureBuilder(
                                future: repository
                                    .fetchMessageReplies(widget.selectedMsg.id.toString()),
                                builder: (context, snapshot) {
                                  return ThreadList(data: snapshot.data);
                                },
                              ),*/
                          ),
                    ),
                    Expanded(
                        child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(children: [
                            Padding(
                                padding: EdgeInsets.only(left: 10, top: 1),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.854,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black12, width: 1)),
                                  child: TextFormField(
                                    minLines: 3,
                                    maxLines: 6,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Message is a required field.";
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {},
                                    controller: messageController,
                                  ),
                                )),
                          ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.35,
                                      child: new RaisedButton(
                                        splashColor: Colors.pinkAccent,
                                        padding: EdgeInsets.only(
                                            left: 20, right: 10),
                                        color: Colors.green,
                                        child: new Text(
                                          "Reply",
                                          style: new TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.white),
                                        ),
                                        onPressed: () => {
                                          if (_formKey.currentState.validate())
                                            {_reply(context)}
                                        },
                                      ),
                                    ))
                              ]),
                        ],
                      ),
                    ))
                  ],
                ),
              ),
            ]),
          ),
        ))));
  }

  _reply(BuildContext context) {
    String messageId = widget.selectedMsg.id;
    print(messageId);
    MessageCubit cubit = new MessageCubit(MessageRepository());
    cubit
        .reply(Reply(message: messageController.text, messageId: messageId))
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
    });
    //messageThreadList.add(new LoyaltyMessage(message: messageController.text));
    messageController.clear();
    cubit.messageRepository
        .fetchMessageReplies(widget.selectedMsg.id.toString());
    _refreshMessageThread();
    ThreadList(data: messageThreadList);
  }

  Future<void> initMessageThread() async {
    final messageThread =
        await repository.fetchMessageReplies(widget.selectedMsg.id.toString());
    messageThreadList = messageThread;
  }

  Future<void> _refreshMessageThread() async {
    final messageThread =
        await repository.fetchMessageReplies(widget.selectedMsg.id.toString());
    setState(() {
      messageThreadList = messageThread;
    });
  }
}

class ThreadList extends StatelessWidget {
  //final String msgId;
  final List<LoyaltyMessage> data;
  ThreadList({Key key, this.data});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: data == null ? 0 : data.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: Container(
              child: Card(
            elevation: 0,
            color: (index % 2 == 0) ? Colors.grey[200] : Colors.grey[100],
            child: Row(
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "From: ${data[index].sender}",
                            style: new TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.w600),
                          ),
                          new Text(
                            'Date: ${data[index].date ?? ""}',
                            style: new TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        data[index].message ?? "",
                        style: new TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.bold),
                      ),
                      new Text(
                        "",
                        style: new TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '',
                            style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(""),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
          onTap: () {},
        );
      },
    );
  }
}
