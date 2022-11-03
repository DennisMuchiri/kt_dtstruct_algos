import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loyaltyapp/authentication/authentication.dart';
import 'package:loyaltyapp/routes/routes.dart';
import 'package:loyaltyapp/user/user_dao.dart';
import 'package:loyaltyapp/utils/BaseRepository.dart';
import 'package:loyaltyapp/user/user_model.dart';

class AppDrawer extends StatefulWidget {

  @override
  _AppDrawerState createState() => new _AppDrawerState();
}
class _AppDrawerState extends State<AppDrawer> {
  final BaseRepository baseRepository =  new BaseRepository();
  final userDao = UserDao();

  var email = "";
  var username = "";
  @override

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
  getUser();
  }
  void getUser() {
    Future<Map> m = userDao.getUser(0);
    m.then((value) {
      setState(() {
        email = value['email'];
        username = value['username'] == null ? "Not found" : value['username'];
      });
    });
  }


  @override
  Widget build(BuildContext context)  {
    //final AuthenticationBloc _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    /**/
    return Drawer(
      child: Container(
        color: Colors.grey[100],
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            _createHeader(),
            _createDrawerItem(
                icon: Icons.dashboard,
                text: 'Dashboard',
                onTap: () =>
                    Navigator.pushReplacementNamed(context, Routes.dashboard)),
            _createDrawerItem(
                icon: Icons.event,
                text: 'Events',
                onTap: () =>
                    Navigator.pushReplacementNamed(context, Routes.event)),
            _createDrawerItem(
                icon: Icons.campaign,
                text: 'Campaigns',
                onTap: () =>
                    Navigator.pushReplacementNamed(context, Routes.campaigns)),
            _createDrawerItem(
                icon: Icons.redeem,
                text: 'My Redemption',
                onTap: () =>
                    Navigator.pushReplacementNamed(context, Routes.redemption)),
            _createDrawerItem(
                icon: Icons.message,
                text: 'Messages',
                onTap: () =>
                    Navigator.pushReplacementNamed(context, Routes.messages)),

            _createDrawerItem(
                icon: Icons.add_shopping_cart,
                text: 'Claims',
                onTap: () =>
                    Navigator.pushReplacementNamed(context, Routes.claims)),
            _createDrawerItem(
                icon: Icons.contacts,
                text: 'Contacts',
                onTap: () =>
                    Navigator.pushReplacementNamed(context, Routes.contact)),
            _createDrawerItem(
                icon: Icons.link,
                text: 'Links',
                onTap: () =>
                    Navigator.pushReplacementNamed(context, Routes.link)),
            _createDrawerItem(
                icon: Icons.notifications,
                text: 'Notices',
                onTap: () =>
                    Navigator.pushReplacementNamed(context, Routes.notice)),
            Divider(color: Colors.grey[100],),
            _createDrawerItem(
                icon: Icons.logout,
                text: 'Logout',
                onTap: () =>
                    context
                        //.bloc<AuthenticationBloc>()
                        .read<AuthenticationBloc>()
                        .add(AuthenticationLogoutRequested())
              //Navigator.pushReplacementNamed(context, Routes.messages)
              //_authenticationBloc.add(LoggedOut())
              //BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut()),
            ),

            Divider(),
            Padding(
                padding: EdgeInsets.fromLTRB(34.0, 20.0, 0.0, 0.0),
                child:Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.2,
                  alignment: FractionalOffset.bottomCenter,
                  child: ListTile(
                    title: Text('Version: 1.0.0'),
                    onTap: () {},

                  ),
                )



            )

          ],
        )
      ),
    );
  }

  Widget _createHeader() {

    return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      /*decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('res/images/drawer_header_background.png')
          )),*/
      child: Container(
        width: 333,
        height: 98,
        color: Colors.grey[200],
        child: Stack(
          children:[Positioned.fill(
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(90),
                  color: Colors.grey[300],
                ),
                child: new Image.asset("assets/pgbison_green_image.png"),// Image(image: AssetImage('logo.jpg')),//FlutterLogo(size: 80),
              ),
            ),
          ),
            Positioned(
              left: 95,
              top: 19,
              child: Text(
                username??"",
                style: TextStyle(
                  color: Color(0xff1f2430),
                  fontSize: 14,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Positioned(
              left: 95,
              top: 42,
              child: Text(
                email??"",
                style: TextStyle(
                  color: Color(0xffafafaf),
                  fontSize: 14,
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: 24,
                  height: 24,
                  child: Stack(
                    children:[

                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 44,
              top: 62,
              child: Container(
                width: 36,
                height: 36,
                child: Stack(
                  children:[Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 0.75, ),
                      color: Color(0xfff26e11),
                    ),
                  ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          width: 24,
                          height: 24,
                          child: Stack(
                            children:[

                            ],
                          ),
                        ),
                      ),
                    ),],
                ),
              ),
            ),],
        ),
      ),
    );
  }

  Widget _createDrawerItem(
      {IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
