import 'package:bottom_bar_with_sheet/bottom_bar_with_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loyaltyapp/claim/bloc/claim_cubit.dart';
import 'package:loyaltyapp/claim/bloc/claim_state.dart';
import 'package:loyaltyapp/claim/claim_model.dart';
import 'package:loyaltyapp/claim/claim_repository.dart';
import 'package:loyaltyapp/claim/view/claim_page.dart';
import 'package:loyaltyapp/claim/view/claim_details_page.dart';
import 'package:loyaltyapp/widgets/destination.dart';
import 'package:loyaltyapp/widgets/drawer.dart';
import 'package:loyaltyapp/widgets/bottom_navigator.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ClaimListScreen extends StatefulWidget {
  static const String routeName = '/claims';
  const ClaimListScreen({Key key, this.destination}) : super(key: key);

  final Destination destination;

  @override
  _ClaimListState createState() => _ClaimListState();
}

class _ClaimListState extends State<ClaimListScreen> {
  double timeDilation = 10.0;
  bool _denied = false;
  bool _pending = false;
  bool _approved = false;

  final _filterDate = TextEditingController();
  var maskFormatter = new MaskTextInputFormatter(mask: '##/##/####');
  //final _filterDate = TextEditingController();

  DateTime currentDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
      });
  }

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Claims"),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Filter'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      /*  bottomNavigationBar: BottomBarWithSheet(
      selectedIndex: _selectedIndex,
      sheetChild: Center(child: Text("Place for your another content")),
      bottomBarTheme: BottomBarTheme(
        mainButtonPosition: MainButtonPosition.Middle,
      ),
      mainActionButtonTheme: MainActionButtonTheme(
        size: 55,
        icon: Icon(
          Icons.add,
          color: Colors.white,
          size: 35,
        ),
      ),
      onSelectItem: (index) => setState(() => _selectedIndex = index),
      items: [
        BottomBarWithSheetItem(icon: Icons.people),
        BottomBarWithSheetItem(icon: Icons.shopping_cart),
        BottomBarWithSheetItem(icon: Icons.settings),
        BottomBarWithSheetItem(icon: Icons.favorite),
      ],
    ),*/
      //BottomNavigator(),
      body: BlocProvider(
        create: (context) => ClaimCubit(ClaimRepository())..fetchClaims(),
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          //color: Colors.grey[200],
          child: BlocConsumer<ClaimCubit, ClaimState>(
            listener: (context, state) {
              if (state is ClaimError) {
                if (state is ClaimError) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(state.message),
                  ));
                }
              }
            },
            builder: (context, state) {
              if (state is ClaimInitial) {
                return Container(
                  width: 0,
                  height: 0,
                );
              } else if (state is ClaimLoading) {
                print("LOADING....");
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is ClaimLoaded) {
                return Container(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      BlocProvider.of<ClaimCubit>(context)..fetchClaims();
                    },
                    child: ClaimList(claimsList: state.claims),
                  ),
                );
              } else if (state is ClaimFiltering) {
                print("Filtering....");
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is ClaimFiltered) {
                return Container(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      BlocProvider.of<ClaimCubit>(context)..fetchClaims();
                    },
                    child:Container(),// ClaimList(claimsList: state.claims),
                  ),
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
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ClaimScreen()));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void handleClick(String value) {
    switch (value) {
      case 'Logout':
        break;
      case 'Filter':
        /*print("Redeem Points");
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => RedeemPointsPage()));*/
        showModalBottomSheet(
            context: context,
            builder: (BuildContext ctx) {
              return Container(
                height: MediaQuery.of(ctx).size.height * 0.39,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Positioned(
                          child: Align(
                            alignment: FractionalOffset.centerLeft,
                            child: Text("Filter"),
                          ),
                        ),
                        Positioned(
                          child: Align(
                            alignment: FractionalOffset.centerRight,
                            child: Text("Clear"),
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        Positioned(

                            //alignment: FractionalOffset.centerRight,
                            child: StatefulBuilder(builder:
                                (BuildContext context, StateSetter setState) {
                          return Center(
                            child: CheckboxListTile(
                              title: const Text('Approved'),
                              value: _approved,
                              onChanged: (bool value) {
                                setState(() {
                                  _approved = value;
                                });
                              },
                              //secondary: const Icon(Icons.hourglass_empty),
                            ),
                          );
                        }))
                      ],
                    ),
                    Stack(
                      children: [
                        Positioned(

                            //alignment: FractionalOffset.centerRight,
                            child: StatefulBuilder(builder:
                                (BuildContext context, StateSetter setState) {
                          return Center(
                            child: CheckboxListTile(
                              title: const Text('Pending'),
                              value: _pending,
                              onChanged: (bool value) {
                                setState(() {
                                  _pending = value;
                                });
                              },
                              //secondary: const Icon(Icons.hourglass_empty),
                            ),
                          );
                        }))
                      ],
                    ),
                    Stack(
                      children: [
                        Positioned(

                            //alignment: FractionalOffset.centerRight,
                            child: StatefulBuilder(builder:
                                (BuildContext c, StateSetter setState) {
                          return Center(
                            child: CheckboxListTile(
                              title: const Text('Denied'),
                              value: _denied,
                              onChanged: (bool value) {
                                setState(() {
                                  _denied = value;
                                });
                              },
                              //secondary: const Icon(Icons.hourglass_empty),
                            ),
                          );
                        }))
                      ],
                    ),
                    Stack(
                      children: [
                        Positioned(
                          child: Align(
                            alignment: FractionalOffset.bottomLeft,
                            child: Text(
                              "Date",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        Positioned(
                            child: Align(
                          alignment: FractionalOffset.bottomRight,
                          child: TextField(
                            inputFormatters: [maskFormatter],
                          ),
                        ))
                      ],
                    ),
                    Stack(
                      children: [
                        Positioned(
                          child: Align(
                            alignment: FractionalOffset.bottomLeft,
                            child: FlatButton(
                              color: Color(0xff00966b),
                              child: Text(
                                "Apply Filter",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                print(_denied);
                                _submitFilter(context);
                              },
                            ),
                          ),
                        ),
                        Positioned(
                            child: Align(
                          alignment: FractionalOffset.bottomRight,
                          child: FlatButton(
                            child: Text("Cancel"),
                          ),
                        ))
                      ],
                    ),
                  ],
                ),
              );
            });
        break;
    }
  }

  void _submitFilter(BuildContext context) async {
    // BlocProvider.of<ClaimCubit>(context).fetchById("2");
    //Future<Claim> c = BlocProvider.of<ClaimCubit>(context).fetchById("2");
    //ClaimList(claimsList: []);
    /*context
        .bloc<ClaimCubit>()
        .filterClaims();*/

    ClaimFilter filter = ClaimFilter(
        approved: _approved,
        denied: _denied,
        pending: _pending,
        date: _filterDate.value.toString());
    //ClaimCubit(ClaimRepository())..filterClaims(filter);
    ClaimCubit(ClaimRepository())..filterClaims(filter);
    //context.bloc<ClaimCubit>().filterClaims(filter);
  }
}

class ClaimList extends StatelessWidget {
  final List<Claim> claimsList;

  const ClaimList({Key key, this.claimsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int bgColor = 0xff00966b;
    if (claimsList == null || claimsList.length == 0) {
      return Container(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height *0.4),
                  child: Text(
                    "No claims yet",
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
                    "Kindly click the button below \nto add a claim",
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
        itemCount: claimsList == null ? 0 : claimsList.length,
        itemBuilder: (context, index) {
          String status = claimsList[index]
              .status
              .substring(claimsList[index].status.lastIndexOf(' '));

          switch (status) {
            case 'Approved':
              bgColor = 0xff00966b;
              break;
            case 'Denied':
              bgColor = 0xffef453a;
              break;
            case 'Pending':
              bgColor = 0xff00966b;
              break;
            case 'Submitted':
              bgColor = 0xff00966c;
              break;
          }

          return GestureDetector(

            child: Container(
              height: 90,
              decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        color: Colors.grey
                    ),
                  )
              ),
              child: Card(
                elevation: 0.0,
                //color: (index % 2 == 0) ? Colors.grey[100] : Colors.grey[100],
                //color: Colors.grey[100],
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                margin: EdgeInsets.only(left: 18, top: 1, right: 15),
                child: Row(
                  children: [
                    /*SizedBox(
                  width: MediaQuery.of(context).size.width * 0.15,
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: Container(
                    width: 40,
                    height: 40,
                    child: Stack(
                      children:[Container(
                          margin: EdgeInsets.only(left: 10,top: 5),
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
                          )
                      ),
                        ],
                    ),
                  ),
                ),*/
                    Container(
                      child: Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '#${claimsList[index].invoiceNumber ?? ""}',
                                  style: new TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.normal),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 10, top: 15),
                                  decoration: BoxDecoration(
                                      color: Color(bgColor)),
                                  child: new Text(
                                    status,
                                    style: new TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                            /* Text(
                        claimsList[index].text??"",
                        style: new TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.w400),
                      ),
                      new Text(
                       "location",
                       style: new TextStyle(
                         fontSize: 14.0,
                         fontWeight: FontWeight.normal,
                       ),
                     ),*/
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  //'Amount: '+ claimsList[index].discounted == "[]" ? "" : 'Amount: '+claimsList[index].discounted,
                                  'Amount: '+ claimsList[index].invoiceAmount.toString(),
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff00966b)),
                                ),
                                /*Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Icon(Icons.data_usage),
                          ),*/
                              ],
                            ),
                           /* Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Non Discounted:  ${claimsList[index].nonDiscounted??
                                      ""}',
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff00966b)),
                                ),
                                *//*Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Icon(Icons.data_usage),
                          ),*//*
                              ],
                            ),*/
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Purchase Date: ${claimsList[index]
                                      .dateDiscarded ?? ""}',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                /*Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text("Points Earned: "),
                            ),*/
                              ],
                            ),
                          ],
                        ),
                      ),
                    )

                  ],
                ),
              ),
            ),
            onTap: () {
              //print(claimsList[index].status.substring(claimsList[index].status.lastIndexOf(' ')));
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      ClaimDetailsPage(claimsList[index].id, claimsList[index].status.substring(claimsList[index].status.lastIndexOf(' ')))));
            },
          );
          /*return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ClaimDetailsPage(claimsList[index].id)));
          },
          child: Container(
            child: Column(
              children: <Widget>[
                Card(
                  color: Colors.grey[200],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: ListTile(
                          title: Text(claimsList[index].customerName ?? ""),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: ListTile(
                          title: Text(claimsList[index].invoiceNumber ?? ""),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: ListTile(
                          title: Text(claimsList[index].order ?? ""),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );*/
        },
      );
    }
  }
}

class ClaimDialog extends StatefulWidget {
  ClaimDialog({BuildContext context});
  @override
  _ClaimDialogState createState() => new _ClaimDialogState();
}

class _ClaimDialogState extends State<ClaimDialog> {
  String _dateTxt = "";
  bool _denied = false;
  bool _pending = false;
  bool _approved = false;

  final _filterDate = TextEditingController();
  var maskFormatter = new MaskTextInputFormatter(mask: '##/##/####');

  DateTime currentDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
      });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Positioned(
              child: Align(
                alignment: FractionalOffset.centerLeft,
                child: Text("Filter"),
              ),
            ),
            Positioned(
              child: Align(
                alignment: FractionalOffset.centerRight,
                child: Text("Clear"),
              ),
            ),
          ],
        ),
        Stack(
          children: [
            Positioned(

                //alignment: FractionalOffset.centerRight,
                child: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
              return Center(
                child: CheckboxListTile(
                  title: const Text('Approved'),
                  value: _approved,
                  onChanged: (bool value) {
                    setState(() {
                      _approved = value;
                    });
                  },
                  //secondary: const Icon(Icons.hourglass_empty),
                ),
              );
            }))
          ],
        ),
        Stack(
          children: [
            Positioned(

                //alignment: FractionalOffset.centerRight,
                child: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
              return Center(
                child: CheckboxListTile(
                  title: const Text('Pending'),
                  value: _pending,
                  onChanged: (bool value) {
                    setState(() {
                      _pending = value;
                    });
                  },
                  //secondary: const Icon(Icons.hourglass_empty),
                ),
              );
            }))
          ],
        ),
        Stack(
          children: [
            Positioned(

                //alignment: FractionalOffset.centerRight,
                child: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
              return Center(
                child: CheckboxListTile(
                  title: const Text('Denied'),
                  value: _denied,
                  onChanged: (bool value) {
                    setState(() {
                      _denied = value;
                    });
                  },
                  //secondary: const Icon(Icons.hourglass_empty),
                ),
              );
            }))
          ],
        ),
        Stack(
          children: [
            Positioned(
              child: Align(
                alignment: FractionalOffset.bottomLeft,
                child: Text(
                  "Date",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            Positioned(
                child: Align(
              alignment: FractionalOffset.bottomRight,
              child: TextField(
                inputFormatters: [maskFormatter],
              ),
            ))
          ],
        ),
        Stack(
          children: [
            Positioned(
              child: Align(
                alignment: FractionalOffset.bottomLeft,
                child: FlatButton(
                  color: Color(0xff00966b),
                  child: Text(
                    "Apply Filter",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    print(_denied);
                    _submitFilter();
                  },
                ),
              ),
            ),
            Positioned(
                child: Align(
              alignment: FractionalOffset.bottomRight,
              child: FlatButton(
                child: Text("Cancel"),
              ),
            ))
          ],
        ),
      ],
    );
  }

  _submitFilter() {
    print("here");
    ClaimFilter filter = ClaimFilter(
        approved: _approved,
        denied: _denied,
        pending: _pending,
        date: _filterDate.value.toString());
    ClaimCubit(ClaimRepository())..filterClaims(filter);
  }
}
