import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loyaltyapp/claim/bloc/claim_cubit.dart';
import 'package:loyaltyapp/claim/bloc/claim_state.dart';
import 'package:loyaltyapp/claim/claim_repository.dart';

import '../claim_model.dart';

class ClaimDisputeScreen extends StatefulWidget {
  final String selectedClaim;
  const ClaimDisputeScreen(this.selectedClaim); //this.selectedClaim

  @override
  _ClaimDisputeState createState() => _ClaimDisputeState();
}

class _ClaimDisputeState extends State<ClaimDisputeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _messageController = TextEditingController();
  var repository = ClaimRepository();

  List<ClaimDisputeReply> replyThreadList;
  List<ClaimDisputeMessage> messageThreadList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          title: Text(
            'Claim Dispute Replies',
            style: TextStyle(fontSize: 20.0),
          )),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Form(
              key: _formKey,
              child: SizedBox(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /*Text("Messages"),
                      SingleChildScrollView(
                        child: Container(
                            height: MediaQuery.of(context).size.height * 0.25,
                            color: Colors.grey[100],
                            child: RefreshIndicator(
                                onRefresh: () => _refreshReplyThread(widget
                                    .selectedClaim), // repository.fetchMessageReplies(widget.selectedMsg.id.toString()),
                                child: ReplyList(data: replyThreadList))),
                      ),*/
                      Text("Replies"),
                      SingleChildScrollView(
                        child: Container(
                            height: MediaQuery.of(context).size.height * 0.25,
                            color: Colors.grey[100],
                            child: RefreshIndicator(
                                onRefresh: () => _refreshMessageThread(widget
                                    .selectedClaim), // repository.fetchMessageReplies(widget.selectedMsg.id.toString()),
                                child: MessageList(data: messageThreadList))),
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Message',
                              labelStyle: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 17,
                                  fontFamily: 'AvenirLight'),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              enabledBorder: new UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 1.0)),
                            ),
                            controller: _messageController,
                            minLines: 3,
                            maxLines: 6,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter message';
                              }
                              return null;
                            },
                          ))
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(left: 100, right: 1),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    print(widget.selectedClaim);
                                    _dispute(context, widget.selectedClaim);
                                  }
                                },
                                child: Text("Send Message."),
                              ))
                        ],
                      )
                    ]),
              )),
        ),
      ),
    );
  }

  Future<void> _refreshReplyThread(String invoice_id) async {
    final messageThread = await repository.fetchReplies(invoice_id);
    setState(() {
      replyThreadList = messageThread;
    });
  }

  Future<void> _refreshMessageThread(String invoice_id) async {
    final messageThread = await repository.fetchMessages(invoice_id);
    setState(() {
      messageThreadList = messageThread;
    });
  }

  _dispute(BuildContext context, String claimId) {
    var claimCubit = ClaimCubit(ClaimRepository());
    claimCubit
        .dispute(
            ClaimDisputeReply(message: _messageController.text, id: claimId))
        .then((value) => {
          print("Value from then ${value.text}"),

              Fluttertoast.showToast(
                  msg: value.text,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 40,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0)
            }).catchError((onError){
      Fluttertoast.showToast(
          msg: onError.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 10,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    }).whenComplete(() => {

      _messageController.clear()
    });

    print(claimCubit.state);
  }
}

class ReplyList extends StatelessWidget {
  //final String msgId;
  final List<ClaimDisputeReply> data;
  ReplyList({Key key, this.data});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
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
                                "From: ${data[index].message}",
                                style: new TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w600),
                              ),
                              /*new Text(
                                'Date: ${data[index].date ?? ""}',
                                style: new TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),*/
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
                        ],
                      ),
                    ),
                  ],
                ),
              )),
              onTap: () {},
            );
          }),
    );
  }
}

class MessageList extends StatelessWidget {
  //final String msgId;
  final List<ClaimDisputeMessage> data;
  MessageList({Key key, this.data});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
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
                                "From: ${data[index].message}",
                                style: new TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w600),
                              ),
                              /*new Text(
                                'Date: ${data[index].date ?? ""}',
                                style: new TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),*/
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
                        ],
                      ),
                    ),
                  ],
                ),
              )),
              onTap: () {},
            );
          }),
    );
  }
}
