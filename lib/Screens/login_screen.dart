//import 'package:book_worm/Screens/tabs_screen.dart';
//import 'package:book_worm/animations/fade_animation.dart';
//
//import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
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
//  String _email;
//  String _password;
//  FormType _formType = FormType.login;
//  String id = '';
//  var errorMessage = '';
//
//  Future<void> _submit() async {
//    if (!formKey.currentState.validate()) {
////    then((value) => Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => TabsScreen())));
//      return;
//    }
//    formKey.currentState.save();
//    try {
//      if (_formType == FormType.login) {
//        id = await Provider.of<Auth>(context, listen: false)
//            .signIn(_email, _password);
//
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
//      errorMessage = 'Authenticate Failed';
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
//      await Navigator.of(context)
//          .push(MaterialPageRoute(builder: (ctx) => TabsScreen()));
//    }
//  }
////  void _submit() async {
////    formKey.currentState.save();
////    try {
////      if (_formType == FormType.login) {
////        id = await Provider.of<Auth>(context, listen: false)
////            .signIn(_email, _password);
////        print('$id logged in');
////      } else if (_formType == FormType.register) {
////        id = await Provider.of<Auth>(context, listen: false)
////            .createUser(_email, _password);
////        print('$id created account');
////      } else {
////        id = await Provider.of<Auth>(context, listen: false).currentUser();
////        print('$id current user');
////      }
////    } catch (error) {
////      print(error);
////    } finally {
////      Navigator.of(context)
////          .push(MaterialPageRoute(builder: (ctx) => TabsScreen()));
////    }
////  }
//
//  void moveToRegister() {
//    formKey.currentState.reset();
//    setState(() {
//      _formType = FormType.register;
//    });
//  }
//
//  void moveToLogin() {
//    formKey.currentState.reset();
//    setState(() {
//      _formType = FormType.login;
//    });
//  }
//
//  Widget _builderForm() {
//    return Container(
//      decoration: BoxDecoration(
//        color: Colors.white54,
//        borderRadius: BorderRadius.circular(10),
//        border: Border.all(
//          width: 1,
//          color: Colors.grey[300],
//        ),
//        boxShadow: [
//          BoxShadow(
//            color: Color.fromRGBO(143, 148, 251, .2),
//            blurRadius: 20.0,
//            offset: Offset(0, 10),
//          ),
//        ],
//      ),
//      child: Form(
//        key: formKey,
//        child: SingleChildScrollView(
//          child: Column(
//            children: [
//              Container(
//                padding: EdgeInsets.all(8.0),
//                decoration: BoxDecoration(
//                  border: Border(
//                    bottom: BorderSide(
//                      color: Colors.grey[300],
//                    ),
//                  ),
//                ),
//                child: TextFormField(
//                  autocorrect: false,
//                  validator: (val) =>
//                      val.isEmpty ? 'Email can\'t be empty.' : null,
//                  onSaved: (val) => _email = val,
//                  decoration: InputDecoration(
//                    border: InputBorder.none,
//                    hintText: "Email ",
//                    hintStyle: TextStyle(
//                      color: Colors.grey[600],
//                    ),
//                  ),
//                ),
//              ),
//              Container(
//                padding: EdgeInsets.all(8.0),
//                child: TextFormField(
//                  autocorrect: false,
//                  validator: (val) =>
//                      val.isEmpty ? 'Password can\'t be empty.' : null,
//                  onSaved: (val) => _password = val,
//                  decoration: InputDecoration(
//                    border: InputBorder.none,
//                    hintText: "Password ",
//                    hintStyle: TextStyle(
//                      color: Colors.grey[600],
//                    ),
//                  ),
//                ),
//              ),
//            ],
//          ),
//        ),
//      ),
//    );
//  }
//
//  Widget _builderButtons() {
//    return Container(
//      child: FadeAnimation(
//        2,
//        Container(
//          child: Center(
//            child: Column(
//              children: _formType == FormType.login
//                  ? [
//                      SizedBox(
//                        height: 20,
//                      ),
//                      Container(
//                        decoration: BoxDecoration(
//                          borderRadius: BorderRadius.circular(10),
//                          gradient: LinearGradient(
//                            colors: [
//                              Color.fromRGBO(143, 148, 251, 1),
//                              Color.fromRGBO(143, 148, 251, .6),
//                            ],
//                          ),
//                        ),
//                        child: FlatButton(
//                          child: Text('Login'),
//                          height: 40,
//                          minWidth: 200,
//                          onPressed: _submit,
//                        ),
//                      ),
//                      SizedBox(
//                        height: 20,
//                      ),
//                      FlatButton(
//                        height: 20.0,
//                        child: Text("Need an account? Register"),
//                        onPressed: moveToRegister,
//                      ),
//                      Text(errorMessage),
//                    ]
//                  : [
//                      SizedBox(
//                        height: 20,
//                      ),
//                      Container(
//                        decoration: BoxDecoration(
//                          borderRadius: BorderRadius.circular(10),
//                          gradient: LinearGradient(
//                            colors: [
//                              Color.fromRGBO(143, 148, 251, 1),
//                              Color.fromRGBO(143, 148, 251, .6),
//                            ],
//                          ),
//                        ),
//                        child: FlatButton(
//                          child: Text('Create an account'),
//                          minWidth: 200,
//                          height: 40,
//                          onPressed: _submit,
//                        ),
//                      ),
//                      SizedBox(
//                        height: 20,
//                      ),
//                      Container(
//                        color: Colors.white,
//                        child: FlatButton(
//                          height: 20.0,
//                          minWidth: 60,
//                          child: Text("Have an account? Login"),
//                          onPressed: moveToLogin,
//                        ),
//                      ),
//                      Text(errorMessage),
//                    ],
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    Size size = MediaQuery.of(context).size;
//    return Column(
//      children: [
//        _builderForm(),
//        _builderButtons(),
//      ],
//    );
//  }
//}
