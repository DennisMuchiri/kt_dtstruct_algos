import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loyaltyapp/claim/bloc/claim_cubit.dart';
import 'package:loyaltyapp/claim/bloc/claim_state.dart';
import 'package:loyaltyapp/claim/claim_model.dart';
import 'package:loyaltyapp/claim/claim_repository.dart';
import 'package:loyaltyapp/widgets/drawer.dart';

class ClaimScreen extends StatefulWidget {
  @override
  _ClaimState createState() => _ClaimState();
}

class _ClaimState extends State<ClaimScreen> {
  final _searchController = TextEditingController();
  final _invoiceIdController = TextEditingController();
  bool enableButton;
  @override
  void initState() {
    enableButton = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Claim"),
      ),
      body: BlocProvider(
        create: (context) => ClaimCubit(ClaimRepository()),
        child: Container(
          child: BlocConsumer<ClaimCubit, ClaimState>(
            listener: (context, state) {
              if (state is ClaimSearchSubmitted) {
                print(state.claimSearchResponse.length);
                if (state.claimSearchResponse.length == 1) {
                  Claim claim = state.claimSearchResponse[0];
                  //print(claim.text);
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(claim.text??""),
                  ));
                }
                if (state is ClaimSearchSubmitting) {
                  enableButton = false;
                }
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 10),
                child: Form(
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: "Search",
                              ),
                              controller: _searchController,
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: ElevatedButton(
                              onPressed: () {
                                _search(context);
                              },
                              child: Text("Search"),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: ClaimList(context, state),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                            child: ElevatedButton(
                              onPressed: enableButton
                                  ? () {
                                      // Validate returns true if the form is valid, or false
                                      // otherwise.
                                      /*if (_formKey.currentState.validate()) {
                                  // If the form is valid, display a Snackbar.

                                  _submitForm(context, state);
                                }*/
                                      _submitClaim(context, state);
                                    }
                                  : null,
                              child: Text('Submit'),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  _search(BuildContext context) {
    enableButton = false;
    context
        .read<ClaimCubit>()
        //.bloc<ClaimCubit>()
        .search(Claim(invoiceNumber: _searchController.text));
  }

  _submitClaim(BuildContext context, ClaimState state) {
    context.read<ClaimCubit>()
        //.bloc<ClaimCubit>()
        .addClaim(Claim(invoiceId: _invoiceIdController.text));
  }

  Widget ClaimList(BuildContext context, ClaimState state) {
    if (state is ClaimSearchSubmitted) {
      if (state.claimSearchResponse.length > 1) {
        enableButton = true;
        final List<Claim> claimsList = state.claimSearchResponse;
        return Container(
          height: MediaQuery.of(context).size.height * 0.6,
          child: CustomScrollView(slivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount:
                              claimsList == null ? 1 : claimsList.length + 1,
                          itemBuilder: (context, index) {
                            if (claimsList.length > 1) {
                              _invoiceIdController.text =  claimsList[0].invoiceId.toString();
                              print('lists');
                              print(claimsList[0].invoiceId.toString());
                            }
                            if (index == 0) {

                              return Column(
                                //mainAxisAlignment: MainAxisAlignment.start,
                                //child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        child: ListTile(
                                          title: Text("Customer",
                                              style: TextStyle(
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: Text("Description.",
                                              style: TextStyle(
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: Text("Amount",
                                              style: TextStyle(
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                                // ),
                              );
                            }
                            index -= 1;
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.1,
                              width: MediaQuery.of(context).size.width,
                              child:SingleChildScrollView(
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                          flex: 2,
                                          child: ListTile(
                                            title: Text(
                                                claimsList[index].customerName ??
                                                    ""),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: ListTile(
                                            title: Text(
                                                claimsList[index].fullDescription ??
                                                    ""),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: ListTile(
                                            title: Text(
                                                claimsList[index].salesInclVat ?? ""),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )

                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ]),
            ),
          ]),
        );
      } else if (state.claimSearchResponse.length == 0) {

        Fluttertoast.showToast(
            msg: "Not found.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } else {
      return Container();
    }
    return Container();
  }
}
