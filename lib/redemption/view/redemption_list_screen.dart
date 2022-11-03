import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loyaltyapp/redemption/view/redeem_points_page.dart';
import 'package:loyaltyapp/widgets/destination.dart';
import 'package:loyaltyapp/widgets/drawer.dart';
import 'package:loyaltyapp/redemption/redemption_model.dart';
import 'package:loyaltyapp/redemption/bloc/redemption_state.dart';
import 'package:loyaltyapp/redemption/bloc/redemption_cubit.dart';
import 'package:loyaltyapp/redemption/redemption_repository.dart';

class RedemptionListScreen extends StatefulWidget {
  static const String routeName = '/redemptions';
  //const RedemptionListScreen({Key key,this.destination}):super(key: key);
const RedemptionListScreen();
  static  Destination destination;
  @override
  _RedemptionListState createState() => _RedemptionListState();
}

class _RedemptionListState extends State<RedemptionListScreen> {

  var amount;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    amount = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My Redemptions"),
        ),
      drawer: AppDrawer(),
      body: BlocProvider(
        create: (context) => RedemptionCubit(RedemptionRepository())..fetchRedemptions(),
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.grey[100],
          child: BlocConsumer<RedemptionCubit, RedemptionState>(
            listener: (context, state) {
              if (state is RedemptionError) {
                if (state is RedemptionError) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(state.message),
                  ));
                }
              }
            },
            builder: (context, state) {
              if (state is RedemptionInitial) {
                return Container(
                  width: 0,
                  height: 0,
                );
              } else if (state is RedemptionLoading) {
                print("LOADING....");
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is RedemptionLoaded) {
                  amount = state.redemptions == null ? 0 : state.redemptions[0].amountRedeemed;
                return Container(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      BlocProvider.of<RedemptionCubit>(context)..fetchRedemptions();
                    },
                    child: RedemptionList(redemptionsList: state.redemptions),
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          /*Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => MessageScreen())).then((value) => setState(() {}));*/
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RedeemPointsPage()),
          ).then(onGoBack);
        },
        //child: Icon(Icons.add),
        label: Text("Redeem",style: TextStyle(
          fontSize: 14, fontWeight: FontWeight.bold
        ),),
        tooltip: "Redeem",
        backgroundColor: Colors.blue,
      ),
    );
  }
  onGoBack(dynamic value) {
    //refreshData();
    setState(() {});
  }
}

class RedemptionList extends StatelessWidget {
  final List<Redemption> redemptionsList;

  const RedemptionList({Key key, this.redemptionsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (redemptionsList == null || redemptionsList.length == 0) {
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
                    "No redemptions yet",
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
      return ListView.builder(
        itemCount: redemptionsList == null ? 0 : redemptionsList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Container(
              height: 100,
              margin: EdgeInsets.only(left: 10, right: 10),
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
                //margin: EdgeInsets.only(left: 18, top: 5, right: 15, bottom: 15),
                child: Row(
                  children: [

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
                                  //color: Color(0x33ffcc33),
                                ),
                                child: Text(
                                  redemptionsList[index].redemptionDate,
                                  style: new TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff00966b)),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 8),
                                child: new Text("Amount Redeemed: " +
                                    redemptionsList[index].amountRedeemed,
                                  style: new TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              )

                            ],
                          ),
                          Text(
                            "Redemption type: "+redemptionsList[index].redemptionType,
                            style: new TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.w500),
                            softWrap: true,
                          ),
                          new Text(
                            redemptionsList[index].comments,
                            softWrap: true,
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
                                    child: Text("Running Balance: " +
                                        redemptionsList[index].runningBalance,
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
              /*Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CampaignDetail(campaignList[index].id)));*/
            },
          );
        },
      );
    }
  }
}