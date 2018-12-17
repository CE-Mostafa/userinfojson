import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  List _data = await getJson();

  runApp(new MaterialApp(
    home: new Scaffold(
      appBar: new AppBar(
        title: new Text('JSON Parse'),
        backgroundColor: Colors.orangeAccent,
        centerTitle: true,
      ),
      body: new Center(
        child: new ListView.separated(
            itemCount: _data.length,
            padding: const EdgeInsets.all(15.0),
            separatorBuilder: (BuildContext context, int position) {
              return new Divider(color: Colors.blueAccent,height: 20.0,);
            },
            itemBuilder: (BuildContext context, int position) {
              final index = position;

              return new ListTile(
                onTap: () {
                  _showOnTapMessage(
                      context,
                      "Address:\n  Street: ${_data[index]['address']['street']}\n  City: ${_data[index]['address']['city']}"
                      "\n  Geo: lat: ${_data[index]['address']['geo']['lat']} - lng: ${_data[index]['address']['geo']['lng']}"
                      "\nWebsite: ${_data[index]['website']}\nPhone: ${_data[index]['phone']}\nCompany: ${_data[index]['company']['name']}");
                },
                leading: new CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  child: new Text(
                      "${_data[index]['name'][0].toString().toUpperCase()}"),
                ),
                title: new Text(
                  "${_data[index]['name']}",
                  style: new TextStyle(fontSize: 20.0),
                ),
                subtitle: new Text(
                  "Username: ${_data[index]['username']}\nemail: ${_data[index]['email']}",
                  style: new TextStyle(fontSize: 15.0),
                ),
              );
            }),
      ),
    ),
  ));
}

void _showOnTapMessage(BuildContext context, String message) {
  var alert = new AlertDialog(
    title: new Text("more info"),
    content: new Text("$message"),
    actions: <Widget>[
      new FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: new Text("Ok"))
    ],
  );
  showDialog(context: context, child: alert, barrierDismissible: false);
}

Future<List> getJson() async {
  String apiUrl = "https://jsonplaceholder.typicode.com/users";

  http.Response response = await http.get(apiUrl);

  return json.decode(response.body);
}
