import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Container(
          width: double.infinity,
          color: Colors.white,
          child: new Padding(
            padding: new EdgeInsets.all(16.0),
              child: new Column(
                children: <Widget> [
                  new Padding(
                    padding: new EdgeInsets.only(top: 100.0),
                    child: new Image.asset(
                      'assets/images/Accenture-logo.png',
                      width: 150.0,
                      height: 150.0
                    ),
                  ),
                  new TextField(
                    onChanged: (e) => print(e),
                    //onSubmitted: print('submit'),
                    decoration: new InputDecoration(
                      //hintText: 'Email',
                      labelText: 'Email',
                      errorText: null,
                      icon: new Icon(
                        Icons.android,
                      ),
                    ),
                  ),
                  new TextField(
                    obscureText: true,
                    decoration: new InputDecoration(
                      //hintText: 'Password',
                      labelText: 'Password',
                      icon: new Icon(
                        Icons.lock,
                      ),
                    ),
                  ),
                  new Padding(
                    padding: new EdgeInsets.only(top: 20.0),
                    child: new RaisedButton(
                        color: Colors.lightBlue,
                        onPressed: null,
                        child: new Text(
                          "Signin"
                        ),
                    ),
                  ),
                  new Padding(
                    padding: new EdgeInsets.only(top: 20.0),
                    child: new Text(
                      "Forgot Password"
                    ),
                  ),
                  new Padding(
                    padding: new EdgeInsets.all(16.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Expanded(
                          child: new Padding(
                            padding: new EdgeInsets.all(30.0),
                            child: new FittedBox(
                              fit: BoxFit.contain,
                              child: new Image.asset(
                                'assets/images/googleIcon.png',
                              ),
                            ),
                          ),
                        ),
                        new Expanded(
                          child: new Padding(
                            padding: new EdgeInsets.all(30.0),
                            child: new FittedBox(
                              fit: BoxFit.contain,
                              child: new Image.asset(
                                'assets/images/facebookIcon.png',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ), //Column
          ), //Padding
      ), //Container
    ); //Scaffold
  }
}
