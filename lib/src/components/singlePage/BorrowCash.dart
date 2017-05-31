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
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                new Container(
                  alignment: FractionalOffset.center,
                  child: new RichText(
                    text: new TextSpan(
                      text: '申请金额 ',
                      children: [
                        new TextSpan(
                            text: '500',
                            style: const TextStyle(fontSize: 30.0)),
                        new TextSpan(text: ' .00元'),
                      ],
                    ),
                  ),
                ),
                new Row(
                  children: [
                    new Flexible(
                      child: new Container(
                        alignment: FractionalOffset.center,
                        child: new Container(
                          decoration: new BoxDecoration(
                              border: const Border(
                                  right: const BorderSide(
                                      width: 1.0, color: Colors.white))),
                          child: new Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              new Column(
                                children: [
                                  new Text('到期应还',
                                      style: Theme
                                          .of(context)
                                          .primaryTextTheme
                                          .body2),
                                  new Text('545.00元',
                                      style: Theme
                                          .of(context)
                                          .primaryTextTheme
                                          .body2),
                                ],
                              ),
                              new Icon(Icons.help, color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                    ),
                    new Flexible(
                      child: new Container(
                        alignment: FractionalOffset.center,
                        child: new Column(
                          children: [
                            new Text('贷款期限',
                                style:
                                    Theme.of(context).primaryTextTheme.body2),
                            new Text('7天',
                                style:
                                    Theme.of(context).primaryTextTheme.body2),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
//                ),
              ],
            ),
          ),
          new Container(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            height: 180.0,
            color:Theme.of(context).backgroundColor,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  child: new Text('借款金额'),
                ),
                new Slider(
                  onChanged: (value) {
                    print('变化值:' + value.toString());
                    setState(() {
                      _sliderValue = value;
                    });
                  },
                  value: _sliderValue,
                  min: 100.0,
                  max: 3000.0,
//                  label: '金额${_sliderValue}',
//                  divisions: 100,
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
                  onPressed: () {},
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
