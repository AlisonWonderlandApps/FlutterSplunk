import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert'; //convert json to a list

class JsonPage extends StatefulWidget {
  @override
  _JsonPageState createState() => new _JsonPageState();
}

class _JsonPageState extends State<JsonPage> {

  Future<String> getData() async {
   // http.Response
    var response = await http.get(
      Uri.encodeFull("https://api.myjson.com/bins/1dlmxv"),
      headers: {
        //"key": "apikey",
        "Accept": "application.json",
      }
    );

    print(response.body);
    List data = JSON.decode(response.body);
    print('******************');
    print (data[0]['processor']);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new RaisedButton(
          child: new Text("get data"),
          onPressed: getData,
        ),
      ),
    );
  }
}
