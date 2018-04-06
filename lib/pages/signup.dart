import 'package:flutter/material.dart';

import './signin_page.dart';
import './landing_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({ Key key }) : super(key: key);

  static String routeName = 'signup-page';

  @override
  _SignUpPageState createState() => new _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
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
      onChanged: (e) => print(e),
      keyboardType: TextInputType.text,
      autofocus: false,
      decoration: new InputDecoration(
        hintText: 'Username',
        contentPadding: new EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(32.0),
        ),
      ),
    );

    final email = new TextField(
      onChanged: (e) => print(e),
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: new InputDecoration(
        hintText: 'Email',
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
            Scaffold.of(context).showSnackBar(new SnackBar(
            content: new Text('Sorry Functionality not yet available.')
          ));
          },
          color: Colors.lightBlueAccent,
          child: new Text("Sign Up", style: new TextStyle(color: Colors.white)),
        ),
      ),
    );

    final newUser = new FlatButton(
      child: new Text(
          'Already have an account? Click here',
          style: new TextStyle(color: Colors.black54)
      ),
      onPressed: () {
        Navigator.of(context).pushNamed(SignInPage.routeName);
        },
    );

    return new Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: new Center(
        child: new ListView(
          shrinkWrap: true,
          padding: new EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            new Padding(padding: new EdgeInsets.only(top: 60.0),),
            logo,
            new SizedBox(height: 56.0),
            username,
            new SizedBox(height: 8.0),
            email,
            new SizedBox(height: 8.0),
            password,
            new SizedBox(height: 16.0),
            new Padding(
              padding: new EdgeInsets.symmetric(vertical: 16.0),
              child: new Material(
                borderRadius: new BorderRadius.circular(30.0),
                shadowColor: Colors.lightBlueAccent[100],
                elevation: 5.0,
                child: new MaterialButton(
                  minWidth: 200.0,
                  height: 42.0,
                  onPressed: () {
                    _scaffoldKey.currentState.showSnackBar(new SnackBar(
                        content: new Text('Sorry Functionality not yet available.')
                    ));
                  },
                  color: Colors.lightBlueAccent,
                  child: new Text("Sign Up", style: new TextStyle(color: Colors.white)),
                ),
              ),
            ),
            newUser,
            new Padding(padding: new EdgeInsets.only(bottom: 80.0),),
          ],
        ),
      ),
    );

  }
}

