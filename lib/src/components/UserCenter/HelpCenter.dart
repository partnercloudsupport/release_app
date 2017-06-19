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
        body: new ListView(
          children: <Widget>[
            new Container(
                height: 140.0,
                color: Theme
                    .of(context)
                    .primaryColor,
                alignment: FractionalOffset.center,
                child: new Column(
                  children: <Widget>[
                    new InkWell(
                      onTap: (){print('点击了');},
                      child: new Container(
                        height: 80.0,
                        width: 80.0,
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white
                        ),
                        child: new Icon(
                          Icons.headset_mic, size: 60.0, color: Theme
                            .of(context)
                            .primaryColor,),
                      ),
                    ),
                    new SizedBox(height: 8.0,),
                    const Text('点击咨询', style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),),
                    const Text('客服xxx，为您提供在线服务', style: const TextStyle(
                        color: Colors.white, fontSize: 11.0),),
                  ],
                )

            ),
            new SizedBox(height: 16.0,),
            new Container(
              height: 200.0,
              color: Colors.white,
              padding: const EdgeInsets.all(16.0),
              child: new GridView(
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                children: <Widget>[
                    new Column(
                      children: <Widget>[
                        new FloatingActionButton(
                          elevation: 1.0,
                          child: new Icon(Icons.refresh, color: Theme
                              .of(context)
                              .primaryColor, size: 48.0,),
                          onPressed: () {}, backgroundColor: Colors.white,),
                        new Container(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: const Text(
                            '热门问题', style: const TextStyle(fontSize: 13.0),),
                        )
                      ],
                    ),
                  //总是报错，待查看demo后修改
//                    new Column(
//                      children: <Widget>[
//                        new FloatingActionButton(
//                          elevation: 1.0,
//                          child: new Icon(Icons.refresh, color: Theme
//                              .of(context)
//                              .primaryColor, size: 48.0,),
//                          onPressed: () {}, backgroundColor: Colors.white,),
//                        new Container(
//                          padding: const EdgeInsets.only(top: 5.0),
//                          child: const Text(
//                            '热门问题', style: const TextStyle(fontSize: 13.0),),
//                        )
//                      ],
//                    ),
//                  new Container(
//                    child: new Column(
//                      children: <Widget>[
//                        new FloatingActionButton(
//                          elevation: 1.0,
//                          child: new Icon(Icons.refresh, color: Theme
//                              .of(context)
//                              .primaryColor, size: 48.0,),
//                          onPressed: () {}, backgroundColor: Colors.white,),
//                        new Container(
//                          padding: const EdgeInsets.only(top: 5.0),
//                          child: const Text(
//                            '审核相关', style: const TextStyle(fontSize: 13.0),),
//                        )
//                      ],
//                    ),
//                  ),
//                  new Container(
//                    child: new Column(
//                      children: <Widget>[
//                        new FloatingActionButton(
//                          elevation: 1.0,
//                          child: new Icon(Icons.refresh, color: Theme
//                              .of(context)
//                              .primaryColor, size: 48.0,),
//                          onPressed: () {}, backgroundColor: Colors.white,),
//                        new Container(
//                          padding: const EdgeInsets.only(top: 5.0),
//                          child: const Text(
//                            '借款相关', style: const TextStyle(fontSize: 13.0),),
//                        )
//                      ],
//                    ),
//                  ),
//                  new Container(
//                    child: new Column(
//                      children: <Widget>[
//                        new FloatingActionButton(
//                          elevation: 1.0,
//                          child: new Icon(Icons.refresh, color: Theme
//                              .of(context)
//                              .primaryColor, size: 48.0,),
//                          onPressed: () {}, backgroundColor: Colors.white,),
//                        new Container(
//                          padding: const EdgeInsets.only(top: 5.0),
//                          child: const Text(
//                            '放款相关', style: const TextStyle(fontSize: 13.0),),
//                        )
//                      ],
//                    ),
//                  ),
//                  new Container(
//                    child: new Column(
//                      children: <Widget>[
//                        new FloatingActionButton(
//                          elevation: 1.0,
//                          child: new Icon(Icons.refresh, color: Theme
//                              .of(context)
//                              .primaryColor, size: 48.0,),
//                          onPressed: () {}, backgroundColor: Colors.white,),
//                        new Container(
//                          padding: const EdgeInsets.only(top: 5.0),
//                          child: const Text(
//                            '还款相关', style: const TextStyle(fontSize: 13.0),),
//                        )
//                      ],
//                    ),
//                  ),
//                  new Container(
//                    child: new Column(
//                      children: <Widget>[
//                        new FloatingActionButton(
//                          elevation: 1.0,
//                          child: new Icon(Icons.refresh, color: Theme
//                              .of(context)
//                              .primaryColor, size: 48.0,),
//                          onPressed: () {}, backgroundColor: Colors.white,),
//                        new Container(
//                          padding: const EdgeInsets.only(top: 5.0),
//                          child: const Text(
//                            '费用相关', style: const TextStyle(fontSize: 13.0),),
//                        )
//                      ],
//                    ),
//                  ),
//                  new Container(
//                    child: new Column(
//                      children: <Widget>[
//                        new FloatingActionButton(
//                          elevation: 1.0,
//                          child: new Icon(Icons.refresh, color: Theme
//                              .of(context)
//                              .primaryColor, size: 48.0,),
//                          onPressed: () {}, backgroundColor: Colors.white,),
//                        new Container(
//                          padding: const EdgeInsets.only(top: 5.0),
//                          child: const Text(
//                            '用户隐私', style: const TextStyle(fontSize: 13.0),),
//                        )
//                      ],
//                    ),
//                  ),
//                  new Container(
//                    child: new Column(
//                      children: <Widget>[
//                        new FloatingActionButton(
//                          elevation: 1.0,
//                          child: new Icon(Icons.refresh, color: Theme
//                              .of(context)
//                              .primaryColor, size: 48.0,),
//                          onPressed: () {}, backgroundColor: Colors.white,),
//                        new Container(
//                          padding: const EdgeInsets.only(top: 5.0),
//                          child: const Text(
//                            '联系客服', style: const TextStyle(fontSize: 13.0),),
//                        )
//                      ],
//                    ),
//                  ),
                ],
              ),
            ),
            new SizedBox(height: 16.0,),
            new Container(
              padding: const EdgeInsets.all(16.0),
              child: new RaisedButton(
                onPressed: () {}, child: const Text('关注微信5分钟搞定'),)
              ,
            )
          ],
        )
    );
  }
}