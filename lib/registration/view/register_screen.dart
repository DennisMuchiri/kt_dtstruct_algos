import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loyaltyapp/dropdowns/county_bloc.dart';
import 'package:loyaltyapp/dropdowns/dropdown_item_model.dart';
import 'package:loyaltyapp/login/view/login_page.dart';
import 'package:loyaltyapp/networking/api_base_helper.dart';
import 'package:loyaltyapp/networking/api_reponse.dart';
import 'package:loyaltyapp/registration/bloc/registration_bloc.dart';
import 'package:loyaltyapp/registration/registration_model.dart';
import 'package:loyaltyapp/registration/registration_repository.dart';
import 'package:loyaltyapp/registration/bloc/registrationcubit.dart';
import 'package:loyaltyapp/registration/bloc/registration_state.dart';
import 'package:loyaltyapp/widgets/hyperlink.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = '/register';
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<RegisterScreen> {
  //final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition;
  bool _readTOC = false;

  CountyBloc _countyBloc;
  RegistrationBloc _registrationBloc;

  final _longitudeController = TextEditingController();
  final _latitudeController = TextEditingController();
  final _what3wordsController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _idNumberController = TextEditingController();
  final _kraPinController = TextEditingController();
  final _countyController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  final _referralCodeController = TextEditingController();
  final _phoneCodeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _kraImagePicker = new ImagePicker();
  final ImagePicker _idImagePicker = ImagePicker();
  final TextEditingController controller = TextEditingController();
  final TextEditingController maxWidthController = TextEditingController();
  final TextEditingController maxHeightController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();

  String initialCountry = 'KE';
  PhoneNumber number = PhoneNumber(isoCode: 'KE');

  bool enableButton;
  XFile _kraPinImg;
  XFile _idNoImg;

  @override
  void initState() {
    _countyBloc = CountyBloc();
    _registrationBloc = RegistrationBloc();
    _readTOC = false;
    _phoneCodeController.text = "+254";
    enableButton = false;
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Registration'),
        ),
        //drawer: AppDrawer(),
        body: BlocProvider(
          create: (context) => RegistrationCubit(RegistrationRepository()),
          child: Container(
            margin: EdgeInsets.only(left: 11.0, right: 11.0),
            child: BlocConsumer<RegistrationCubit, RegistrationState>(
                listener: (context, state) {
              if (state is RegistrationSubmitted) {
                print(state.registrationResponse);

                RegisterResponse response = state.registrationResponse;

                if (response != null) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(response.text ?? ""),
                  ));
                  /*Future.delayed(const Duration(seconds: 5), (){});
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );*/
                } else {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("Unable to complete registration."),
                  ));
                }

                //}
                if (state is ClaimSearchSubmitting) {
                  enableButton = false;
                }
              }
              if (state is RegistrationError) {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(state.message),
                ));
              }
            }, builder: (context, state) {
              return SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(3.0),
                              child: TextFormField(
                                decoration: InputDecoration(labelText: 'Email'),
                                keyboardType: TextInputType.emailAddress,
                                controller: _emailController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Email is a required field.";
                                  }
                                  return null;
                                },
                                onChanged: (value) {},
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(3.0),
                              child: TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'Password'),
                                keyboardType: TextInputType.visiblePassword,
                                controller: _passwordController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Password is a required field.";
                                  } else if (value.length < 8) {
                                    return "Password length must be 8 or more characters.";
                                  }
                                  return null;
                                },
                                obscureText: true,
                                onChanged: (value) {},
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(3.0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Confirm Password'),
                                keyboardType: TextInputType.visiblePassword,
                                controller: _confirmPasswordController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Confirm Password is a required field.";
                                  } else if (value.length < 8) {
                                    return "Password length must be 8 or more characters.";
                                  } else if (value !=
                                      _passwordController.text) {
                                    return "Passwords do not match.";
                                  }
                                  return null;
                                },
                                obscureText: true,
                                onChanged: (value) {},
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(3.0),
                              child: TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'First Name'),
                                keyboardType: TextInputType.text,
                                controller: _firstnameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "First Name is a required field.";
                                  }
                                  return null;
                                },
                                onChanged: (value) {},
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(3.0),
                              child: TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'Last Name'),
                                keyboardType: TextInputType.text,
                                controller: _lastnameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Last Name is a required field.";
                                  }
                                  return null;
                                },
                                onChanged: (value) {},
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(3.0),
                              child: TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'Id Number'),
                                keyboardType: TextInputType.number,
                                controller: _idNumberController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Id Number is a required field.";
                                  }
                                  return null;
                                },
                                onChanged: (value) {},
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0, bottom:10),
                            child: Text('Upload ID. '),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: FloatingActionButton(
                              onPressed: () {
                                _onIdImageButtonPressed(
                                  ImageSource.gallery,
                                  context: context,
                                  isMultiImage: false,
                                );
                              },
                              heroTag: 'idImage',
                              tooltip: 'Upload ID. ',
                              child: const Icon(Icons.photo_library),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(3.0),
                              child: TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'KRA PIN'),
                                keyboardType: TextInputType.number,
                                controller: _kraPinController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "KRA PIN is a required field.";
                                  }
                                  return null;
                                },
                                onChanged: (value) {},
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0, bottom:10),
                            child: Text('Pick KRA Image. '),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: FloatingActionButton(
                              onPressed: () {
                                _onKRAImageButtonPressed(
                                  ImageSource.gallery,
                                  context: context,
                                  isMultiImage: false,
                                );
                              },
                              heroTag: 'kraImage',
                              tooltip: 'Pick KRA Image. ',
                              child: const Icon(Icons.photo_library),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(3.0),
                              child: TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'Referral Code'),
                                keyboardType: TextInputType.text,
                                controller: _referralCodeController,
                                onChanged: (value) {},
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(3.0),
                              child: StreamBuilder<ApiResponse<List<County>>>(
                                stream: _countyBloc.countyListStream,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    // print(snapshot.data.status);
                                    switch (snapshot.data.status) {
                                      case Status.COMPLETED:
                                        return DropdownButtonFormField(
                                          decoration: InputDecoration(
                                            labelText: "County",
                                          ),
                                          items: snapshot.data.data.map((e) {
                                            return DropdownMenuItem(
                                              child: Text(e.county ?? ""),
                                              value: e.id,
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            _countyController.text = value;
                                          },
                                          validator: (value) {
                                            if (value == null) {
                                              return "County is a required field.";
                                            }
                                            return null;
                                          },
                                        );
                                        break;
                                    }
                                  }
                                  return Container();
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                              child: Container(
                            child: InternationalPhoneNumberInput(
                              onInputChanged: (PhoneNumber number) {
                                print(number.phoneNumber);
                              },
                              onInputValidated: (bool value) {
                                print(value);
                              },
                              selectorConfig: SelectorConfig(
                                selectorType:
                                    PhoneInputSelectorType.BOTTOM_SHEET,
                              ),
                              ignoreBlank: false,
                              hintText: 'e.g. 722000000',
                              autoValidateMode: AutovalidateMode.disabled,
                              selectorTextStyle: TextStyle(color: Colors.black),
                              initialValue: number,
                              textFieldController: _mobileNumberController,
                              formatInput: false,
                              keyboardType: TextInputType.numberWithOptions(
                                  signed: true, decimal: true),
                              inputBorder: OutlineInputBorder(),
                              onSaved: (PhoneNumber number) {
                                print('On Saved: $number');
                              },
                            ),
                          )),
                        ],
                      ),

                      /* Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(3.0),
                              child: TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'Latitude'),
                                onChanged: (value) {},
                                controller: _latitudeController,
                                readOnly: true,
                              ),
                            ),
                          )
                        ],
                      ),*/
                      /*Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(3.0),
                              child: TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'Longitude'),
                                controller: _longitudeController,
                                onChanged: (value) {},
                                readOnly: true,
                              ),
                            ),
                          )
                        ],
                      ),*/
                      /* Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(3.0),
                              child: TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'What 3 Words'),
                                onChanged: (value) {},
                                readOnly: true,
                                controller: _what3wordsController,
                              ),
                            ),
                          )
                        ],
                      ),*/
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(3.0),
                              child: InkWell(
                                child: Hyperlink(
                                    "http://loyaltyapp.pgbison.co.ke/about/terms",
                                    "Terms and Conditions"),
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(3.0),
                              child: InkWell(
                                child: Hyperlink(
                                    "http://loyaltyapp.pgbison.co.ke/about/terms",
                                    "Loyalty Scheme"),
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(top: 2.0),
                              //.all(1.0),
                              child: CheckboxListTile(
                                title: Text(
                                    'I confirm that I have read the terms and conditions and loyalty scheme.'),
                                value: _readTOC,
                                onChanged: _readTOCChanged,
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 5, 15, 5),
                            child: ElevatedButton(
                              onPressed: _readTOC
                                  ? () {
                                      if (_formKey.currentState.validate()) {
                                        _register(context);
                                      } else {
                                        print("Form not valid");
                                      }
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
            }),
          ),
        ));
  }

  void _readTOCChanged(bool newVal) => setState(() {
        _readTOC = newVal;

        if (_readTOC) {
          print(_phoneCodeController.text);
        } else {
          //print('unchecked');
        }
      });

  _imgFromGallery() async {
    /*File image = await  ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    );

    setState(() {
      _image = image;
    });*/
  }

  _register(BuildContext context) {
    context
        //.bloc<RegistrationCubit>()
        .read<RegistrationCubit>()
        .register(RegistrationModel(
            email: _emailController.text,
            password: _passwordController.text,
            confirmPassword: _confirmPasswordController.text,
            county: _countyController.text,
            firstname: _firstnameController.text,
            lastname: _lastnameController.text,
            idNumber: _idNumberController.text,
            kraPin: _kraPinController.text,
            /*lat: _latitudeController.text,
        long:
        _longitudeController.text,*/
            mobileNumber: _mobileNumberController.text,
            phoneCode: _phoneCodeController.text,
            /* what3words:
        _what3wordsController
            .text,*/
            referralCode: _referralCodeController.text));
  }

  _getCurrentLocation() async {
    /*_currentPosition = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best)
        .catchError((e) {
      print("ERR" + e.toString());
    });*/

    /* _longitudeController.text = _currentPosition.longitude.toString();
    _latitudeController.text = _currentPosition.latitude.toString();*/
    /*_registrationBloc.fetchWhat3Words(What3Words(
        long: _longitudeController.text, lat: _latitudeController.text));

    _registrationBloc.what3wordsStream.listen((event) {
      switch (event.status) {
        case Status.COMPLETED:
          print(event.data.what3words);
          _what3wordsController.value =
              TextEditingValue(text: event.data.what3words);
          break;
      }
    });*/
  }

  void _onKRAImageButtonPressed(ImageSource source,
      {BuildContext context, bool isMultiImage = false}) async {
    try {
      final pickedFile = await _kraImagePicker.pickImage(
        source: source,
        maxWidth: 10, // maxWidth,
        maxHeight: 10, //maxHeight,
        imageQuality: 10, //quality,
      );
      setState(() {
        _kraPinImg = pickedFile;
      });
    } catch (e) {
      setState(() {
        //_pickImageError = e;
      });
    }
    /*await _displayPickImageDialog(context,
        (double maxWidth, double maxHeight, int quality) async {
      try {
        final pickedFile = await _kraImagePicker.pickImage(
          source: source,
          maxWidth: maxWidth,
          maxHeight: maxHeight,
          imageQuality: quality,
        );
        setState(() {
          _kraPinImg = pickedFile;
        });
      } catch (e) {
        setState(() {
          //_pickImageError = e;
        });
      }
    });*/
  }

  void _onIdImageButtonPressed(ImageSource source,
      {BuildContext context, bool isMultiImage = false}) async {
    try {
      final pickedFile = await _idImagePicker.pickImage(
        source: source,
        maxWidth: 10, // maxWidth,
        maxHeight: 10, //maxHeight,
        imageQuality: 10, //quality,
      );
      setState(() {
        _idNoImg = pickedFile;
      });
    } catch (e) {
      setState(() {
        //_pickImageError = e;
      });
    }
  }

  @override
  void dispose() {
    _countyBloc.dispose();
    _registrationBloc.dispose();
    super.dispose();
  }
}
