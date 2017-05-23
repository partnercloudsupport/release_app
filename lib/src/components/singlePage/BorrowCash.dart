import 'package:flutter/material.dart';


/**
 * Created by zgx on 2017/5/23.
 * 借款申请
 */
class BorrowCash extends StatefulWidget {
  @override
  _BorrowCashState createState() => new _BorrowCashState();
}

class _BorrowCashState extends State<BorrowCash> {

  double _sliderValue = 200.0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('现金口贷'),
        centerTitle: true,
      ),
      body: new ListView(
        children: [
          new Container(
            height: 140.0,
            color: Theme.of(context).primaryColor,
          ),
          new Container(
            padding: const EdgeInsets.only(left: 20.0,right: 20.0),
            height: 180.0,
              color: Colors.green,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  child: new Text('借款金额'),
                ),
                new Slider(
                  onChanged: (value){
                    print('变化值:'+ value.toString());
                    setState((){
                      _sliderValue = value;
                    });
                  },
                  value: _sliderValue,
                  min: 100.0,
                  max: 3000.0,
                label: '金额${_sliderValue}',
                  divisions: 100,
                ),
                new Container(
                  margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: new Text('借款期限'),
                ),
                new RaisedButton(
                  child: new Container(
                    alignment: FractionalOffset.center,
                    child: new Text('下一步'),
                  ),
                  onPressed: (){},
                ),
              ],
            ),
          ),
          new Container(),
        ],
      ),
    );
  }
}


 