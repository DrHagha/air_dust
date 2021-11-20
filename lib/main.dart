import 'package:ans_app/model/AirResult.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Main(),
    );
  }
}

class Main extends StatefulWidget{
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main>{
  AirResult? _result;

  Future<AirResult> fetchData() async{
    var response = await http.get(Uri.parse('http://api.airvisual.com/v2/nearest_city?key=8c83ad8e-ee9d-4c1d-a4b9-d47e4bd4cc1c'));

    AirResult result = AirResult.fromJson(json.decode(response.body));
    return result;
  }

  @override
  void initState(){
    super.initState();

    fetchData().then((airResult) {
      setState(() {
        _result = airResult;
      });
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: _result == null ? CircularProgressIndicator() : Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,  
            children: <Widget>[
            Text(
              'THIS LOCAL DUST',
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(
              height: 16,
            ),
            Card(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text('FACE PIC'),
                        Text(
                          '${_result!.data!.current!.pollution!.aqius}',
                          style: TextStyle(fontSize: 40),
                        ),
                        Text(
                          getString(_result),
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                    color: getColor(_result),
                    padding: const EdgeInsets.all(8.0),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                      child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Image.network(
                              'https://airvisual.com/images/${_result!.data!.current!.weather!.ic}.png',
                              width: 32,
                              height: 32,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                            '${_result!.data!.current!.weather!.tp}',
                            style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        Text('wet ${_result!.data!.current!.weather!.hu}%'),
                        Text('wind ${_result!.data!.current!.weather!.ws}m/s')
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: RaisedButton(
                padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 50),
                color: Colors.orange,
                child: Icon(Icons.refresh, color: Colors.white,),
                onPressed: (){},
              ),
            )
          ],),
        ),
      )
    );
  }

  Color getColor(AirResult? result) {
    if(result!.data!.current!.pollution!.aqius! <= 50){
      return Colors.green;
    }else if(result.data!.current!.pollution!.aqius! <= 100){
      return Colors.yellow;
    }else if(result.data!.current!.pollution!.aqius! <= 150){
      return Colors.orange;
    }else{
      return Colors.red;
    }
  }

  String getString(AirResult? result) {
    if(result!.data!.current!.pollution!.aqius! <= 50){
      return 'GOOD';
    }else if(result!.data!.current!.pollution!.aqius! <= 100){
      return 'NOMAL';
    }else if(result!.data!.current!.pollution!.aqius! <= 150){
      return 'WARN';
    }else{
      return 'BAD';
    }
  }
}