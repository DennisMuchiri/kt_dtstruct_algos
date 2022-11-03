import 'dart:core';

import 'package:customtogglebuttons/customtogglebuttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:group_radio_button/group_radio_button.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:loyaltyapp/dropdowns/category_bloc.dart';
import 'package:loyaltyapp/dropdowns/dropdown_item_model.dart';
import 'package:loyaltyapp/dropdowns/priority_bloc.dart';
import 'package:loyaltyapp/message/bloc/MessageState.dart';
import 'package:loyaltyapp/message/bloc/message_cubit.dart';
import 'package:loyaltyapp/message/bloc/message_recipient_bloc.dart';
import 'package:loyaltyapp/message/message_repository.dart';
import 'package:loyaltyapp/message/message_response.dart';
import 'package:loyaltyapp/message/view/message_list_screen.dart';
import 'package:loyaltyapp/networking/api_reponse.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class MessageScreen extends StatefulWidget {
  static const String routeName = '/message';
  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<MessageScreen> {
  LoyaltyMessage messageModel = new LoyaltyMessage();

  PriorityBloc _priorityBloc;
  CategoryBloc _categoryBloc;
  MessageRecipientBloc _messageRecipientBloc;

  List _recipients = [];

  final _formKey = GlobalKey<FormState>();
  final _messageController = TextEditingController();
  final _subjectController = TextEditingController();
  final _priorityController = TextEditingController();
  final _categoryController = TextEditingController();

  final textFieldValueHolder = TextEditingController();

  String _singleValue = "Text alignment right";
  String _verticalGroupValue = "Pending";

  List<String> _status = ["Pending", "Released", "Blocked"];
  int _radioValue1 = -1;
  int correctScore = 0;
  bool _hasPriorityBeenPressed = false;
  List<bool> isSelected = []; //[false, false, false];
  List<bool> isCategorySelected = [];

  int _selectedIndex;
  int _selectedPriorityIndex;

  @override
  void initState() {
    _priorityBloc = PriorityBloc();
    _categoryBloc = CategoryBloc();
    _messageRecipientBloc = MessageRecipientBloc();
    // _localNotificationsPlugin = FlutterLocalNotificationsPlugin();

    _recipients = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final title = 'Compose Message';
    String radioButtonItem = 'ONE';
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight =
        size.height * 0.09; //(size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    int id = 1;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, () {
          setState(() {});
        });
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: BlocProvider(
          create: (context) => MessageCubit(MessageRepository()),
          child: Container(
            decoration: BoxDecoration(color: Colors.grey.withOpacity(0.009)),
            height: MediaQuery.of(context).size.height * 0.99,
            width: MediaQuery.of(context).size.width * 0.99,
            child: BlocConsumer<MessageCubit, MessageState>(
              listener: (context, state) {
                if (state is MessageError) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(state.message),
                  ));
                }

                if (state is MessageSubmitting) {
                  return CircularProgressIndicator();
                }
                if (state is MessageSubmitted) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Container(
                      decoration: BoxDecoration(
                          color: Colors.green,
                          border: Border.all(width: 2.0, color: Colors.green),
                          borderRadius: BorderRadius.circular(20)),
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 75),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          state.loyaltyMessageResponse.result.message,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                    ),
                    backgroundColor: Colors.transparent,
                    elevation: 1000,
                    behavior: SnackBarBehavior.floating,
                  ));
                  _subjectController.clear();
                  _messageController.clear();
                  //_priorityController.clear();
                }
                print(state);
                if (state is MessagePriorityLoaded) {
                  //print("Message PriorityLoaded");
                }
              },
              builder: (context, state) {
                return Container(
                    // <-- wrap this around
                    width: MediaQuery.of(context).size.width * 0.95,
                    height: MediaQuery.of(context).size.height * 0.90,
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(
                                        9.3, 0.02, 9.33, 0.57),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          labelText: "Subject",
                                          labelStyle: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                                color: HexColor("#1F2430")),
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            fontStyle: FontStyle.normal,
                                          )),
                                      controller: _subjectController,
                                    ),
                                    width: 305,
                                    height: 68,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(
                                        9.3, 0.004, 9.3, 0.004),
                                    child: TextFormField(
                                      maxLines: 3,
                                      decoration: InputDecoration(
                                          labelText: "Message",
                                          labelStyle: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                                color: HexColor("#1F2430")),
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            fontStyle: FontStyle.normal,
                                          )),
                                      validator: (txtVal) {
                                        if (txtVal == null || txtVal.isEmpty) {
                                          return 'Please Enter Message';
                                        }
                                        return null;
                                      },
                                      controller: _messageController,
                                    ),
                                    width: 305,
                                    height: 100,
                                  ),
                                )
                              ],
                            ),
                            /*Row(
                              children: [
                                new Expanded(
                                    child: new Container(
                                  margin: const EdgeInsets.all(4.0),
                                  child: StreamBuilder<ApiResponse<List<MessagePriority>>>(
                                    stream: _priorityBloc.priorityListStream,
                                    builder: (context, snapshot) {
                                      print(snapshot.data);
                                      if (snapshot.hasData) {
                                        switch (snapshot.data.status) {
                                          case Status.COMPLETED:
                                            print("Message Priority {}");

                                            return Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey[300]),
                                                ),
                                                child: Column(
                                                  children: <Widget>[
                                                    Padding(
                                                        padding: EdgeInsets.all(
                                                            14.0),
                                                        child: Text(
                                                            'Select the priority level of the message below:',
                                                            style: TextStyle(
                                                                fontSize: 21))),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: List.generate(
                                                          snapshot.data.data
                                                              .length, (index) {
                                                        isSelected.add(false);
                                                        return Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 8,
                                                                    right: 2),
                                                            child: FlatButton(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              30.0),
                                                                  side: BorderSide(
                                                                      color: Colors
                                                                          .black,
                                                                      width:
                                                                          1)),
                                                              child: Text(
                                                                snapshot
                                                                    .data
                                                                    .data[index]
                                                                    .priority,
                                                                style: TextStyle(
                                                                    color: isSelected[
                                                                            index]
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .black),
                                                              ),
                                                              onPressed: () {
                                                                setState(() {
                                                                  for (int indexBtn =
                                                                          0;
                                                                      indexBtn <
                                                                          isSelected
                                                                              .length;
                                                                      indexBtn++) {
                                                                    if (indexBtn ==
                                                                        index) {
                                                                      isSelected[
                                                                              indexBtn] =
                                                                          true;
                                                                    } else {
                                                                      isSelected[
                                                                              indexBtn] =
                                                                          false;
                                                                    }
                                                                  }
                                                                  _priorityController
                                                                          .text =
                                                                      snapshot
                                                                          .data
                                                                          .data[
                                                                              index]
                                                                          .id;
                                                                });
                                                              },
                                                              color: isSelected[
                                                                      index]
                                                                  ? Color(
                                                                      0xff00966b)
                                                                  : Colors
                                                                      .white,
                                                            ));
                                                      }),
                                                    )
                                                  ],
                                                ));

                                            break;
                                        }
                                      } else {
                                        return Container();
                                      }
                                      return Container();
                                    },
                                  ),
                                )),
                              ],
                            ),*/
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                new Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: new Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.893,
                                    margin: const EdgeInsets.all(4.0),
                                    child: StreamBuilder<
                                        ApiResponse<List<MessagePriority>>>(
                                      stream: _priorityBloc.priorityListStream,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          switch (snapshot.data.status) {
                                            case Status.COMPLETED:
                                              return Column(
                                                children: <Widget>[
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.all(14.0),
                                                      child: Text(
                                                          'Select the priority level of the message below:',
                                                          style: TextStyle(
                                                              fontSize: 21))),
                                                  Container(
                                                      child: GridView.count(
                                                    crossAxisCount: 3,
                                                    controller:
                                                        new ScrollController(
                                                            keepScrollOffset:
                                                                false),
                                                    shrinkWrap: true,
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    childAspectRatio:
                                                        (itemWidth /
                                                            itemHeight),
                                                    children: List.generate(
                                                        snapshot.data.data
                                                            .length, (index) {
                                                      isCategorySelected
                                                          .add(false);
                                                      return Container(
                                                          //color: Colors.white,
                                                          child: Center(
                                                              child: ChoiceChip(
                                                        selected:
                                                            _selectedPriorityIndex ==
                                                                index,
                                                        label: Text(
                                                            snapshot
                                                                .data
                                                                .data[index]
                                                                .priority,
                                                            style: TextStyle(
                                                                color: _selectedPriorityIndex ==
                                                                        index
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black)),
                                                        elevation: 10,
                                                        pressElevation: 5,
                                                        shadowColor:
                                                            Colors.white,
                                                        backgroundColor:
                                                            Colors.grey[200],
                                                        selectedColor:
                                                            Color(0xff00966b),
                                                        onSelected:
                                                            (bool selected) {
                                                          setState(() {
                                                            if (selected) {
                                                              _selectedPriorityIndex =
                                                                  index;
                                                              _priorityController
                                                                  .text =
                                                                  snapshot
                                                                      .data
                                                                      .data[
                                                                  index]
                                                                      .id;
                                                            }
                                                          });
                                                        },
                                                      )

                                                              ));
                                                    }),
                                                  )
                                                      )
                                                ],
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
                            ),
                            Divider(
                              color: Colors.grey,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                new Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: new Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.893,
                                    margin: const EdgeInsets.all(4.0),
                                    child: StreamBuilder<
                                        ApiResponse<List<Category>>>(
                                      stream: _categoryBloc.categoryListStream,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          switch (snapshot.data.status) {
                                            case Status.COMPLETED:
                                              return Column(
                                                children: <Widget>[
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.all(14.0),
                                                      child: Text(
                                                          'What is the message about?:',
                                                          style: TextStyle(
                                                              fontSize: 21))),
                                                  Container(
                                                      child: GridView.count(
                                                    crossAxisCount: 2,
                                                    controller:
                                                        new ScrollController(
                                                            keepScrollOffset:
                                                                false),
                                                    shrinkWrap: true,
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    childAspectRatio:
                                                        (itemWidth /
                                                            itemHeight),
                                                    children: List.generate(
                                                        snapshot.data.data
                                                            .length, (index) {
                                                      isCategorySelected
                                                          .add(false);
                                                      return Container(
                                                          //color: Colors.white,
                                                          child: Center(
                                                              child: ChoiceChip(
                                                        selected:
                                                            _selectedIndex ==
                                                                index,
                                                        label: Text(
                                                            snapshot
                                                                .data
                                                                .data[index]
                                                                .category,
                                                            style: TextStyle(
                                                                color: _selectedIndex ==
                                                                        index
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black)),
                                                        elevation: 10,
                                                        pressElevation: 5,
                                                        shadowColor:
                                                            Colors.white,
                                                        backgroundColor:
                                                            Colors.grey[200],
                                                        selectedColor:
                                                            Color(0xff00966b),
                                                        onSelected:
                                                            (bool selected) {
                                                          setState(() {
                                                            if (selected) {
                                                              _selectedIndex =
                                                                  index;
                                                              _categoryController
                                                                  .text =
                                                                  snapshot
                                                                      .data
                                                                      .data[index]
                                                                      .id;
                                                            }
                                                          });
                                                        },
                                                      ) /*FlatButton(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            30.0),
                                                                    side: BorderSide(
                                                                        color: Colors
                                                                            .black,
                                                                        width:
                                                                            1)),
                                                                child: Text(
                                                                  snapshot
                                                                      .data
                                                                      .data[
                                                                          index]
                                                                      .category,
                                                                  style: TextStyle(
                                                                      color: isCategorySelected[
                                                                              index]
                                                                          ? Colors
                                                                              .white
                                                                          : Colors
                                                                              .black),
                                                                ),
                                                                onPressed: () { */
                                                              /*for (int indexBtn = 0; indexBtn < isCategorySelected.length; indexBtn++) {
                                                                    print(indexBtn);
                                                                    print(index);
                                                                    if (indexBtn == index) {

                                                                      isCategorySelected[indexBtn] = true;
                                                                    } else {
                                                                      isCategorySelected[indexBtn] = false;
                                                                    }
                                                                  }*/
                                                              //print(isCategorySelected);

                                                              //isCategorySelected[index] = true;
                                                              //print(index);
                                                              //_categoryController.text = snapshot.data.data[index].id;
                                                              // },
                                                              //color: isCategorySelected[index] ? Color(0xff00966b) : Colors.white,
                                                              //),

                                                              ));
                                                    }),
                                                  ) /*Row(
                                                   mainAxisAlignment:
                                                   MainAxisAlignment
                                                       .start,
                                                   children: List.generate(
                                                       snapshot.data.data.length,
                                                           (index) {
                                                         isCategorySelected.add(false);

                                                         return Container(
                                                           //width: MediaQuery.of(context).size.width * 0.84,
                                                             child: Padding(
                                                                 padding: EdgeInsets.only(
                                                                     left: 8, right: 0),
                                                                 child: FlatButton(
                                                                   shape: RoundedRectangleBorder(
                                                                       borderRadius:
                                                                       BorderRadius
                                                                           .circular(
                                                                           30.0),
                                                                       side: BorderSide(
                                                                           color: Colors
                                                                               .black,
                                                                           width: 1)),
                                                                   child: Text(
                                                                     snapshot
                                                                         .data
                                                                         .data[index]
                                                                         .category,
                                                                     style: TextStyle(
                                                                         color:
                                                                         isCategorySelected[
                                                                         index]
                                                                             ? Colors
                                                                             .white
                                                                             : Colors
                                                                             .black),
                                                                   ),
                                                                   onPressed: () {
                                                                     setState(() {
                                                                       for (int indexBtn =
                                                                       0;
                                                                       indexBtn <
                                                                           isCategorySelected
                                                                               .length;
                                                                       indexBtn++) {
                                                                         if (indexBtn ==
                                                                             index) {
                                                                           isCategorySelected[
                                                                           indexBtn] =
                                                                           true;
                                                                         } else {
                                                                           isCategorySelected[
                                                                           indexBtn] =
                                                                           false;
                                                                         }
                                                                       }
                                                                       _categoryController
                                                                           .text =
                                                                           snapshot
                                                                               .data
                                                                               .data[index]
                                                                               .id;
                                                                     });
                                                                   },
                                                                   color:
                                                                   isCategorySelected[
                                                                   index]
                                                                       ? Color(
                                                                       0xff00966b)
                                                                       : Colors.white,
                                                                 ))
                                                         );
                                                       }),
                                                 ),*/
                                                      )
                                                ],
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
                            ),
                            Divider(),
                            Row(children: [
                              new Expanded(
                                child: new Container(
                                  margin: const EdgeInsets.all(10.0),
                                  child: StreamBuilder<
                                      ApiResponse<List<MessageRecipient>>>(
                                    stream: _messageRecipientBloc
                                        .messageRecipientListStream,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        switch (snapshot.data.status) {
                                          case Status.COMPLETED:
                                            var data = [];
                                            snapshot.data.data
                                                .forEach((element) {
                                              data.add({
                                                "value": element.value,
                                                "display": element.display
                                              });
                                            });

                                            return MultiSelectFormField(
                                              autovalidate: false,
                                              chipBackGroundColor: Colors.blue,
                                              chipLabelStyle: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                              dialogTextStyle: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                              checkBoxActiveColor: Colors.blue,
                                              checkBoxCheckColor: Colors.white,
                                              dialogShapeBorder:
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12.0))),
                                              title: Text(
                                                "Recipients",
                                                style: TextStyle(fontSize: 16),
                                              ),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.length == 0) {
                                                  return 'Please select one or more options';
                                                }
                                                return null;
                                              },
                                              dataSource: data,
                                              textField: 'display',
                                              valueField: 'value',
                                              okButtonLabel: 'OK',
                                              cancelButtonLabel: 'CANCEL',
                                              hintWidget: Text(
                                                  'Please choose one or more'),
                                              initialValue: _recipients,
                                              onSaved: (value) {
                                                if (value == null) return;
                                                setState(() {
                                                  _recipients = value;
                                                });
                                              },
                                            );
                                            break;
                                          case Status.ERROR:
                                            print(snapshot.data.message);
                                            break;
                                        }
                                      }
                                      return Container();
                                    },
                                  ),
                                ),
                              ),
                            ]),
                            Row(
                              //mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.only(left: 40, top: 10, bottom: 10),
                                  //alignment: FractionalOffset.bottomCenter,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Color(0xff00966b)),
                                    onPressed: () {
                                      // Validate returns true if the form is valid, or false
                                      // otherwise.
                                      if (_formKey.currentState.validate()) {
                                        // If the form is valid, display a Snackbar.

                                        _submitForm(context, state);
                                      }
                                    },
                                    child: RichText(
                                      text: TextSpan(children: [
                                        WidgetSpan(
                                            child: Icon(
                                          Icons.send_sharp,
                                          color: Colors.white,
                                          size: 15,
                                        )),
                                        TextSpan(
                                            style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                    color: Colors.white),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                            text: " Send Message")
                                      ]),
                                    ),
                                  ),
                                  width: 305,
                                  height: 48,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ));
              },
            ),
          ),
        ),
      ),
    );
  }

  _priorityCtrls(BuildContext context, MessagePriority data) {
    return new RaisedButton(
      child: Text("Test"),
    );
  }

  _submitForm(BuildContext context, MessageState state) {
    final messageCubit = context
        //.bloc<MessageCubit>()
        .read<MessageCubit>();
    messageCubit.postMessage(LoyaltyMessage(
        message: _messageController.text,
        priority: _priorityController.value.text,
        recipients: _recipients,
        category: _categoryController.value.text,
        subject: _subjectController.text));
  }

  void _handleRadioValueChange1(int value) {
    setState(() {
      _radioValue1 = value;

      switch (_radioValue1) {
        case 0:
          Fluttertoast.showToast(
              msg: 'Correct !', toastLength: Toast.LENGTH_SHORT);
          correctScore++;
          break;
        case 1:
          Fluttertoast.showToast(
              msg: 'Try again !', toastLength: Toast.LENGTH_SHORT);
          break;
        case 2:
          Fluttertoast.showToast(
              msg: 'Try again !', toastLength: Toast.LENGTH_SHORT);
          break;
      }
    });
  }

  @override
  void dispose() {
    _categoryBloc.dispose();
    _priorityBloc.dispose();
    _messageRecipientBloc.dispose();
    super.dispose();
  }
}
