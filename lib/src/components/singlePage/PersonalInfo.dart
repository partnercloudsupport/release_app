import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/**
 * Created by zgx on 2017/5/25.
 * 个人信息认证
 */

class PersonalInfo extends StatefulWidget {
  PersonalInfo({Key key}) : super(key: key);

  @override
  _PersonalInfoState createState() => new _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  bool _saveNeeded = false;
  String _education = '';
  String _marriage = '';
  String _childencount = '';
  String _livetime = '';

  Future<bool> _onWillPop() async {
    if (!_saveNeeded) return true;

    final ThemeData theme = Theme.of(context);
    final TextStyle dialogTextStyle =
        theme.textTheme.subhead.copyWith(color: theme.textTheme.caption.color);

    return await showDialog<bool>(
            context: context,
            child: new AlertDialog(
                content: new Text('放弃此次修改?', style: dialogTextStyle),
                actions: <Widget>[
                  new FlatButton(
                      child: const Text('取消'),
                      onPressed: () {
                        Navigator.of(context).pop(
                            false); // Pops the confirmation dialog but not the page.
                      }),
                  new FlatButton(
                      child: const Text('放弃'),
                      onPressed: () {
                        Navigator.of(context).pop(
                            true); // Returning true to _onWillPop will pop again.
                      })
                ])) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    void showDemoDialog<T>({BuildContext context, int index, Widget child}) {
      showDialog<String>(
        context: context,
        child: child,
      ).then<Null>((String value) {
        // The value passed to Navigator.pop() or null.
        print('序号:' + index.toString() + '返回数据:' + value);
        setState(() {
          if (value != null) {
            _saveNeeded = true;
            switch (index) {
              case 0:
                _education = value;
                break;
              case 1:
                _marriage = value;
                break;
              case 2:
                _childencount = value;
                break;
              case 3:
                _livetime = value;
                break;
            }
          }
        });
      });
    }

    Widget _textInputItem(
        String label, String hintText, TextInputType inputType) {
      return new Container(
        height: 45.0,
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Text(label),
              flex: 1,
            ),
            new Expanded(
              flex: 3,
              child: new TextFormField(
                decoration: new InputDecoration(
                  hideDivider: true,
                  hintText: hintText,
                ),
                keyboardType: inputType,
              ),
            ),
          ],
        ),
      );
    }

    Widget _dropdownInputItem(String label, int index) {
      return new InkWell(
        onTap: () {
          showDemoDialog<String>(
            context: context,
            index: index,
            child: index == 0
                ? new EduDiolog()
                : index == 1
                    ? new MarriageDiolog()
                    : index == 2 ? new ChildenDiolog() : new LivetimeDiolog(),
          );
        },
        child: new Container(
          height: 45.0,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Expanded(
                flex: 1,
                child: new Text(label),
              ),
              new Expanded(
                flex: 2,
                child: index == 0
                    ? new Text(_education)
                    : index == 1
                        ? new Text(_marriage)
                        : index == 2
                            ? new Text(_childencount)
                            : index == 3 ? new Text(_livetime) : null,
              ),
              new Expanded(
                flex: 1,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    new Icon(
                      Icons.arrow_drop_down,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.grey.shade700
                          : Colors.white70,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget _iconButtonItem(String label, String hintText, Icon icon) {
      return new InkWell(
        onTap: () {},
        child: new Container(
          height: 45.0,
          child: new Row(
//          mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Expanded(
                flex: 1,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    icon,
                  ],
                ),
              ),
              new Expanded(
                flex: 3,
                child: new Text(label),
              ),
              new Expanded(
                flex: 3,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    new Icon(
                      Icons.keyboard_arrow_right,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.grey.shade700
                          : Colors.white70,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return new Scaffold(
      appBar: new AppBar(
        title: const Text('个人信息认证'),
        centerTitle: true,
      ),
      body: new Form(
          onWillPop: _onWillPop,
          child: new ListView(padding: const EdgeInsets.all(16.0), children: <
              Widget>[
            new Container(
              decoration: new BoxDecoration(
                  border: new Border(
                      top:
                          new BorderSide(width: 1.0, color: theme.dividerColor),
                      bottom: new BorderSide(
                          width: 1.0, color: theme.dividerColor))),
              child: new Column(
                children: <Widget>[
                  _textInputItem('QQ', '请输入QQ号码', TextInputType.number),
                  new Divider(),
                  _textInputItem('电子邮箱', '输入电子邮箱', TextInputType.text),
                  new Divider(),
                  _dropdownInputItem('学历', 0),
                  new Divider(),
                  _dropdownInputItem('婚姻', 1),
                  new Divider(),
                  _dropdownInputItem('子女个数', 2),
                  new Divider(),
                  _textInputItem('常住地址', '请输入常住地址', TextInputType.text),
                  new Divider(),
                  _dropdownInputItem('居住时长', 3),
                ],
              ),
            ),
            new Container(
              margin: const EdgeInsets.only(top: 20.0),
              decoration: new BoxDecoration(
                  border: new Border(
                      top:
                          new BorderSide(width: 1.0, color: theme.dividerColor),
                      bottom: new BorderSide(
                          width: 1.0, color: theme.dividerColor))),
              child: new Column(
                children: <Widget>[
                  _iconButtonItem(
                      '职业信息',
                      '',
                      new Icon(
                        Icons.work,
                        color: theme.primaryColor,
                      )),
                  new Divider(),
                  _iconButtonItem(
                      '紧急联系人',
                      '',
                      new Icon(
                        Icons.contact_phone,
                        color: theme.primaryColor,
                      )),
                  new Divider(),
                  _iconButtonItem(
                      '银行卡信息',
                      '',
                      new Icon(
                        Icons.credit_card,
                        color: theme.primaryColor,
                      )),
                ],
              ),
            ),
            new Container(
              margin: const EdgeInsets.only(top: 15.0),
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
              child: new RaisedButton(
                color: Theme.of(context).primaryColor,
                onPressed: () {},
                child: const Text('提交'),
              ),
            ),
          ])),
    );
  }

  void _handleClick(BuildContext context, int i) {}
}

//'学历'弹出对话框
class EduDiolog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new SimpleDialog(
      title: const Text('请选择学历'),
      children: <Widget>[
        new DialogItem(
          text: '小学',
          onPressed: () {
            Navigator.pop(context, '小学');
          },
        ),
        new DialogItem(
          text: '初中',
          onPressed: () {
            Navigator.pop(context, '初中');
          },
        ),
        new DialogItem(
          text: '高中',
          onPressed: () {
            Navigator.pop(context, '高中');
          },
        ),
        new DialogItem(
          text: '大学',
          onPressed: () {
            Navigator.pop(context, '大学');
          },
        ),
        new DialogItem(
          text: '研究生及以上',
          onPressed: () {
            Navigator.pop(context, '研究生及以上');
          },
        ),
      ],
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
            padding: const EdgeInsets.only(left: 16.0),
            child: new Text(text),
          ),
        ],
      ),
    );
  }
}
