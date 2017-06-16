import 'package:flutter/material.dart';


/**
 * Created by zgx on 2017/6/12.
 */

class DialogItem extends StatelessWidget {
  const DialogItem({Key key, this.icon, this.color, this.text, this.onPressed})
      : super(key: key);

  final IconData icon;
  final Color color;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return new SimpleDialogOption(
      onPressed: onPressed,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
//          new Icon(icon, size: 36.0, color: color),
          new Padding(
            padding: const EdgeInsets.all(5.0),
//            padding: const EdgeInsets.only(left: 16.0),
            child: new Text(text),
          ),
        ],
      ),
    );
  }
}

class DialogItemValue {

  final String key;
  final String text;


  DialogItemValue(this.key, this.text);
}


//'底部'弹出对话框
class BottomModelDiolog extends StatelessWidget {
  const BottomModelDiolog({Key key, this.title, this.values})
      : super(key: key);

  final String title;
  final List<DialogItemValue> values;
  @override
  Widget build(BuildContext context) {
    return new SimpleDialog(
      title: new Text(title),
      children: values.map((value)=> new DialogItem(text: value.text, onPressed: (){Navigator.pop(context, value);},)).toList(),
//      children: <Widget>[
//        new DialogItem(
//          text: '小学',
//          onPressed: () {
//            Navigator.pop(context, '小学');
//          },
//        ),
//        new DialogItem(
//          text: '初中',
//          onPressed: () {
//            Navigator.pop(context, '初中');
//          },
//        ),
//        new DialogItem(
//          text: '高中',
//          onPressed: () {
//            Navigator.pop(context, '高中');
//          },
//        ),
//        new DialogItem(
//          text: '大学',
//          onPressed: () {
//            Navigator.pop(context, '大学');
//          },
//        ),
//        new DialogItem(
//          text: '研究生及以上',
//          onPressed: () {
//            Navigator.pop(context, '研究生及以上');
//          },
//        ),
//      ],
    );
  }
}

//'婚姻'弹出对话框
class MarriageDiolog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new SimpleDialog(
      title: const Text('请选择婚姻状况'),
      children: <Widget>[
        new DialogItem(
          text: '未婚',
          onPressed: () {
            Navigator.pop(context, '未婚');
          },
        ),
        new DialogItem(
          text: '已婚',
          onPressed: () {
            Navigator.pop(context, '已婚');
          },
        ),
        new DialogItem(
          text: '离异',
          onPressed: () {
            Navigator.pop(context, '离异');
          },
        ),
      ],
    );
  }
}

//'子女数'弹出对话框
class ChildenDiolog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new SimpleDialog(
      title: const Text('请选择子女个数'),
      children: <Widget>[
        new DialogItem(
          text: '0',
          onPressed: () {
            Navigator.pop(context, '0');
          },
        ),
        new DialogItem(
          text: '1',
          onPressed: () {
            Navigator.pop(context, '1');
          },
        ),
        new DialogItem(
          text: '2',
          onPressed: () {
            Navigator.pop(context, '2');
          },
        ),
      ],
    );
  }
}

//'居住时长'弹出对话框
class LivetimeDiolog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new SimpleDialog(
      title: const Text('请选择居住时间'),
      children: <Widget>[
        new DialogItem(
          text: '三个月',
          onPressed: () {
            Navigator.pop(context, '三个月');
          },
        ),
        new DialogItem(
          text: '六个月',
          onPressed: () {
            Navigator.pop(context, '六个月');
          },
        ),
        new DialogItem(
          text: '一年',
          onPressed: () {
            Navigator.pop(context, '一年');
          },
        ),
      ],
    );
  }
}

 