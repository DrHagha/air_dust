import 'dart:math';

import 'package:flutter/material.dart';

class MyAnimatedContainer extends StatefulWidget{
  const MyAnimatedContainer({Key? key}) : super(key:key);
  @override
  _AnimatedContainerState createState() => _AnimatedContainerState();
}

class _AnimatedContainerState extends State<MyAnimatedContainer>{
  double _width = 50;
  double _height = 50;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimatedContainer'),
      ),
      body: Center(
        child: AnimatedContainer(
            width: _width,
            height: _height,
            color: Colors.green,
            duration: const Duration(seconds: 1)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {            
            final random = Random();
            _width = random.nextInt(300).toDouble();
            _height = random.nextInt(300).toDouble();
          });
        },
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}