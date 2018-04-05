import 'package:flutter/material.dart';
import 'dart:core';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:auth_app/globals.dart' as globals;

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
  bool isFetching = false;
  bool error = false;
  String errorMsg = 'Error! Please check username and password';
  TextEditingController _controller = new TextEditingController();

  _onChangeUsername(e) {
    setState(() {
      usernameError = false;
      username = e;
    });
    print(username);
  }

  _onChangePassword(p) {
    setState(() {
      passError=false;
      password = p;
    });
    print(password);
  }

  _onLoginButtonPressed() {

    if(username == null) {
      setState(() {
        usernameError = true;
      });
      return;
    } else if (username.isEmpty){
      setState(() {
        usernameError = true;
      });
      print('empty');
      return;
    }
    if(password == null) {
      setState(() {
        passError = true;
      });
      print('bad');
      return;
    } else if (password.isEmpty){
      setState(() {
        passError = true;
      });
      return;
    }
    print(username);
    print(password);
    setState(() {
      isFetching = true;
    });

    var response = getToken();
    print(response);
  }

  Future<String> getToken() async {
    var httpClient = new HttpClient();
    var uri = new Uri.https(
        '$username:$password@techbootcamp.aiam-dh.com', '/rest-techsyd3/services/search/jobs/export', {'output_mode': 'json', 'search': 'savedsearch authorise_me'});
    var request = await httpClient.getUrl(uri);
    var response = await request.close();
    var responseBody = await response.transform(utf8.decoder).join();

    var thedata = JSON.decode(responseBody);
    print(thedata);

    var result = thedata['result'];

    if(result == null){
      _controller.clear();
      setState((){
        isFetching = false;
        error = true;
        password = '';
      });
      return;
    } else {
      print(result);

      setState(() {
        isFetching = false;
      });

      if (result['authorisation'] == 'OK') {
        print("HURRAHHHHHHHHH");
        globals.username = username;
        globals.password = password;
        Navigator.of(context).pushNamed(LandingPage.routeName);
      } else {
        print ('some random error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    final appName = new Padding(
      padding: new EdgeInsets.only(bottom: 10.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
          new Text("RAPID ANALYTICS"),
        ],
      ),
    );

    final logo = new Hero(
      tag: 'hero',
      child: new CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 100.0,
        child: new Image.asset(
          'assets/images/RA-logo.png'
        ),
      ),
    ); //Hero

    final username = new TextField(
      onChanged: (e) => _onChangeUsername(e),
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
      controller: _controller,
      onChanged: (e) => _onChangePassword(e),
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
            _onLoginButtonPressed();
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

    final fetchingIndicator = new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget> [
        new Padding(
          padding: new EdgeInsets.only(left: 0.0, right: 20.0, bottom: 30.0, top: 30.0),
          child: new CircularProgressIndicator(),
        ),
        new Text(
            "Verifying credentials...",
            style: new TextStyle(fontStyle: FontStyle.italic),
        ),
      ],
    );

    final errorText = new Padding(
      padding: new EdgeInsets.only(top: 10.0),
      child: new Column (
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
            new Text(
              errorMsg,
              style: new TextStyle(color: Colors.red)
            ),
        ],
      ),
    );

    return new Scaffold(
        backgroundColor: Colors.white,
        body: new Center(
          child: new ListView(
            shrinkWrap: true,
            padding: new EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              new Padding(padding: new EdgeInsets.only(top: 60.0),),
              //appName,
              logo,
              new SizedBox(height: 56.0),
              username,
              new SizedBox(height: 8.0),
              password,
              (error) ? errorText : new SizedBox(height: 0.0),
              new SizedBox(height: 16.0),
              (isFetching) ? fetchingIndicator : loginButton,
              forgotLabel,
              newUser,
              new Padding(padding: new EdgeInsets.only(bottom: 80.0),),
            ],
          ),
        ),
      );

  }
}

