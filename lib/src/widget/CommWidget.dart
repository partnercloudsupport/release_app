import 'package:flutter/material.dart';


/**
 * Created by zgx on 2017/6/9.
 * 公用控件,有时间再整理吧
 */

//Widget _bottonInputItem(BuildContext context, String label, int index) {
//  return new InkWell(
//    onTap: () {
//      _handleClick(context,index);
//    },
//    child: new Container(
//      height: 45.0,
//      child: new Row(
//        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//        children: <Widget>[
//          new Expanded(
//            flex: 1,
//            child: new Text(label),
//          ),
//          new Expanded(
//            flex: 2,
//            child: index == 0
//                ? new Text(_jobName)
//                : index == 1
//                ? new Text(_income)
//                : index == 2
//                ? new Text(_compName)
//                : index == 3
//                ? new Text(_city)
//                : index == 4
//                ? new Text(_compAdd)
//                : index == 5 ? new Text(_compPhone) : null,
//          ),
//          new Expanded(
//            flex: 1,
//            child: new Row(
//              mainAxisAlignment: MainAxisAlignment.end,
//              children: <Widget>[
//                new Icon(
//                  Icons.arrow_drop_down,
//                  color: Theme.of(context).brightness == Brightness.light
//                      ? Colors.grey.shade700
//                      : Colors.white70,
//                ),
//              ],
//            ),
//          ),
//        ],
//      ),
//    ),
//  );
//}
//
//void _handleClick(BuildContext context,int index) {
//  showModalBottomSheet<String>(
//      context: context,
//      builder: (BuildContext context) {
//        return new CustomScrollView(slivers: <Widget>[
//          new SliverList(
//            delegate: index == 0
//                ? _jobSlivertList
//                : index == 1 ? _incomeSlivertList : _citySlivertList,
//          ),
//        ]
////        ),
//        );
//      }).then((value) {
//  });
//}

 