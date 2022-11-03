
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loyaltyapp/login/login_repository.dart';
import 'package:loyaltyapp/login/models/forgotpassword.dart';
import 'package:loyaltyapp/login/view/login_page.dart';
import 'package:loyaltyapp/login/view/view.dart';

class ForgotPasswordPage extends StatelessWidget {
  static String id = 'forgot-password';
  final loginRepository = LoginRepository();
  final _emailController = TextEditingController();
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Form(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Email Your Email',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
              TextFormField(

                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Email',
                  icon: Icon(
                    Icons.mail,
                    color: Colors.white,
                  ),
                  errorStyle: TextStyle(color: Colors.white),
                  labelStyle: TextStyle(color: Colors.white),
                  hintStyle: TextStyle(color: Colors.white),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                validator: (txtVal) {
                  if (txtVal == null || txtVal.isEmpty) {
                    return 'Please Enter Email.';
                  }
                  return null;
                },
                controller: _emailController,
              ),
              SizedBox(height: 20),
              RaisedButton(
                child: Text('Submit'),
                onPressed: () {
                  _submitForgotPassword(context);
                },
              ),
             /* FlatButton(
                child: Text('Sign In'),
                onPressed: () {

                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (_) => LoginFormS()),
                          (Route<dynamic> route) => route is LoginFormS
                  );
                },
              )*/
            ],
          ),
        ),
      ),
    );
  }
  _submitForgotPassword(BuildContext context) async {

    loginRepository.sbtForgotPassword(ForgotPassword(
        email: _emailController.text)).then((value)  {
          print(value.text);
          final snackBar = SnackBar(content:  Text("${value.text}"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);

      //Navigator.push(context,    MaterialPageRoute(builder: (context) => LoginFormS()));
    
    }).catchError((onError) {
      Fluttertoast.showToast(
          msg: onError.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
    await Future.delayed(const Duration(seconds: 5), (){});
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }
}