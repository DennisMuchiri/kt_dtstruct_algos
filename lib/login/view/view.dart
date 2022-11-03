import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loyaltyapp/registration/view/register_screen.dart';
import 'package:loyaltyapp/login/view/forgotpassword_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loyaltyapp/utils/ui/pgbison_app_theme.dart';
import 'package:loyaltyapp/utils/widgets/common_widgets.dart';

import '../login.dart';

class LoginFormS extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginFormS());
  }

  @override
  LoginForm createState() => LoginForm();
}

class LoginForm extends State<LoginFormS> {
  String _password;
  final _passwordFieldKey = GlobalKey<FormFieldState<String>>();
  @override
  Widget build(BuildContext context) {
    return /*Container(
      decoration: BoxDecoration(
          color: HexColor("#1f2430"),
          image: DecorationImage(
              image: AssetImage("assets/images/login.png"), fit: BoxFit.cover)),
      height: MediaQuery.of(context).size.height,
      child: */
        Container(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: HexColor("#1f2430"),
                image: DecorationImage(
                    image: AssetImage("assets/images/login.png"),
                    fit: BoxFit.cover)),
            height: MediaQuery.of(context).size.height,
          ),
          Container(
            decoration: BoxDecoration(
              color: PGBisonAppTheme.pg_Black1,
            ),
            height: MediaQuery.of(context).size.height,
          ),
          BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state.status.isSubmissionFailure) {
                  Scaffold.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      const SnackBar(
                          content: Text('Invalid login credentials.')),
                    );
                }
              },
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: AppBar().preferredSize.height +
                          MediaQuery.of(context).padding.top +
                          24,
                    ),
                    logo(context),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        welcomeText(context),
                        SizedBox(
                          height: 10,
                        ),
                        _UsernameInput(),
                        SizedBox(
                          height: 15,
                        ),
                        PasswordField(
                          fieldKey: _passwordFieldKey,
                          helperText: "No less than 8 characters",
                          labelText: "Password *",
                          onFieldSubmitted: (String value) {
                            setState(() {
                              this._password = value;
                            });
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    _LoginButton(),
                    const Padding(padding: EdgeInsets.all(12)),
                    _createForgotLink(context),
                    SizedBox(
                      height: 5,
                    ),
                    _createAccountLabel(context)
                  ],
                ),
              )),
        ],
      ), //),
    );
  }

  Widget logo(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 25.0, right: 25.0),
      child: Image.asset(
        "assets/logo.png",
        fit: BoxFit.contain,
        color: Colors.white,
      ),
    );
  }

  Widget welcomeText(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 45.0, right: 45.0),
      child: Text(
        "Welcome!",
        style: TextStyle(
          color: HexColor("#FFFFFF"),
          fontSize: 30,
          fontWeight: FontWeight.w400,
          fontFamily: PGBisonAppTheme.font_Pacifico,
        ),
      ),
    );
  }

  Widget _createForgotLink(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ForgotPasswordPage()));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Forgot password?',
            style: TextStyle(
              color: PGBisonAppTheme.pg_White,
              fontSize: 15,
              letterSpacing: -0.2,
              fontWeight: FontWeight.w600,
              fontFamily: PGBisonAppTheme.font_Poppins_SemiBold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _createAccountLabel(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => RegisterScreen()));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Don\'t have an account ?',
            /*style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),*/
            style: TextStyle(
              color: PGBisonAppTheme.pg_White,
              fontSize: 15,
              letterSpacing: -0.2,
              fontWeight: FontWeight.w600,
              fontFamily: PGBisonAppTheme.font_Poppins_SemiBold,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            'Register',
            style: TextStyle(
              color: PGBisonAppTheme.pg_Green,
              fontSize: 15,
              letterSpacing: -0.2,
              fontWeight: FontWeight.w600,
              fontFamily: PGBisonAppTheme.font_Poppins_SemiBold,
            ),
            /*TextStyle(
                color: PGBisonAppTheme.pg_Green,
                fontSize: 15,
                fontWeight: FontWeight.w600),*/
          ),
        ],
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(left: 45.0, right: 45.0),
          child: TextField(
            style: TextStyle(
              color: PGBisonAppTheme.pg_White,
              fontSize: 14,
              letterSpacing: -0.2,
              fontFamily: PGBisonAppTheme.font_Poppins_Light,
            ),
            key: const Key('loginForm_usernameInput_textField'),
            onChanged: (username) => context
                .read<LoginBloc>()
                //.bloc<LoginBloc>()
                .add(LoginUsernameChanged(username)),
            decoration: InputDecoration(
              labelText: 'Email Address',
              labelStyle: TextStyle(
                color: PGBisonAppTheme.pg_White,
                fontSize: 14,
                //fontWeight: FontWeight.w600,
                letterSpacing: -0.2,
                fontFamily: PGBisonAppTheme.font_Poppins_SemiBold,
              ),

              errorText: state.username.invalid ? 'invalid email' : null,
              errorStyle: TextStyle(
                color: PGBisonAppTheme.pg_Red,
                fontSize: 12.0,
                fontFamily: PGBisonAppTheme.font_Poppins_Medium,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: PGBisonAppTheme.pg_White,
                  width: 1.0,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: PGBisonAppTheme.pg_Green,
                  //HexColor("#5b6068"), //Theme.of(context).accentColor,
                  width: 1.0,
                ),
              ),
              errorBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: PGBisonAppTheme.pg_Red,
                  width: 1.0,
                ),
              ),

              fillColor: PGBisonAppTheme.pg_White_Black3, //Color(0x26ffffff),
              filled: true,
              isDense: true,
            ),
            keyboardType: TextInputType.emailAddress,
            cursorColor: PGBisonAppTheme.pg_White,
          ),
        );
      },
    );
  }
}

class PasswordField extends StatefulWidget {
  PasswordField({
    this.fieldKey,
    this.hintText,
    this.labelText,
    this.helperText,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
  });
  final Key fieldKey;
  final String hintText;
  final String labelText;
  final String helperText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;

  @override
  _PasswordFieldState createState() => new _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return new Container(
            padding: EdgeInsets.only(left: 45.0, right: 45.0),
            child: TextFormField(
              key: widget.fieldKey,
              obscureText: _obscureText,
              maxLength: 20,
              onSaved: widget.onSaved,
              validator: widget.validator,
              onFieldSubmitted: widget.onFieldSubmitted,
              style: TextStyle(
                color: PGBisonAppTheme.pg_White,
                fontSize: 14,
                letterSpacing: -0.2,
                fontFamily: PGBisonAppTheme.font_Poppins_Light,
              ),
              onChanged: (password) => context
                  //.bloc<LoginBloc>()
                  .read<LoginBloc>()
                  .add(LoginPasswordChanged(password)),
              decoration: new InputDecoration(
                border: const UnderlineInputBorder(),
                filled: true,
                hintText: widget.hintText,
                labelText: widget.labelText,
                labelStyle: TextStyle(
                  color: PGBisonAppTheme.pg_White,
                  fontSize: 14,
                  letterSpacing: -0.2,
                  fontFamily: PGBisonAppTheme.font_Poppins_SemiBold,
                ),
                errorText: state.password.invalid ? 'invalid password' : null,
                errorStyle: TextStyle(
                  color: PGBisonAppTheme.pg_Red,
                  fontSize: 12.0,
                  fontFamily: PGBisonAppTheme.font_Poppins_Medium,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: PGBisonAppTheme.pg_White,
                    width: 1.0,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: PGBisonAppTheme.pg_Green,
                    //HexColor("#5b6068"), //Theme.of(context).accentColor,
                    width: 1.0,
                  ),
                ),
                errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: PGBisonAppTheme.pg_Red,
                    width: 1.0,
                  ),
                ),
                fillColor: Color(0x26ffffff),
                helperText: widget.helperText,
                helperStyle: TextStyle(
                  color: ((state.password.invalid
                      ? PGBisonAppTheme.pg_Red
                      : PGBisonAppTheme.pg_White)),
                  fontSize: 12.0,
                  fontFamily: PGBisonAppTheme.font_Poppins_Light,
                ),
                suffixIcon: new GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: new Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: PGBisonAppTheme.pg_White,
                  ),
                ),
                isDense: true,
              ),
            ));
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.only(left: 45.0, right: 45.0),
          child: TextField(
            style: TextStyle(
                color: HexColor("#FFFFFF") /*Theme.of(context).accentColor*/),
            key: const Key('loginForm_passwordInput_textField'),
            onChanged: (password) => context
                //.bloc<LoginBloc>()
                .read<LoginBloc>()
                .add(LoginPasswordChanged(password)),
            obscureText: true,
            decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: GoogleFonts.poppins(
                  textStyle: TextStyle(color: Colors.white),
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                ),
                errorText: state.password.invalid ? 'invalid password' : null,
                enabledBorder: UnderlineInputBorder(
                  //borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    color: HexColor("#5b6068"), //Theme.of(context).accentColor,
                    width: 1.0,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  //borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    color: HexColor("#5b6068"), //Theme.of(context).accentColor,
                    width: 1.0,
                  ),
                ),
                fillColor: Color(0x26ffffff),
                filled: true),
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (bl_context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : Container(
                //width: MediaQuery.of(context).size.width * 0.79,
                height: MediaQuery.of(context).size.height * 0.12,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 30.0,
                    left: 55,
                    right: 55,
                  ),
                  child: RaisedButton(
                    key: const Key('loginForm_continue_raisedButton'),
                    child: Center(
                      child: RichText(
                        text: TextSpan(children: [
                          WidgetSpan(
                              child: Icon(
                            Icons.login,
                            color: Colors.white,
                            size: 19,
                          )),
                          TextSpan(
                              style: /*GoogleFonts.poppins(
                                  textStyle: TextStyle(color: Colors.white),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),*/
                                  TextStyle(
                                color: PGBisonAppTheme.pg_White,
                                fontSize: 16.0,
                                fontFamily:
                                    PGBisonAppTheme.font_Poppins_SemiBold,
                                fontWeight: FontWeight.w600,
                              ),
                              text: " Log In")
                        ]),
                      ),
                    ),
                    highlightElevation: 0.0,
                    elevation: 0.0,
                    color: PGBisonAppTheme.pg_Green, // Colors.green,

                    onPressed: state.status.isValidated
                        ? () {
                            bl_context
                                .read<LoginBloc>()
                                //.bloc<LoginBloc>()
                                .add(const LoginSubmitted());
                          }
                        : () {},
                  ),
                ));
      },
    );
  }
}
