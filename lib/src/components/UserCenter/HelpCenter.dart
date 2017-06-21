import 'package:flutter/material.dart';

class HelpCenter extends StatefulWidget {
  HelpCenter({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HelpCenterState createState() => new _HelpCenterState();
}

class _HelpCenterState extends State<HelpCenter> {
  final Color textColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          elevation: 0.0,
        ),
        body: new Column(
          children: <Widget>[
            new Container(
                height: 140.0,
                color: Theme.of(context).primaryColor,
                alignment: FractionalOffset.center,
                child: new Column(
                  children: <Widget>[
                    new InkWell(
                      onTap: () {
                        print('点击了');
                      },
                      child: new Container(
                        height: 80.0,
                        width: 80.0,
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: new Icon(
                          Icons.headset_mic,
                          size: 60.0,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    new SizedBox(
                      height: 8.0,
                    ),
                    const Text(
                      '点击咨询',
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      '客服xxx，为您提供在线服务',
                      style:
                          const TextStyle(color: Colors.white, fontSize: 11.0),
                    ),
                  ],
                )),
            new SizedBox(
              height: 16.0,
            ),
            new Container(
              color: Colors.white,
                padding: const EdgeInsets.only(top: 16.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                    _botton('热点问题', Icons.hot_tub,(){print('热点问题');}),
                    _botton('审核相关', Icons.info,(){}),
                    _botton('借款相关', Icons.info,(){}),
                    _botton('放款相关', Icons.info,(){}),
                ],
              ),
            ),
            new Container(
              color: Colors.white,
              padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _botton('热点问题', Icons.hot_tub,(){print('热点问题');}),
                  _botton('审核相关', Icons.info,(){}),
                  _botton('借款相关', Icons.info,(){}),
                  _botton('放款相关', Icons.info,(){}),
                ],
              ),
            ),
            new SizedBox(
              height: 16.0,
            ),
            new Container(
              padding: const EdgeInsets.all(16.0),
              child: new RaisedButton(
                onPressed: () {},
                child: const Text('关注微信5分钟搞定'),
              ),
            )
          ],
        ));
  }

  Widget _botton(String label, IconData icon, Function f) {
    return new Column(
      children: <Widget>[
        new InkWell(
          child: new Container(
            height: 50.0,
            width: 50.0,
            decoration: new BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: new Border.all(width: 1.0, color: Theme.of(context).buttonColor),
            ),
            child: new Icon(icon, color: Theme.of(context).primaryColor,),
          ),
          onTap: f,
        ),
        new Container(
          padding: const EdgeInsets.only(top: 5.0),
          child: new Text(
            label,
            style: const TextStyle(fontSize: 13.0),
          ),
        )
      ],
    );
  }

}
