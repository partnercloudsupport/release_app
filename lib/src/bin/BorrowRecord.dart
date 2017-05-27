import 'package:flutter/material.dart';
import 'package:release_app/src/comm/Colors.dart';

/**
 * Created by zgx on 2017/5/23.
 * 单条借款记录显示模板
 */
class SingleRecord extends StatelessWidget {
  SingleRecord({this.balance, this.term, this.status, this.animationController});

  final double balance;
  final String term;
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
                          child: new FlutterLogo(colors: AppColors.primary,),
                        ),
                        new Container(
                          child: new Text('借款', style: Theme.of(context).primaryTextTheme.subhead),
                        ),
                        new Flexible(
                            child: new Text('ABC-1234564654', style: Theme.of(context).primaryTextTheme.subhead)
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
                          child: new  Text('金额', style: Theme.of(context).primaryTextTheme.body1),
                        ),
                        new Text('期限', style: Theme.of(context).primaryTextTheme.body1),
                        new Container(
                          padding: const EdgeInsets.all(5.0),
                          child: new Text('状态',style: Theme.of(context).primaryTextTheme.body1),
                        ),
                      ],
                    ),

                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        new Container(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: new Text(balance.toString()+'元',style: Theme.of(context).primaryTextTheme.body2),
                        ),
                        new Text(term,style: Theme.of(context).primaryTextTheme.body2),
                        new Container(
                          padding: const EdgeInsets.all(5.0),
                          child: new Text(status,style: Theme.of(context).primaryTextTheme.body2),
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
