import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loyaltyapp/events/bloc/loyalty_event_cubit.dart';
import 'package:loyaltyapp/events/bloc/loyalty_event_state.dart';
import 'package:loyaltyapp/events/loyalty_event_model.dart';
import 'package:loyaltyapp/events/loyalty_event_repository.dart';
import 'package:loyaltyapp/events/view/loyalty_event_list_screen.dart';
import 'package:loyaltyapp/message/bloc/message_cubit.dart';

class LoyaltyEventDetailScreen extends StatefulWidget {
  final String selectedEvent;
  const LoyaltyEventDetailScreen(this.selectedEvent);

  @override
  _LoyaltyEventDetailState createState() => _LoyaltyEventDetailState();
}

class _LoyaltyEventDetailState extends State<LoyaltyEventDetailScreen> {
  bool eventRegistered;
  final repository = LoyaltyEventRepository();

  @override
  void initState() {
    eventRegistered = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          title: Text(
            'Event Details',
            style: TextStyle(fontSize: 20.0),
          )),
      body: BlocProvider(
        create: (context) => LoyaltyEventCubit(LoyaltyEventRepository())
          ..fetchLoyaltyEventDetail(widget.selectedEvent),
        child: Container(
          color: Colors.grey[100],
          height: MediaQuery.of(context).size.height * 0.9,
          margin: EdgeInsets.only(left: 0.5, right: 0.0),
          child: BlocConsumer<LoyaltyEventCubit, LoyaltyEventState>(
            listener: (context, state) {
              if (state is LoyaltyEventDetailsError) {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(state.message),
                ));
              }

              if (state is LoyaltyEventDetailsLoading) {
                return CircularProgressIndicator();
              }
              if (state is LoyaltyEventRegistered) {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 2.0, color: Colors.blue),
                        borderRadius: BorderRadius.circular(20)),
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        state.eventRegistration.text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 1000,
                  behavior: SnackBarBehavior.floating,
                ));
              }
            },
            builder: (context, state) {
              if (state is LoyaltyEventDetailsLoaded) {
                LoyaltyEvent event = state.eventDetails;
                return Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width * 0.99,
                              height: MediaQuery.of(context).size.height * 0.05,
                              //color: Colors.grey[200],
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blue)),
                              child: Card(
                                elevation: 0.0,
                                color: Colors.grey[200],
                                semanticContainer: true,
                                //clipBehavior: Clip.antiAliasWithSaveLayer,
                                margin: EdgeInsets.only(left: 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.13,
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        color: Colors.blue,
                                        //child: Icon(Icons.info)

                                        child: Icon(Icons.info_outline),
                                      ),
                                    ),
                                    Flexible(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: 10, top: 8),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.9,
                                            alignment: Alignment.bottomLeft,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              //color: Color(0x33ffcc33),
                                            ),
                                            child: Text(
                                              event.title,
                                              style: new TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xff00966b)),
                                              softWrap: true,
                                            ),
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
                        margin: EdgeInsets.only(top: 10),
                        height: MediaQuery.of(context).size.height * 0.54,
                        width: MediaQuery.of(context).size.width * 0.95,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                            border: Border.all(color: Colors.grey[300]),
                            color: Colors.grey[100]),
                        child: Row(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  height: MediaQuery.of(context).size.height,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: 25, top: 5),
                                            child: Text(
                                              event.venue,
                                              style: new TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.w500),
                                              maxLines: 5,
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SingleChildScrollView(
                                            child: ConstrainedBox(
                                              constraints: BoxConstraints(
                                                  minHeight: 0,
                                                  minWidth: 0,
                                                  maxHeight: double.infinity,
                                                  maxWidth:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.9),
                                              child: Container(
                                                child: Html(
                                                    data: event.description ==
                                                            null
                                                        ? ""
                                                        : event.description),
                                              ),
                                            ),
                                            /*child: new Container(
                                              width:
                                              MediaQuery.of(context).size.width * 0.89,
                                              height: MediaQuery.of(context).size.width * 0.7,
                                              color: Colors.grey[100],
                                              margin: EdgeInsets.only(left:2, top:5),
                                              child: Html(
                                                  data: event.description == null
                                                      ? ""
                                                      : event
                                                      .description), //Text(event.description),
                                            ),*/
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Align(
                                              alignment: Alignment.bottomRight,
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10),
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        top: 10),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                      //color: Color(0xff00966b),
                                                    ),
                                                    child: Text(
                                                      event.startDate +
                                                          " - " +
                                                          event.endDate,
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xff00966b),
                                                          fontSize: 14),
                                                    ),
                                                  ))),
                                        ],
                                      ),
                                    ],
                                  ),



                                ),
                              ],
                            ),
                            /* ,*/

                            /**/
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.95,
                       /* child: RefreshIndicator(
                          onRefresh: () => repository.fetchEventDocuments(widget.selectedEvent),
                        ),*/
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.95,
                        child: Row(
                          children: [
                            Container(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.94,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(


                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.15,
                                        child: Align(
                                            alignment: Alignment.center,
                                            child: Visibility(
                                              child: RaisedButton(
                                                  child: Text(
                                                    "Register",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0)),
                                                  color: Colors.blue,
                                                  autofocus: true,
                                                  onPressed: () {
                                                    _registerEvent(context);
                                                  }),
                                              visible: _eventRegistration(
                                                  event.eventRegistration,
                                                  event
                                                      .attendance), // event.eventRegistration == 0 ? true : false,
                                            )),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                           height:
                                            MediaQuery.of(context).size.height *
                                                0.15,
                                        child: Align(
                                            alignment: Alignment.center,
                                            child: Visibility(
                                              child: RaisedButton(
                                                  child: Text(
                                                    "Cancel RSVP",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0)),
                                                  color: Colors.blue,
                                                  autofocus: true,
                                                  onPressed: () {
                                                    _cancelRSVP(context);
                                                  }),
                                              visible:
                                                  event.eventRegistration == 1
                                                      ? true
                                                      : false,
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  //),
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  _registerEvent(BuildContext context) {
    //event.eventRegistration == 0
    print(widget.selectedEvent);
    var cubit = LoyaltyEventCubit(LoyaltyEventRepository());
    cubit.registerLoyaltyEvent(widget.selectedEvent).then((value) {
      if (value.code == '1') {
        Fluttertoast.showToast(
            msg: value.text,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => LoyaltyEventListScreen()));
      } else {
        Fluttertoast.showToast(
            msg: value.text,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.orange,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }).catchError((onError) {
      Fluttertoast.showToast(
          msg: onError.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }

  _cancelRSVP(BuildContext context) {
    //event.eventRegistration == 0
    print(widget.selectedEvent);
    var cubit = LoyaltyEventCubit(LoyaltyEventRepository());
    cubit.cancelRSVP(widget.selectedEvent).then((value) {
      Fluttertoast.showToast(
          msg: value.text,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => LoyaltyEventListScreen()));
    }).catchError((onError) {
      Fluttertoast.showToast(
          msg: onError.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }

  _eventRegistration(int eventRegistration, int attendance) {
    print(attendance);
    print(eventRegistration);
    return eventRegistration == 0 ? true : false;
  }
}
