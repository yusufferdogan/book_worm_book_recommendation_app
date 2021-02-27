//import 'package:book_worm/Provider/auth.dart';
//import 'package:book_worm/Screens/login_screen_background.dart';
//import 'package:book_worm/Screens/tabs_screen.dart';
//import 'package:book_worm/animations/fade_animation.dart';
//
//import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
//import '../Widgets/primarybutton.dart';
//
//enum FormType { login, register }
//
//class BackGround extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    Size size = MediaQuery.of(context).size;
//    return Scaffold(
//      body: SingleChildScrollView(
//        child: Container(
//          child: Column(
//            children: <Widget>[
//              Container(
//                height: 400,
//                decoration: BoxDecoration(
//                  image: DecorationImage(
//                    image: AssetImage('assets/images/background.png'),
//                    fit: BoxFit.fill,
//                  ),
//                ),
//                child: Stack(
//                  children: <Widget>[
//                    Positioned(
//                      top: 200,
//                      left: 30,
//                      width: 120,
//                      height: 200,
//                      child: FadeAnimation(
//                        1,
//                        Container(
//                          decoration: BoxDecoration(
//                            image: DecorationImage(
//                              image: AssetImage('assets/images/book.png'),
//                            ),
//                          ),
//                        ),
//                      ),
//                    ),
//                    Positioned(
//                      top: 110,
//                      left: 20,
//                      width: 350,
//                      height: 150,
//                      child: FadeAnimation(
//                        1.6,
//                        Container(
//                          child: Center(
//                            child: Text(
//                              "Welcome to BookWorm",
//                              style: TextStyle(
//                                color: Colors.white,
//                                fontSize: 30,
//                                fontWeight: FontWeight.bold,
//                              ),
//                            ),
//                          ),
//                        ),
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//              SizedBox(
//                height: 5,
//              ),
//              Container(
//                padding: EdgeInsets.all(30.0),
//                height: 400,
//                child: Column(
//                  children: <Widget>[
//                    FadeAnimation(
//                      1.8,
//                      Container(
//                        padding: EdgeInsets.all(5),
//                        decoration: BoxDecoration(
//                            color: Colors.white,
//                            borderRadius: BorderRadius.circular(10),
//                            border: Border.all(
//                              width: 2,
//                              color: Colors.grey[100],
//                            ),
//                            boxShadow: [
//                              BoxShadow(
//                                color: Color.fromRGBO(143, 148, 251, .2),
//                                blurRadius: 20.0,
//                                offset: Offset(0, 10),
//                              ),
//                            ]),
//                        child: LoginScreen(),
//                      ),
//                    ),
//                  ],
//                ),
//              )
//            ],
//          ),
//        ),
//      ),
//    );
//  }
//}
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
//
////  void validateAndSubmit() async {
////    if (formKey.currentState.validate()) {
////      print('girdi');
////      formKey.currentState.save();
////      try {
////        String userId = _formType == FormType.login
////            ? await widget.auth.signIn(_email, _password)
////            : await widget.auth.createUser(_email, _password);
////        setState(() {
////          _authHint = 'Signed In\n\nUser id: $userId';
////        });
////        widget.onSignIn();
////      } catch (e) {
////        setState(() {
////          _authHint = 'Sign In Error\n\n${e.toString()}';
////          print(_authHint);
////        });
////        print(e);
////      }
////    } else {
////      setState(() {
////        _authHint = '';
////      });
////    }
////  }
//  void _submit() async {
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
//    } catch (error) {
//      print(error);
//    } finally {
//      Navigator.of(context)
//          .push(MaterialPageRoute(builder: (ctx) => TabsScreen()));
//    }
//  }
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
//  Widget textFields() {
//    return Center(
//      child: Container(
//        color: Colors.black54,
//        child: Column(
//          children: [
//            TextField(
//              onChanged: (val) => _email = val,
//              decoration: InputDecoration(
//                border: InputBorder.none,
//                hintText: "Email ",
//                hintStyle: TextStyle(
//                  color: Colors.white,
//                ),
//              ),
//            ),
//            TextField(
//              onChanged: (val) => _email = val,
//              decoration: InputDecoration(
//                border: InputBorder.none,
//                hintText: "password ",
//                hintStyle: TextStyle(
//                  color: Colors.white,
//                ),
//              ),
//            ),
//          ],
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
//          height: 150,
//          child: Center(
//            child: Column(
//              children: _formType == FormType.login
//                  ? [
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
//                        child: PrimaryButton(
//                          key: Key('login'),
//                          text: 'Login',
//                          height: 40.0,
//                          onPressed: _submit,
//                        ),
//                      ),
//                      SizedBox(
//                        height: 20,
//                      ),
//                      FlatButton(
//                        height: 20.0,
//                        key: Key('need-account'),
//                        child: Text("Need an account? Register"),
//                        onPressed: moveToRegister,
//                      ),
//                    ]
//                  : [
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
//                        child: PrimaryButton(
//                          key: Key('register'),
//                          text: 'Create an account',
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
//                          key: Key('need-login'),
//                          child: Text("Have an account? Login"),
//                          onPressed: moveToLogin,
//                        ),
//                      ),
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
