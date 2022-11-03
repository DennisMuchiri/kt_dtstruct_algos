import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
//import 'package:loyaltyapp/campaign/bloc/campaign_bloc.dart';
import 'package:loyaltyapp/campaign/bloc/campaign_bloc_rx.dart';
import 'package:loyaltyapp/campaign/bloc/campaign_archived_bloc_rx.dart';
import 'package:loyaltyapp/campaign/view/campaign_detail.dart';
import 'package:loyaltyapp/campaign/campaign_model.dart';
import 'package:loyaltyapp/widgets/drawer.dart';


class CampaignScreen extends StatefulWidget {
  static const String routeName = '/campaign';
  @override
  _CampaignState createState() => _CampaignState();
}

class _CampaignState extends State<CampaignScreen>
    with TickerProviderStateMixin {
  //CampaignBloc _bloc;
  CampaignBlocRx _blocRx;
  CampaignArchivedBlocRx _archivedBlocRx;
  final String title = "Campaigns";
  TabController _controller;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
    //_bloc = new CampaignBloc();
    _blocRx = new CampaignBlocRx();
    _archivedBlocRx = new CampaignArchivedBlocRx();
    _blocRx.fetchCampaign();
    _archivedBlocRx.fetchArchivedCampaign();
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
                        child: RefreshIndicator(
                          onRefresh: () => _blocRx.fetchCampaign(),
                          child: StreamBuilder<List<Campaign>>(
                            stream: _blocRx.campaignStream,
                            builder: (context, AsyncSnapshot<List<Campaign>> snapshot) {
                              if (snapshot.hasData) {
                                //return Container(child: Text(snapshot.data[0].item)) ;
                                return CampaignList(
                                    campaignList: snapshot.data);
                              }
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height *0.5),
                                child: Text(
                                  "No campaigns yet",
                                  style: TextStyle(
                                    color: Color(0xff00966b),
                                    fontSize: 24,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              );
                            },
                          ),
                        ))),
                Container(
                    child: SingleChildScrollView(
                        child: RefreshIndicator(
                  onRefresh: () => _archivedBlocRx.fetchArchivedCampaign(),
                  child: StreamBuilder<List<Campaign>>(
                    stream: _archivedBlocRx.archivedCampaignStream,
                    builder: (context, AsyncSnapshot<List<Campaign>> snapshot) {
                      if (snapshot.hasData) {
                        //return Container(child: Text(snapshot.data[0].item)) ;
                        return ArchivedCampaignList(
                            archivedCampaignList: snapshot.data);
                      }
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height *0.5),
                        child: Text(
                          "No archived campaigns yet",
                          style: TextStyle(
                            color: Color(0xff00966b),
                            fontSize: 24,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    },
                  ),
                )))
              ],
            )));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class CampaignList extends StatelessWidget {
  final List<Campaign> campaignList;
  const CampaignList({Key key, this.campaignList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (campaignList == null || campaignList.length == 0) {
      return Container(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height *0.5),
                  child: Text(
                    "No campaigns yet",
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

          ],
        ),
      );
    } else {
      return Container(
          child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            itemCount: campaignList == null ? 0 : campaignList.length,
            //itemCount: campaignList == null ? 1 : campaignList.length+1,
            itemBuilder: (context, index) {
              return GestureDetector(
                child: Container(
                  height: 109,
                  margin: EdgeInsets.only(right: 7),
                  decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey),
                      )),
                  child: Card(
                    elevation: 0.0,
                    color: (index % 2 == 0) ? Colors.grey[100] : Colors.grey[100],
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    //margin: EdgeInsets.only(left: 18, top: 0, right: 15, bottom: 15),
                    child: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.13,
                          child: Icon(Icons
                              .campaign) /*Image.asset(
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
                                    child: Text(
                                      campaignList[index].discountValue +
                                          "" +
                                          campaignList[index].discountType +" OFF on all "+campaignList[index].item,
                                      style: new TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.orange),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 8),
                                    /*child: new Text(
                                      campaignList[index].item,
                                      style: new TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),*/
                                  )
                                ],
                              ),
                              Text(
                                campaignList[index].campaign,
                                style: new TextStyle(
                                    fontSize: 15.0, fontWeight: FontWeight.w500),
                              ),
                              new Text(
                                campaignList[index].itemDescription,
                                overflow: TextOverflow.ellipsis,

                                style: new TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(left: 0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(4),
                                          //color: Color(0xff00966b),
                                        ),
                                        child: Text(
                                          "Effective From: "+campaignList[index].startDate +
                                              " - " +
                                              campaignList[index].endDate,
                                          style: TextStyle(
                                              color: Color(0xff00966b),
                                              fontSize: 14),
                                        ),
                                      )
                                  ),
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
                      builder: (context) =>
                          CampaignDetail(campaignList[index].id)));
                },
              );
            },
          )
          )
      );
    }
  }
}

class ArchivedCampaignList extends StatelessWidget {
  final List<Campaign> archivedCampaignList;
  const ArchivedCampaignList({Key key, this.archivedCampaignList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (archivedCampaignList == null) {
      return Container(
        alignment: Alignment.center,
        child: Text(
          "No Records Found.",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      );
    } else {
      return Container(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
              itemCount: archivedCampaignList == null
                  ? 0
                  : archivedCampaignList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: Container(
                    height: 109,
                    margin: EdgeInsets.only(right: 7),
                    decoration: BoxDecoration(
                        border: Border(
                      bottom: BorderSide(color: Colors.grey),
                    )),
                    child: Card(
                      elevation: 0.0,
                      color: (index % 2 == 0)
                          ? Colors.grey[100]
                          : Colors.grey[100],
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      //margin: EdgeInsets.only(left: 18, top: 0, right: 15, bottom: 15),
                      child: Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.13,
                            child: Icon(Icons
                                .campaign) /*Image.asset(
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
                                        color: Color(0x33ffcc33),
                                      ),
                                      child: Text(
                                        archivedCampaignList[index]
                                                .discountValue +
                                            "" +
                                            archivedCampaignList[index]
                                                .discountType +" OFF on all "+archivedCampaignList[index].item,
                                        style: new TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.orange),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 8),
                                      /*child: new Text(
                                        archivedCampaignList[index].item,
                                        style: new TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),*/
                                    )
                                  ],
                                ),
                                Text(
                                  archivedCampaignList[index].campaign,
                                  style: new TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                new Text(
                                  archivedCampaignList[index].itemDescription,
                                  overflow: TextOverflow.ellipsis,
                                  style: new TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            //color: Color(0xff00966b),
                                          ),
                                          child: Text(
                                           "Effective From   "+ archivedCampaignList[index]
                                                    .startDate +
                                                " - " +
                                                archivedCampaignList[index]
                                                    .endDate,
                                            style: TextStyle(
                                                color: Color(0xff00966b),
                                                fontSize: 14),
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
                        builder: (context) =>
                            CampaignDetail(archivedCampaignList[index].id)));
                  },
                );
              }),
        ),
      );
      /*return ListView.builder(
        itemCount: archivedCampaignList == null ? 0 : archivedCampaignList.length,
        //itemCount: campaignList == null ? 1 : campaignList.length+1,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Container(
              height: 109,
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
                //margin: EdgeInsets.only(left: 18, top: 0, right: 15, bottom: 15),
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.13,
                      child: Icon(Icons
                          .campaign) /*Image.asset(
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
                                child: Text(
                                  archivedCampaignList[index].discountValue +
                                      "" +
                                      archivedCampaignList[index].discountType,
                                  style: new TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 8),
                                child: new Text(
                                  archivedCampaignList[index].item,
                                  style: new TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              )

                            ],
                          ),
                          Text(
                            archivedCampaignList[index].campaign,
                            style: new TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.w500),
                          ),
                          new Text(
                            archivedCampaignList[index].itemDescription,
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
                                    child: Text(
                                      archivedCampaignList[index].startDate +
                                          " - " +
                                          archivedCampaignList[index].endDate,
                                      style: TextStyle(
                                          color: Color(0xff00966b),
                                          fontSize: 14),
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
                  builder: (context) =>
                      CampaignDetail(archivedCampaignList[index].id)));
            },
          );
        },
      );*/
    }
  }
}
