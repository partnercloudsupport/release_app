import 'package:flutter/material.dart';
import 'package:release_app/src/comm/Colors.dart';

/**
 * Created by zgx on 2017/5/23.
 * 单条借款记录显示模板
 */
class SingleRecord extends StatelessWidget {
  SingleRecord({this.orderno, this.balance, this.term,this.termUnit, this.status, this.animationController});
  final String orderno;
  final double balance;
  final String term;
  final String termUnit;
  final String status;
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
            left: 10.0,
            right: 10.0,
            top: 10.0,
          ),
          child: new Card(
            child: new InkWell(
                onTap: (){},
                child: new Column(
                  children: [
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        new Container(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: new FlutterLogo(colors: Colors.amber,),
                        ),
                        new Container(
                          child: new Text('借款', style: new TextStyle(color: Theme.of(context).primaryColor)),
                        ),
                        new Flexible(
                            child: new Text('${orderno}', style: new TextStyle(color: Theme.of(context).primaryColor))
                        ),
                      ],
                    ),
                    const Divider(),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        new Container(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: new  Text('金额', style: new TextStyle(color: Theme.of(context).primaryColor)),
                        ),
                        new Text('期限', style: new TextStyle(color: Theme.of(context).primaryColor)),
                        new Container(
                          padding: const EdgeInsets.all(5.0),
                          child: new Text('状态',style: new TextStyle(color: Theme.of(context).primaryColor)),
                        ),
                      ],
                    ),

                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        new Container(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: new Text(balance.toString()+'元',style: new TextStyle(color: Theme.of(context).primaryColor)),
                        ),
                        new Text('${term} ${termUnit}',style: new TextStyle(color: Theme.of(context).primaryColor)),
                        new Container(
                          padding: const EdgeInsets.all(5.0),
                          child: new Text(status,style: new TextStyle(color: Theme.of(context).primaryColor)),
                        ),
                      ],
                    ),
                  ],
                )
            ),
          ),
        ));
  }
}
