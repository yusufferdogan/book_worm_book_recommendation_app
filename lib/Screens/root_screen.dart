import 'package:book_worm/Screens/login_screen.dart';
import 'package:book_worm/Screens/login_screen_background.dart';
import 'package:book_worm/Screens/tabs_screen.dart';
import 'package:flutter/material.dart';
import '../Screens/login_screen_background.dart';

class RootPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

enum AuthStatus {
  notSignedIn,
  signedIn,
}

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.notSignedIn;

//  initState() {
//    super.initState();
//    widget.auth.currentUser().then((userId) {
//      setState(() {
//        authStatus =
//            userId != null ? AuthStatus.signedIn : AuthStatus.notSignedIn;
//      });
//    });
//  }

  void _updateAuthStatus(AuthStatus status) {
    setState(() {
      authStatus = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.notSignedIn:
        return BackGround();
      case AuthStatus.signedIn:
        return TabsScreen();
      default:
        return Scaffold(
          body: Center(
            child: Text('ERROR'),
          ),
        );
    }
  }
}
