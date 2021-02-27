//import 'package:book_worm/Provider/auth.dart';
//import 'package:book_worm/Screens/login_screen_background.dart';
//import 'package:book_worm/Screens/tabs_screen.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import '../animations/fade_animation.dart';
//import '../Models/http_exception.dart';
//
//enum FormType { login, register }
//
//class LoginScreen extends StatefulWidget {
//  @override
//  _LoginScreenState createState() => _LoginScreenState();
//}
//
//class _LoginScreenState extends State<LoginScreen> {
//  final GlobalKey<FormState> formKey = GlobalKey();
//
//  String _email = '';
//
//  String _password = '';
//
//  FormType _formType = FormType.register;
//
//  String id = '';
//
//  Future<void> _submit() async {
//    if (!formKey.currentState.validate()) {
//      return;
//    }
//    formKey.currentState.save();
//    try {
//      if (_formType == FormType.login) {
//        id = await Provider.of<Auth>(context, listen: false)
//            .signIn(_email, _password);
//        print('$id logged in');
//      } else if (_formType == FormType.register) {
//        id = await Provider.of<Auth>(context, listen: false)
//            .createUser(_email, _password);
//        print('$id created account');
//      } else {
//        id = await Provider.of<Auth>(context, listen: false).currentUser();
//        print('$id current user');
//      }
//    } on HttpException catch (error) {
//      var errorMessage = 'Authenticate Failed';
//      if (error.toString().contains('EMAIL_EXIST')) {
//        errorMessage = 'Email is in use';
//      }
//      if (error.toString().contains('INVALID_EMAIL')) {
//        errorMessage = 'Email is not valid';
//      }
//      if (error.toString().contains('WEAK_PASSWORD')) {
//        errorMessage = 'Password is weak';
//      }
//      if (error.toString().contains('EMAIL_NOT_FOUND')) {
//        errorMessage = 'Email is Not found';
//      }
//      if (error.toString().contains('INVALID_PASSWORD')) {
//        errorMessage = 'PASSWORD İS INVALID';
//      }
//    } catch (error) {
//      print(error);
//    } finally {
//      Navigator.of(context)
//          .push(MaterialPageRoute(builder: (ctx) => TabsScreen()));
//    }
//  }
//
//  void submit() {
//    formKey.currentState.save();
//    print(_email);
//    print(_password);
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      color: Colors.white12,
//      child: Form(
//        key: formKey,
//        child: Column(
//          children: [
//            Container(
//              padding: EdgeInsets.all(30),
//              decoration: BoxDecoration(
//                border: Border.all(color: Colors.black54, width: 5),
//              ),
//              child: TextFormField(
//                onSaved: (val) => _email = val,
//                keyboardType: TextInputType.emailAddress,
//                validator: (value) {
//                  if (value.isEmpty || !value.contains('@')) {
//                    return 'Invalid email!';
//                  }
//                  return null;
//                },
//                decoration: InputDecoration(
//                  border: InputBorder.none,
//                  hintText: "Email ",
//                  hintStyle: TextStyle(
//                    color: Colors.black,
//                  ),
//                ),
//              ),
//            ),
//            Container(
//              padding: EdgeInsets.all(30),
//              decoration: BoxDecoration(
//                border: Border.all(color: Colors.black54, width: 5),
//              ),
//              child: TextFormField(
//                onSaved: (val) => _password = val,
//                validator: (value) {
//                  if (value.isEmpty || value.length < 5) {
//                    return 'Password is too short!';
//                  } else {
//                    return null;
//                  }
//                },
//                decoration: InputDecoration(
//                  border: InputBorder.none,
//                  hintText: "password ",
//                  hintStyle: TextStyle(
//                    color: Colors.black,
//                  ),
//                ),
//              ),
//            ),
//            FlatButton(
//              onPressed: _submit,
//              child: Text('login'),
//            )
//          ],
//        ),
//      ),
//    );
//  }
//}
