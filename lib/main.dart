//import 'package:book_worm/Provider/auth.dart';
import 'package:book_worm/Provider/books.dart';
import 'package:book_worm/Screens/adding%20_book_screen.dart';
import 'package:book_worm/Screens/getting_books_screen.dart';
import 'package:book_worm/Screens/login_screen.dart';
import 'package:book_worm/Screens/login_screen_background.dart';
import 'package:book_worm/Screens/tabs_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

import 'Screens/auth_screen.dart';
import 'Screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();

    return FutureBuilder(
      future: _initialization,
      builder: (context, appSnapshot) {
        // Check for errors
        if (appSnapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('error'),
            ),
          );
        }
        return MultiProvider(
          providers: [
            ChangeNotifierProvider.value(
              value: Books(),
            ),
            // ChangeNotifierProvider.value(value: Auth())
          ],
          child: MaterialApp(
            routes: {
              AddingBookScreen.routeName: (_) => AddingBookScreen(),
            },
            title: 'BookWorm',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.deepPurple,
              secondaryHeaderColor: Colors.yellowAccent,
              accentColor: Colors.green,
            ),
            home: appSnapshot.connectionState != ConnectionState.done
                ? SplashScreen()
                : StreamBuilder(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (ctx, userSnapshot) {
                      if (userSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return SplashScreen();
                      }
                      if (userSnapshot.hasData) {
                        return TabsScreen();
                      }
                      return AuthScreen();
                    },
                  ),
          ),
        );
      },
    );
  }
}
