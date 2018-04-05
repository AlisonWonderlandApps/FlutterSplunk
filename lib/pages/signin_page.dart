import 'package:flutter/material.dart';
import 'dart:core';

import './signup.dart';
import './landing_page.dart';

class SignInPage extends StatefulWidget {
  static String routeName = 'login-page';

  @override
  _SignInPageState createState() => new _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String username;
  String password;
  bool usernameError = false;
  bool passError = false;

  _onChangeEmail(e) {
    setState(() {
      username = e;
    });
    print(username);
  }

  _onChangePassword(p) {
    setState(() {
      password = p;
    });
    print(password);
  }

  _onLoginButtonPressed() {
    if(username.isEmpty || username == null) {
      print("OH NOOOO");
    }
    if(password.isEmpty || password == null) {

    }
    print(username);
    print(password);
    Navigator.of(context).pushNamed(LandingPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final logo = new Hero(
      tag: 'hero',
      child: new CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 56.0,
        child: new Image.asset(
          'assets/images/Accenture-logo.png'
        ),
      ),
    ); //Hero

    final email = new TextField(
      onChanged: (e) => _onChangeEmail(e),
      keyboardType: TextInputType.text,
      autofocus: false,
      decoration: new InputDecoration(
        hintText: 'Username',
        errorText: this.usernameError ? "Username error" : null,
        contentPadding: new EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(32.0),
        ),
      ),
    );

    final password = new TextField(
      autofocus: false,
      obscureText: true,
      decoration: new InputDecoration(
        hintText: 'Password',
        errorText: this.passError ? "Password error": null,
        contentPadding: new EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(32.0),
        ),
      ),
    );

    final loginButton = new Padding(
      padding: new EdgeInsets.symmetric(vertical: 16.0),
      child: new Material(
        borderRadius: new BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent[100],
        elevation: 5.0,
        child: new MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: () {
            //_onLoginButtonPressed;
            Navigator.of(context).pushNamed(LandingPage.routeName);
          },
          color: Colors.lightBlueAccent,
          child: new Text("Log In", style: new TextStyle(color: Colors.white)),
        ),
      ),
    );

    final forgotLabel = new FlatButton(
      child: new Text(
        'Forgot Password?',
        style: new TextStyle(color: Colors.black54)
      ),
      onPressed: () {},
    );

    final newUser = new FlatButton(
      child: new Text(
          'New User? Click here',
          style: new TextStyle(color: Colors.black54)
      ),
      onPressed: () {
        Navigator.of(context).pushNamed(SignUpPage.routeName);
      },
    );

    return new Scaffold(
      backgroundColor: Colors.white,
      body: new Center(
        child: new ListView(
          shrinkWrap: true,
          padding: new EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            new Padding(padding: new EdgeInsets.only(top: 60.0),),
            logo,
            new SizedBox(height: 56.0),
            email,
            new SizedBox(height: 8.0),
            password,
            new SizedBox(height: 16.0),
            loginButton,
            forgotLabel,
            newUser,
            new Padding(padding: new EdgeInsets.only(bottom: 80.0),),
          ],
        ),
      ),
    );

  }
}

