import 'dart:async';
import 'package:flutter/material.dart';


/**
 * Created by zgx on 2017/6/16.
 */
 class TestPage extends StatefulWidget {
  TestPage({Key key}) : super(key: key);

  @override
  _TestPageState createState() => new _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final TIMEOUT = const Duration(seconds: 3);
  final ms = const Duration(milliseconds: 1);

  bool _init = true;


  @override
  void initState() {
    super.initState();
    print('ini前:'+ _init.toString());
    _initvar();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('测试'),
      ),
      body: new Center(
        child: _init?new RaisedButton(
          onPressed: (){
            print(_init.toString());
            setState((){_init=!_init;});
            },
          child: const Text('测试'),
        ):new RaisedButton(
          onPressed: (){print(_init.toString());setState((){_init=!_init;});},
          child: const Text('测试1'),
        ),
      ),
    );
  }

  _initvar()async {
    await startTimeout(3);
  }



  startTimeout([int milliseconds]) {
    var duration = milliseconds == null ? TIMEOUT : ms * milliseconds;
    return new Timer(duration, handleTimeout);
  }

  void handleTimeout() {
    setState((){_init=!_init; print('ini后:'+ _init.toString());});
  }
}

 