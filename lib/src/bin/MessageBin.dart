import 'package:flutter/material.dart';

/**
 * Created by zgx on 2017/5/23.
 * 单条消息显示模板
 */
class MessageBin extends StatelessWidget {
  MessageBin({this.title, this.body, this.time, this.animationController});

  final String title;
  final String body;
  final String time;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return new SizeTransition(
        sizeFactor: new CurvedAnimation(
            parent: animationController, //new
            curve: Curves.easeInOut //new
            ),
        axisAlignment: 0.0,
        child: new Container(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            top: 10.0,
          ),
          child: new Material(
            type: MaterialType.card,
            child: new Column(
              children: [
                new Container(
                  color: Colors.grey,
                  height: 35.0,
                  padding: const EdgeInsets.only(left: 10.0),
                  alignment: FractionalOffset.centerLeft,
                  child: new Text(title,
                      style: const TextStyle(color: Colors.white)),
                ),
                new Container(
                  height: 85.0,
                  child: new Text(body, softWrap: true),
                ),
                new Container(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: new Divider(height: 1.0),
                ),
                new Container(
                  padding: const EdgeInsets.only(left: 10.0),
                  height: 30.0,
                  child: new Row(
                    children: <Widget>[
                      new Icon(Icons.access_time),
                      new Text(time),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
