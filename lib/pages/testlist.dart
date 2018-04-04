import "dart:async";
import "dart:convert";

import "package:flutter/material.dart";
import 'package:http/http.dart' as http;


class DataList extends StatefulWidget {
  @override
  _DataListState createState() => new _DataListState();
}

class _DataListState extends State<DataList> {

  List data;

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

    this.setState(() {
      data = JSON.decode(response.body);
    });

    print(data[0]['processor']);
    return("success");
  }

  void tileTapped(tile){
    print("TILE TAPPED: ");
    print(tile);
  }

  @override
  void initState() {
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("ListTest"),
      ),
      body: new ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index){
          return new ListTile(
            leading: new Icon(Icons.ac_unit),
            title: new Text(data[index]['processor']),
            subtitle: new Text(data[index]['count']),
            onTap: () {tileTapped(data[index]);}
          );
        }
      ),
    );
  }
}
