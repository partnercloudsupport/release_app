import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
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
  double _sliderValue = 0.00;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('现金口贷'),
        centerTitle: true,
        elevation:0.0,
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
                            text: '${_sliderValue.floor()}',
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
                              new IconButton(
                                icon: const Icon(
                                  Icons.help,
                                  color: Colors.white,
                                ),
                                onPressed: () {},
                              ),
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
//            color:Theme.of(context).backgroundColor,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  child: new Text('借款金额${_sliderValue}'),
                ),
                new Container(
                  width: 300.0,
                  child: defaultTargetPlatform == TargetPlatform.iOS
                      ? new CupertinoSlider(
                    onChanged: (value) {
                      setState(() {
                        _sliderValue = value;
                      });
                    },
                    value: _sliderValue,
                    min: 0.00,
                    max: 3000.00,
                    divisions: 30,
                  )
                      : new Slider(
                    onChanged: (value) {
                      setState(() {
                        _sliderValue = value;
                      });
                    },
                    value: _sliderValue,
                    min: 0.00,
                    max: 3000.00,
                    divisions: 30,
                    label: '${_sliderValue}',
                  ),
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
