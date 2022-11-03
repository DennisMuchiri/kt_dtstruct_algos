import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:loyaltyapp/notices/notice_model.dart';
import 'package:loyaltyapp/networking/api_reponse.dart';
import 'package:loyaltyapp/widgets/loading.dart';
import 'package:loyaltyapp/widgets/error_retry.dart';
import 'package:loyaltyapp/notices/bloc/notice_detail_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

class NoticeDetail extends StatefulWidget {
  final String selectedNotice;
  const NoticeDetail(this.selectedNotice);

  @override
  _NoticeDetailState createState() => _NoticeDetailState();
}

class _NoticeDetailState extends State<NoticeDetail> {
  NoticeDetailBloc _noticeDetailBloc;

  @override
  void initState() {
    super.initState();
    _noticeDetailBloc = NoticeDetailBloc(widget.selectedNotice);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            title: Text(
              'Notice',
              style: TextStyle(fontSize: 20.0),
            )),
        body: Container(
            //color: Colors.grey[300],
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 1.0, right: 1.0),
                  height: MediaQuery.of(context).size.height * 0.82,
                  child: RefreshIndicator(
                    onRefresh: () => _noticeDetailBloc
                        .fetchNoticeDetail(widget.selectedNotice),
                    child: StreamBuilder<ApiResponse<Notice>>(
                      stream: _noticeDetailBloc.campaignDetailStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          switch (snapshot.data.status) {
                            case Status.LOADING:
                              return Loading(
                                  loadingMessage: snapshot.data.message);
                              break;

                            case Status.COMPLETED:
                              return ShowNoticeDetail(
                                  displayNotice: snapshot.data.data);
                              break;
                            case Status.ERROR:
                              return Error(
                                errorMessage: snapshot.data.message,
                                onRetryPressed: () => _noticeDetailBloc
                                    .fetchNoticeDetail(widget.selectedNotice),
                              );
                              break;
                          }
                        }
                        return Container();
                      },
                    ),
                  ),
                ),
              ],
            )));
  }

  @override
  void dispose() {
    _noticeDetailBloc.dispose();
    super.dispose();
  }
}

class ShowNoticeDetail extends StatelessWidget {
  final Notice displayNotice;
  ShowNoticeDetail({Key key, this.displayNotice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height * 0.99,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent),
                    //color: Colors.grey[200]
                  ),
                  height: MediaQuery.of(context).size.height * 0.09,
                  width: MediaQuery.of(context).size.width * 0.98,
                  //semanticContainer: true,
                  //clipBehavior: Clip.antiAliasWithSaveLayer,
                  margin: EdgeInsets.only(left: 1, top: 5, right: 1),
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.13,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.09,
                          color: Colors.blue,
                          //child: Icon(Icons.info)

                          //child: Icon(Icons.info_outline),
                        ),
                      ),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 8, left: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    // color: Color(0x33ffcc33),
                                  ),
                                  child: Text(
                                    displayNotice.startDate +
                                        " - " +
                                        displayNotice.endDate,
                                    style: new TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.green),
                                  ),
                                ),

                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10,left: 10),
                              child: Text(
                                displayNotice.title,
                                style: new TextStyle(
                                  fontSize: 12.0, fontWeight: FontWeight.w500,),
                              )
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  //color: Colors.grey[300],
                  margin: EdgeInsets.only(left: 15, top:20, right: 10),
                  width: MediaQuery.of(context).size.width * 0.93,
                  height: MediaQuery.of(context).size.height * 0.623,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[300]
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.grey[100]
                  ),
                  child: ListTile(
                    title: Html(
                        data: displayNotice.description ??
                            "",style: {
                      "body": Style(
                        fontSize: FontSize(12.0),
                        fontWeight: FontWeight.normal,
                      ),
                    }), //Text(event.description),
                  ),
                )
              ],
            )
          ],
        ),
      ),
      //),
    );
  }
}
