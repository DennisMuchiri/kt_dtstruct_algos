import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loyaltyapp/events/bloc/loyalty_event_bloc.dart';
import 'package:loyaltyapp/events/bloc/loyalty_event_bloc_rx.dart';
import 'package:loyaltyapp/events/bloc/loyalty_event_archived_bloc_rx.dart';
import 'package:loyaltyapp/events/loyalty_event_model.dart';
import 'package:loyaltyapp/events/view/loyalt_event_detail_screen.dart';
import 'package:loyaltyapp/networking/api_reponse.dart';
import 'package:loyaltyapp/widgets/drawer.dart';
import 'package:loyaltyapp/widgets/error_retry.dart';
import 'package:loyaltyapp/widgets/loading.dart';

class LoyaltyEventListScreen extends StatefulWidget {
  static const String routeName = "/event";

  @override
  _LoyaltyEventListState createState() => _LoyaltyEventListState();
}

class _LoyaltyEventListState extends State<LoyaltyEventListScreen>
    with TickerProviderStateMixin {
  LoyaltyEventBloc _loyaltyEventBloc;
  LoyaltyEventBlocRx _loyaltyEventBlocRx;
  LoyaltyEventArchivedBlocRx _loyaltyEventArchivedBlocRx;
  TabController _controller;
  final String title = "Events";
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
    _loyaltyEventBloc = LoyaltyEventBloc();
    _loyaltyEventBlocRx = new LoyaltyEventBlocRx();
    _loyaltyEventArchivedBlocRx = new LoyaltyEventArchivedBlocRx();
    _loyaltyEventBlocRx.fetchLoyaltyEvents();
    _loyaltyEventArchivedBlocRx.fetchArchivedLoyaltyEvents();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: Text(title),
              bottom: TabBar(
                controller: _controller,
                isScrollable: true,
                /*indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(50), // C
                color: Colors.greenAccent,

            ),*/
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Colors.white,
                labelPadding: EdgeInsets.symmetric(horizontal: 10.0),
                onTap: (e) {},
                tabs: [
                  //Tab(icon: Icon(Icons.archive)),
                  //Tab(icon: Icon(Icons.campaign_sharp))
                  new Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: new Tab(text: 'Active'),
                  ),
                  new Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: new Tab(text: 'Archived'),
                  ),
                ],
              ),
            ),
            drawer: AppDrawer(),
            body: TabBarView(
              controller: _controller,
              children: [
                Container(
                  child: SingleChildScrollView(
                      child: Row(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height * 0.99,
                        width: MediaQuery.of(context).size.width * 1.0,
                        color: Colors.grey[100],
                        child: RefreshIndicator(
                          onRefresh: () =>
                              _loyaltyEventBlocRx.fetchLoyaltyEvents(),
                          child: StreamBuilder<List<LoyaltyEvent>>(
                            stream: _loyaltyEventBlocRx.loyaltyEventStream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                /*switch (snapshot.data.status) {
                                    case Status.LOADING:
                                      return Loading(
                                          loadingMessage: snapshot.data.message);
                                      break;
                                    case Status.COMPLETED:
                                      return LoyaltyEventList(
                                          loyaltyEventList: snapshot.data.data);
                                      break;
                                    case Status.ERROR:
                                      return Error(
                                          errorMessage: snapshot.data.message,
                                          onRetryPressed: () =>
                                              _loyaltyEventBloc.fetchLoyaltyEventList());
                                      break;
                                  }*/
                                return LoyaltyEventList(
                                    loyaltyEventList: snapshot.data);
                              }
                              return Container(
                                  child: Column(children: [
                                Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.5),
                                      child: Text(
                                        "No events yet",
                                        style: TextStyle(
                                          color: Color(0xff00966b),
                                          fontSize: 24,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ]));
                            },
                          ),
                        ),
                      )
                    ],
                  )),
                ),
                Container(
                  child: SingleChildScrollView(
                      child: Row(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height * 0.99,
                        width: MediaQuery.of(context).size.width * 1.0,
                        color: Colors.grey[100],
                        child: RefreshIndicator(
                          onRefresh: () => _loyaltyEventArchivedBlocRx
                              .fetchArchivedLoyaltyEvents(),
                          child: StreamBuilder<List<LoyaltyEvent>>(
                            stream: _loyaltyEventArchivedBlocRx
                                .archivedLoyaltyEventStream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                /*switch (snapshot.data.status) {
                                    case Status.LOADING:
                                      return Loading(
                                          loadingMessage: snapshot.data.message);
                                      break;
                                    case Status.COMPLETED:
                                      return LoyaltyEventList(
                                          loyaltyEventList: snapshot.data.data);
                                      break;
                                    case Status.ERROR:
                                      return Error(
                                          errorMessage: snapshot.data.message,
                                          onRetryPressed: () =>
                                              _loyaltyEventBloc.fetchLoyaltyEventList());
                                      break;
                                  }*/
                                return LoyaltyEventList(
                                    loyaltyEventList: snapshot.data);
                              }
                              return Container(
                                  child: Column(children: [
                                Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.5),
                                      child: Text(
                                        "No archived events yet",
                                        style: TextStyle(
                                          color: Color(0xff00966b),
                                          fontSize: 24,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ]));
                            },
                          ),
                        ),
                      )
                    ],
                  )),
                )
              ],
            )));
  }
}

class LoyaltyEventList extends StatelessWidget {
  final List<LoyaltyEvent> loyaltyEventList;

  const LoyaltyEventList({Key key, this.loyaltyEventList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (loyaltyEventList == null || loyaltyEventList.length == 0) {
      return Container(
          child: Column(children: [
        Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.5),
              child: Text(
                "No events yet",
                style: TextStyle(
                  color: Color(0xff00966b),
                  fontSize: 24,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        )
      ]));
    } else {
      return ListView.builder(
        itemCount: loyaltyEventList == null ? 0 : loyaltyEventList.length,
        itemBuilder: (context, index) {
          return Container(
            child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => LoyaltyEventDetailScreen(
                          loyaltyEventList[index].id)));
                },
                child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    //color: Colors.grey[200],
                    decoration: BoxDecoration(
                        border: Border(
                      bottom: BorderSide(color: Colors.grey),
                    )),
                    margin: EdgeInsets.only(right: 7),
                    child: Card(
                      elevation: 0.0,
                      color: (index % 2 == 0)
                          ? Colors.grey[100]
                          : Colors.grey[100],
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      margin: EdgeInsets.only(left: 18, top: 5, right: 15),
                      child: Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.13,
                            child: Icon(Icons
                                .event) /*Image.asset(
                      "assets/images/banane.jpg",
                      fit: BoxFit.fill,
                    )*/
                            ,
                          ),
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 9),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        // color: Color(0xff00966b),
                                      ),
                                      child: Text(
                                        loyaltyEventList[index].category,
                                        style: new TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff00966b)),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 9),
                                      child: Text(
                                        loyaltyEventList[index]
                                            .startDate +
                                            " - " +
                                            loyaltyEventList[index]
                                                .endDate,
                                        style: TextStyle(
                                            color: Color(0xff00966b),
                                            fontSize: 14),
                                      ),
                                      /*new Text(
                                        "Attendance: " +
                                            loyaltyEventList[index]
                                                .maxAttendance,
                                        style: new TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),*/
                                    )
                                  ],
                                ),
                                Text(
                                  loyaltyEventList[index].title,
                                  style: new TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500),
                                  softWrap: true,
                                ),
                                new Text(
                                  loyaltyEventList[index].venue ?? "",
                                  style: new TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SingleChildScrollView(
                                      child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10, bottom: 10),
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.019,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              //color: Color(0xff00966b),
                                            ),
                                            /*child: Text(
                                              loyaltyEventList[index]
                                                      .startDate +
                                                  " - " +
                                                  loyaltyEventList[index]
                                                      .endDate,
                                              style: TextStyle(
                                                  color: Color(0xff00966b),
                                                  fontSize: 14),
                                            ),*/
                                          )),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
          );
        },
        /*separatorBuilder: (context,index){
      return Divider();
      },*/
      );
    }
  }
}

class LoyaltyEventArchivedList extends StatelessWidget {
  final List<LoyaltyEvent> loyaltyEventArchivedList;

  const LoyaltyEventArchivedList({Key key, this.loyaltyEventArchivedList})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (loyaltyEventArchivedList == null) {
      return Container(
        alignment: Alignment.center,
        child: Text(
          "No Records Found.",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: loyaltyEventArchivedList == null
            ? 0
            : loyaltyEventArchivedList.length,
        itemBuilder: (context, index) {
          return Container(
            child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => LoyaltyEventDetailScreen(
                          loyaltyEventArchivedList[index].id)));
                },
                child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    //color: Colors.grey[200],
                    decoration: BoxDecoration(
                        border: Border(
                      bottom: BorderSide(color: Colors.grey),
                    )),
                    margin: EdgeInsets.only(right: 7),
                    child: Card(
                      elevation: 0.0,
                      color: (index % 2 == 0)
                          ? Colors.grey[100]
                          : Colors.grey[100],
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      margin: EdgeInsets.only(left: 18, top: 5, right: 15),
                      child: Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.13,
                            child: Icon(Icons
                                .event) /*Image.asset(
                      "assets/images/banane.jpg",
                      fit: BoxFit.fill,
                    )*/
                            ,
                          ),
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        // color: Color(0xff00966b),
                                      ),
                                      child: Text(
                                        loyaltyEventArchivedList[index]
                                            .category,
                                        style: new TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff00966b)),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 8),
                                      child: new Text(
                                        "Attendance: " +
                                            loyaltyEventArchivedList[index]
                                                .maxAttendance,
                                        style: new TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Text(
                                  loyaltyEventArchivedList[index].title,
                                  style: new TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500),
                                  softWrap: true,
                                ),
                                new Text(
                                  loyaltyEventArchivedList[index].venue ?? "",
                                  style: new TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SingleChildScrollView(
                                      child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10, bottom: 10),
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.019,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              //color: Color(0xff00966b),
                                            ),
                                            child: Text(
                                              loyaltyEventArchivedList[index]
                                                      .startDate +
                                                  " - " +
                                                  loyaltyEventArchivedList[
                                                          index]
                                                      .endDate,
                                              style: TextStyle(
                                                  color: Color(0xff00966b),
                                                  fontSize: 14),
                                            ),
                                          )),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
          );
        },
        /*separatorBuilder: (context,index){
      return Divider();
      },*/
      );
    }
  }
}
