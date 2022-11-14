import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../constants.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


class LoginScreen extends StatefulWidget {
  static const id = 'login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner= false;

  late String email;
  late String password;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          decoration: kBackColorDecoration,
          child: ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Center(
                    child: Hero(
                      tag: 'logo',
                      child: Container(
                        height: 100.0,
                        child: Image.asset('images/amls-logo.png'),
                        transform: Matrix4.rotationZ(-0.1),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 48.0,
                  ),
                  TextField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: Colors.black45),
                      onChanged: (value) {
                        email = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter your student code')),
                  const SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black45),
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      onChanged: (value) {
                        password = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter your password')),
                  const SizedBox(
                    height: 24.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Material(
                      color: Colors.lightBlueAccent,
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      elevation: 5.0,
                      child: MaterialButton(
                        onPressed: () async {
                          setState((){
                          showSpinner=true;});
                          try {
                            final user =
                            await _auth.signInWithEmailAndPassword(
                                email: email, password: password);
                            if (user != null) {
                              Navigator.pushNamed(context, ChatScreen.id);
                            }
                            setState(() {
                              showSpinner=false;
                            });
                          } catch (e) {
                            print(e);
                          }
                        },
                        minWidth: 200.0,
                        height: 42.0,
                        child: const Text(
                          'Log In',
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
