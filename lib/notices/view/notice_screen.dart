import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:loyaltyapp/notices/bloc/notice_bloc.dart';
import 'package:loyaltyapp/notices/bloc/notice_bloc_rx.dart';
import 'package:loyaltyapp/notices/bloc/notice_archived_bloc_rx.dart';
import 'package:loyaltyapp/notices/view/notice_detail.dart';
import 'package:loyaltyapp/notices/notice_model.dart';
import 'package:loyaltyapp/networking/api_reponse.dart';
import 'package:loyaltyapp/widgets/drawer.dart';
import 'package:loyaltyapp/widgets/loading.dart';
import 'package:loyaltyapp/widgets/error_retry.dart';

class NoticeListScreen extends StatefulWidget {
  static const String routeName = '/notice';
  @override
  _NoticeState createState() => _NoticeState();
}

class _NoticeState extends State<NoticeListScreen> with TickerProviderStateMixin {
  NoticeBloc _bloc;
  final String title = "Notices";
  NoticeBlocRx _noticeBlocRx;
  NoticeArchivedBlocRx _noticeArchivedBlocRx;
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
    _bloc = new NoticeBloc();
    _noticeBlocRx = new NoticeBlocRx();
    _noticeArchivedBlocRx = new NoticeArchivedBlocRx();
    _noticeBlocRx.fetchNotices();
    _noticeArchivedBlocRx.fetchArchivedNotices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              scrollDirection: Axis.vertical,
              child: Container(
                  child: Row(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height*0.92,
                        width: MediaQuery.of(context).size.width,
                        // color: Colors.white54,
                        child: RefreshIndicator(
                          /*onRefresh: () async {
                        return await Future.delayed(Duration(seconds: 3));
                      },*/
                          onRefresh: () => _noticeBlocRx.fetchNotices(),
                          child: StreamBuilder<List<Notice>>(
                            stream: _noticeBlocRx.noticeStream,
                            builder: (context, snapshot) {
                              print(snapshot.data?? 'No Data');
                              if (snapshot.hasData) {
                                return NoticeList(noticeList: snapshot.data);
                                /*switch (snapshot.data.status) {
                                  case Status.LOADING:
                                    return Loading(loadingMessage: snapshot.data.message);
                                    break;
                                  case Status.COMPLETED:
                                    return NoticeList(noticeList: snapshot.data.data);
                                    break;
                                  case Status.ERROR:
                                    return Error(
                                        errorMessage: snapshot.data.message,
                                        onRetryPressed: () => _bloc.fetchNoticeList());
                                    break;
                                }*/
                              }
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
                                            "No notices yet",
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
                                  ])
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  )),
            ),
          ),
          Container(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                  child: Row(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height*0.92,
                        width: MediaQuery.of(context).size.width,
                        // color: Colors.white54,
                        child: RefreshIndicator(
                          /*onRefresh: () async {
                        return await Future.delayed(Duration(seconds: 3));
                      },*/
                          onRefresh: () => _noticeArchivedBlocRx.fetchArchivedNotices(),
                          child: StreamBuilder<List<Notice>>(
                            stream: _noticeArchivedBlocRx.archivedNoticeStream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return NoticeArchivedList(noticeArchivedList: snapshot.data);
                                /*switch (snapshot.data.status) {
                                  case Status.LOADING:
                                    return Loading(loadingMessage: snapshot.data.message);
                                    break;
                                  case Status.COMPLETED:
                                    return NoticeList(noticeList: snapshot.data.data);
                                    break;
                                  case Status.ERROR:
                                    return Error(
                                        errorMessage: snapshot.data.message,
                                        onRetryPressed: () => _bloc.fetchNoticeList());
                                    break;
                                }*/
                              }
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
                                            "No archived notices yet",
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
                                  ])
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  )),
            ),
          )
        ],
      )
    );
  }
}

class NoticeList extends StatelessWidget {
  final List<Notice> noticeList;
  const NoticeList({Key key, this.noticeList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: noticeList == null ? 0 : noticeList.length,
      //itemCount: campaignList == null ? 1 : campaignList.length+1,
      itemBuilder: (context, index) {

        return GestureDetector(
          child: Container(
           // color: Colors.grey[100],
            height: 100,
            margin: EdgeInsets.only(right: 7),
            decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: Colors.grey
                  ),
                )
            ),
            child: Card(
              elevation: 0.0,
              color: (index % 2 == 0) ? Colors.grey[100] : Colors.grey[100],
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              margin: EdgeInsets.only(left: 18, top: 5, right: 15, bottom: 5),
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.13,
                    child: Icon(Icons
                        .notifications) /*Image.asset(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Color(0x33ffcc33),
                              ),
                              /*child: Text(
                                noticeList[index].title ,
                                style: new TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange),
                              ),*/
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 8),
                             /* child: new Text(
                                noticeList[index].title,
                                style: new TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),*/
                            )

                          ],
                        ),
                        Text(
                          noticeList[index].title ??"",
                          style: new TextStyle(
                              fontSize: 13.0, fontWeight: FontWeight.w500),
                        ),
                        Flexible(child:

                        new Html(shrinkWrap: false,
                          data: noticeList[index].description == null ? "" : noticeList[index].description.substring(0, noticeList[index].description.length > 36?36:noticeList[index].description.length)+'....',
                        style: {
                          "body": Style(
                            fontSize: FontSize(12.0),
                            fontWeight: FontWeight.normal,
                          ),
                        },),),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    //color: Color(0xff00966b),
                                  ),
                                  child: Text(
                                   "Effective From   "+ noticeList[index].startDate +
                                        " - " +
                                        noticeList[index].endDate,
                                    style: TextStyle(
                                        color: Color(0xff00966b), fontSize: 12),
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NoticeDetail(noticeList[index].id)));
          },
        );
      },
    );
  }
}


class NoticeArchivedList extends StatelessWidget {
  final List<Notice> noticeArchivedList;
  const NoticeArchivedList({Key key, this.noticeArchivedList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: noticeArchivedList == null ? 0 : noticeArchivedList.length,
      //itemCount: campaignList == null ? 1 : campaignList.length+1,
      itemBuilder: (context, index) {

        return GestureDetector(
          child: Container(
            // color: Colors.grey[100],
            height: 100,
            margin: EdgeInsets.only(right: 7),
            decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: Colors.grey
                  ),
                )
            ),
            child: Card(
              elevation: 0.0,
              color: (index % 2 == 0) ? Colors.grey[100] : Colors.grey[100],
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              margin: EdgeInsets.only(left: 18, top: 5, right: 15, bottom: 5),
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.13,
                    child: Icon(Icons
                        .notifications) /*Image.asset(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Color(0x33ffcc33),
                              ),
                              /*child: Text(
                                noticeList[index].title ,
                                style: new TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange),
                              ),*/
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 8),
                              /* child: new Text(
                                noticeList[index].title,
                                style: new TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),*/
                            )

                          ],
                        ),
                        Text(
                          noticeArchivedList[index].title ??"",
                          style: new TextStyle(
                              fontSize: 13.0, fontWeight: FontWeight.w500),
                        ),
                        Flexible(child:

                        new Html(shrinkWrap: false,
                          data: noticeArchivedList[index].description == null ? "" : noticeArchivedList[index].description.substring(0, noticeArchivedList[index].description.length > 36?36:noticeArchivedList[index].description.length)+'....',
                          style: {
                            "body": Style(
                              fontSize: FontSize(12.0),
                              fontWeight: FontWeight.normal,
                            ),
                          },),),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    //color: Color(0xff00966b),
                                  ),
                                  child: Text(
                                    "Effective From   "+ noticeArchivedList[index].startDate +
                                        " - " +
                                        noticeArchivedList[index].endDate,
                                    style: TextStyle(
                                        color: Color(0xff00966b), fontSize: 12),
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NoticeDetail(noticeArchivedList[index].id)));
          },
        );
      },
    );
  }
}