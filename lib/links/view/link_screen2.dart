import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loyaltyapp/links/bloc/link_bloc.dart';
import 'package:loyaltyapp/campaign/view/campaign_detail.dart';
import 'package:loyaltyapp/links/link_model.dart';
import 'package:loyaltyapp/networking/api_reponse.dart';
import 'package:loyaltyapp/widgets/drawer.dart';
import 'package:loyaltyapp/widgets/loading.dart';
import 'package:loyaltyapp/widgets/error_retry.dart';

import 'link_detail.dart';

class LinkScreen2 extends StatefulWidget {
  static const String routeName = '/link';
  @override
  _LinkState2 createState() => _LinkState2();
}

class _LinkState2 extends State<LinkScreen2> {
  LinkBloc _bloc;
  final String title = "Links";

  @override
  void initState() {
    super.initState();
    _bloc = new LinkBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
            child: Row(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.white54,
              child: RefreshIndicator(
                /*onRefresh: () async {
                        return await Future.delayed(Duration(seconds: 3));
                      },*/
                onRefresh: () => _bloc.fetchCampaignList(),
                child: StreamBuilder<ApiResponse<List<Link>>>(
                  stream: _bloc.campaignListStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      switch (snapshot.data.status) {
                        case Status.LOADING:
                          return Loading(loadingMessage: snapshot.data.message);
                          break;
                        case Status.COMPLETED:
                          return CampaignList(campaignList: snapshot.data.data);
                          break;
                        case Status.ERROR:
                          return Error(
                              errorMessage: snapshot.data.message,
                              onRetryPressed: () => _bloc.fetchCampaignList());
                          break;
                      }
                    }
                    return Container();
                  },
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}

class CampaignList extends StatelessWidget {
  final List<Link> campaignList;
  const CampaignList({Key key, this.campaignList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: campaignList == null ? 0 : campaignList.length,
      //itemCount: campaignList == null ? 1 : campaignList.length+1,
      itemBuilder: (context, index) {
        if (index == 0) {
          /*return Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: ListTile(
                      title: Text("Campaign",style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text("Start Date",style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text("End Date",style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              )
            ],
          );*/
        }
        //index -= 1;
        return GestureDetector(
          child: Container(
            height: 100,
            margin: EdgeInsets.only(right: 7),
            child: Card(
              elevation: 0.5,
              color: Colors.white,
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              margin: EdgeInsets.only(left: 18, top: 5, right: 15, bottom: 15),
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.13,
                    child: Icon(Icons
                        .link) /*Image.asset(
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
                              margin: EdgeInsets.only(top: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Color(0x33ffcc33),
                              ),
                             /* child: Text(
                                campaignList[index].discountValue +
                                    "" +
                                    campaignList[index].discountType,
                                style: new TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange),
                              ),*/
                            ),
                            /*Container(
                              margin: EdgeInsets.only(top: 8),
                              child: new Text(
                                campaignList[index].linkName ??"",
                                style: new TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            )*/

                          ],
                        ),
                        Text(
                          campaignList[index].linkName ??"",
                          style: new TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.w500),
                        ),
                        new Text(
                          campaignList[index].linkUrl ??"",
                          style: new TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
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
                                 /* child: Text(
                                    campaignList[index].startDate +
                                        " - " +
                                        campaignList[index].endDate,
                                    style: TextStyle(
                                        color: Color(0xff00966b), fontSize: 14),
                                  ),*/
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
                builder: (context) => LinkDetail(campaignList[index].id)));
          },
        );
      },
    );
  }
}
