import 'package:flutter/material.dart';
import 'package:release_app/src/comm/Colors.dart';


/**
 * Created by zgx on 2017/6/9.
 */
 class GiftPage extends StatefulWidget {
  GiftPage({Key key}) : super(key: key);

  @override
  _GiftPageState createState() => new _GiftPageState();
}

class _GiftPageState extends State<GiftPage> {


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('优惠券'),
        centerTitle: true,
      ),
      body: new SingleChildScrollView(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: new Column(
            children: <Widget>[
              new GiftCard(10, '问卷调查', new DateTime.now()),
              new GiftCard(25, '邀请好友', new DateTime.now()),
              new GiftCard(0, '问卷调查', new DateTime.now()),
            ],
        ),
      ),
    );
  }
}


class GiftCard extends StatefulWidget {
  GiftCard(this.blance, this.way, this.dateTime);

  final int blance;
  final String way;
  final DateTime dateTime;

  @override
  _GiftCardState createState() => new _GiftCardState();

}

class _GiftCardState extends State<GiftCard> {

  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
        color: AppColors.primary,
        borderRadius: new BorderRadius.circular(10.0)
      ),
      margin: const EdgeInsets.only(top: 16.0),
//      child: new Card(
//        color: AppColors.primary,
        child: new Row(
          children: <Widget>[
            new Expanded(
              flex: 1,
              child: new Container(
                  margin: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                  padding: const EdgeInsets.only(right: 16.0),
                  decoration: new BoxDecoration(
                    border: new Border(right: new BorderSide(color: Colors.white)),
                  ),
                  child: new Column(
                    children: <Widget>[
                      new RichText(
                        text: new TextSpan(
                            style: const TextStyle(fontSize: 18.0 , fontWeight: FontWeight.bold),
                            text: '￥',
                            children: [
                              new TextSpan(text: '${widget.blance}', style: new TextStyle(fontSize: 35.0))
                            ]
                        ),
                      ),
                      new Text('优惠券', style: const TextStyle(color: Colors.white),),
                    ],
                  )
              ),
            ),
            new Expanded(
                flex: 2,
                child: new Container(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new RichText(
                        text: new TextSpan(
                            text: '获取途径： ',
                            children: [
                              new TextSpan(text: '${widget.way}'),
                            ]
                        ),
                      ),
                      new SizedBox(height: 8.0,),
                      new RichText(
                        text: new TextSpan(
                            text: '截至日期： ',
                            children: [
                              new TextSpan(text: '${widget.dateTime.year}年${widget.dateTime.month}月${widget.dateTime.day}日'),
                            ]
                        ),
                      ),
                    ],
                  ),
                )
            ),
          ],
        ),
//      ),
    );
  }
}


 