import 'dart:html';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String stringResponse = "";
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  void _getUser() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      //_fetchUsers();
      apiCall();
    });
  }

  Future apiCall() async {
    http.Response response;
    response =
        await http.get(Uri.parse("https://gorest.co.in/public/v1/users"));
    if (response.statusCode == 200) {
      setState(() {
        stringResponse = response.body;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.22,
            width: MediaQuery.of(context).size.width * 0.9,
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: const Offset(0, 5),
                    blurRadius: 5,
                  )
                ],
                color: const Color(0XFFfefffe)),
            padding: const EdgeInsets.all(8.0),
            child: Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: const Expanded(
                              child: Text(
                                "23°C",
                                style: TextStyle(fontSize: 56),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: const Text(
                              "Columba, Portugal",
                              textAlign: TextAlign.left,
                              style:
                                  TextStyle(fontSize: 24, color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Image.asset(
                      "assets/sun-96.png",
                    ),
                  ),
                ],
              ),
            ),

            /*Expanded(
                  child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: const Expanded(
                              child: Text(
                                "23°C",
                                style: TextStyle(fontSize: 56),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.15,
                            width: MediaQuery.of(context).size.width * 0.5,
                            alignment: Alignment.centerRight,
                            child: Expanded(
                              child: Image.asset(
                                "assets/sun-48.png",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: const Text(
                      "Columba, Portugal",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 24, color: Colors.grey),
                    ),
                  )
                ],
              ))*/
          ),
          Container(
              height: MediaQuery.of(context).size.height * 0.22,
              width: MediaQuery.of(context).size.width * 0.9,
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: const Offset(0, 5),
                      blurRadius: 5,
                    )
                  ],
                  color: const Color(0XFFfefffe)),
              padding: const EdgeInsets.all(8.0),
              child: Container(
                margin: const EdgeInsets.all(5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Column(
                      children: [
                        const Expanded(
                            child: Text(
                          '21°C',
                          style: TextStyle(fontSize: 21),
                        )),
                        Expanded(child: Image.asset("assets/cloudy-96.png")),
                        const Expanded(
                            child: Text(
                          '12:00',
                          style: TextStyle(fontSize: 16),
                        )),
                        const Expanded(
                            child: Text(
                          'PM',
                          style: TextStyle(fontSize: 16),
                        ))
                      ],
                    )),
                    Expanded(
                        child: Column(
                      children: [
                        const Expanded(
                            child: Text(
                          '21°C',
                          style: TextStyle(fontSize: 21),
                        )),
                        Expanded(child: Image.asset("assets/cloudy-96.png")),
                        const Expanded(
                            child: Text(
                          '12:00',
                          style: TextStyle(fontSize: 16),
                        )),
                        const Expanded(
                            child: Text(
                          'PM',
                          style: TextStyle(fontSize: 16),
                        ))
                      ],
                    )),
                    Expanded(
                        child: Column(
                      children: [
                        const Expanded(
                            child: Text(
                          '21°C',
                          style: TextStyle(fontSize: 21),
                        )),
                        Expanded(child: Image.asset("assets/cloudy-96.png")),
                        const Expanded(
                            child: Text(
                          '12:00',
                          style: TextStyle(fontSize: 16),
                        )),
                        const Expanded(
                            child: Text(
                          'PM',
                          style: TextStyle(fontSize: 16),
                        ))
                      ],
                    )),
                    Expanded(
                        child: Column(
                      children: [
                        const Expanded(
                            child: Text(
                          '21°C',
                          style: TextStyle(fontSize: 21),
                        )),
                        Expanded(child: Image.asset("assets/cloudy-96.png")),
                        const Expanded(
                            child: Text(
                          '12:00',
                          style: TextStyle(fontSize: 16),
                        )),
                        const Expanded(
                            child: Text(
                          'PM',
                          style: TextStyle(fontSize: 16),
                        ))
                      ],
                    )),
                    Expanded(
                        child: Column(
                      children: [
                        const Expanded(
                            child: Text(
                          '21°C',
                          style: TextStyle(fontSize: 21),
                        )),
                        Expanded(child: Image.asset("assets/cloudy-96.png")),
                        const Expanded(
                            child: Text(
                          '12:00',
                          style: TextStyle(fontSize: 16),
                        )),
                        const Expanded(
                            child: Text(
                          'PM',
                          style: TextStyle(fontSize: 16),
                        ))
                      ],
                    )),
                  ],
                ),
              )),
          Container(
              height: MediaQuery.of(context).size.height * 0.22,
              width: MediaQuery.of(context).size.width * 0.9,
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: const Offset(0, 5),
                      blurRadius: 5,
                    )
                  ],
                  color: const Color(0XFFfefffe)),
              padding: const EdgeInsets.all(8.0),
              child: Container(
                margin: const EdgeInsets.all(5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Column(
                      children: [
                        const Expanded(
                            child: Text(
                          '21°C',
                          style: TextStyle(fontSize: 21),
                        )),
                        Expanded(child: Image.asset("assets/cloudy-96.png")),
                        const Expanded(
                            child: Text(
                          'Lun',
                          style: TextStyle(fontSize: 16),
                        ))
                      ],
                    )),
                    Expanded(
                        child: Column(
                      children: [
                        const Expanded(
                            child: Text(
                          '18°C',
                          style: TextStyle(fontSize: 21),
                        )),
                        Expanded(child: Image.asset("assets/cloudy-96.png")),
                        const Expanded(
                            child: Text(
                          'Mar',
                          style: TextStyle(fontSize: 16),
                        ))
                      ],
                    )),
                    Expanded(
                        child: Column(
                      children: [
                        const Expanded(
                            child: Text(
                          '14°C',
                          style: TextStyle(fontSize: 21),
                        )),
                        Expanded(child: Image.asset("assets/cloudy-96.png")),
                        const Expanded(
                            child: Text(
                          'Mer',
                          style: TextStyle(fontSize: 16),
                        ))
                      ],
                    )),
                    Expanded(
                        child: Column(
                      children: [
                        const Expanded(
                            child: Text(
                          '19°C',
                          style: TextStyle(fontSize: 21),
                        )),
                        Expanded(child: Image.asset("assets/cloudy-96.png")),
                        const Expanded(
                            child: Text(
                          'Jeu',
                          style: TextStyle(fontSize: 16),
                        ))
                      ],
                    )),
                    Expanded(
                        child: Column(
                      children: [
                        const Expanded(
                            child: Text(
                          '21°C',
                          style: TextStyle(fontSize: 21),
                        )),
                        Expanded(child: Image.asset("assets/cloudy-96.png")),
                        const Expanded(
                            child: Text(
                          'Ven',
                          style: TextStyle(fontSize: 16),
                        ))
                      ],
                    )),
                  ],
                ),
              )),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: _getUser,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.
  //
  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
