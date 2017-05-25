import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/**
 * Created by zgx on 2017/5/25.
 * 身份认证
 */

enum DismissDialogAction {
  cancel,
  discard,
  save,
}

class IdentityCertificate extends StatefulWidget {
  IdentityCertificate({Key key}) : super(key: key);

  @override
  _IdentityCertificateState createState() => new _IdentityCertificateState();
}

class _IdentityCertificateState extends State<IdentityCertificate> {
  File imageFile1;
  File imageFile2;
  DateTime _fromDateTime = new DateTime.now();
  DateTime _toDateTime = new DateTime.now();
  bool _allDayValue = false;
  bool _saveNeeded = false;

  getImage() async {
    var _fileName = await ImagePicker.pickImage();
    setState(() {
      imageFile1 = _fileName;
    });
  }

  getImage1() async {
    var _fileName = await ImagePicker.pickImage();
    setState(() {
      imageFile2 = _fileName;
    });
  }

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

    return new Scaffold(
      appBar: new AppBar(
          title: const Text('身份认证'),
          centerTitle: true,
          actions: <Widget>[
            new FlatButton(
                child: new Text('保存',
                    style: theme.textTheme.body1.copyWith(color: Colors.white)),
                onPressed: () {
                  Navigator.pop(context, DismissDialogAction.save);
                })
          ]),
      body: new Form(
          onWillPop: _onWillPop,
          child: new ListView(
              padding: const EdgeInsets.all(16.0),
              children: <Widget>[
                new Container(
                  margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                  height: 120.0,
                  child: new Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      new Expanded(
                        child: new InkWell(
                          onTap: getImage,
                          child: new Container(
                            decoration: new BoxDecoration(
                              border: new Border.all(
                                  width: 1.0, style: BorderStyle.solid),
                            ),
                            margin: const EdgeInsets.all(15.0),
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: imageFile1 == null
                                  ? <Widget>[
                                      new Icon(
                                        Icons.photo_camera,
                                        color: Colors.green[500],
                                      ),
                                      new Text('身份证正面'),
                                    ]
                                  : <Widget>[
                                      new Image.file(
                                        imageFile1,
                                        height: 85.0,
                                      ),
                                    ],
                            ),
                          ),
                        ),
                      ),
                      new Expanded(
                        child: new InkWell(
                          onTap: getImage1,
                          child: new Container(
                            decoration: new BoxDecoration(
                              border: new Border.all(
                                  width: 1.0, style: BorderStyle.solid),
                            ),
                            margin: const EdgeInsets.all(15.0),
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: imageFile2 == null
                                  ? <Widget>[
                                new Icon(
                                  Icons.photo_camera,
                                  color: Colors.green[500],
                                ),
                                new Text('身份证反面'),
                              ]
                                  : <Widget>[
                                new Image.file(
                                  imageFile2,
                                  height: 85.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                new Container(
                  margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                  height: 45.0,
                  child: new Container(
                      child: new InkWell(
                    onTap: () {
                      _handleClick(context, 0);
                    },
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        new Container(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: new Text('刷脸认证'),
                        ),
                        new Expanded(
                          child: new Container(
                            alignment: FractionalOffset.centerRight,
                            child: const Icon(Icons.keyboard_arrow_right),
                          ),
                        ),
                      ],
                    ),
                  )),
                ),
                new Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
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
