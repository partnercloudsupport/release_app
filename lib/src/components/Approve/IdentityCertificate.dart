import 'dart:async';
import 'dart:io';
import 'package:firebaseui/firebaseui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

/**
 * Created by zgx on 2017/5/25.
 * 身份认证
 */

enum IdentityDialogAction {
  cancel,
  discard,
  save,
}

final FirebaseAuth auth = FirebaseAuth.instance;

class IdentityCertificate extends StatefulWidget {
  IdentityCertificate({Key key}) : super(key: key);

  @override
  _IdentityCertificateState createState() => new _IdentityCertificateState();
}

class _IdentityCertificateState extends State<IdentityCertificate> {
  Future<File> imageFile1;
  Future<File> imageFile2;
  bool _saveNeeded = false;
  bool _isUploading = false;
  bool _uploadSuccess = false;
  double _processValue = 0.0; //上传进度

  Future<File> getImage() async {
    return ImagePicker.pickImage();
  }

//  getImage1() async {
//    var _fileName = await ImagePicker.pickImage();
//    setState(() {
//      imageFile2 = _fileName;
//      _saveNeeded = true;
//    });
//  }

  Future<bool> _onWillPop() async {
    if (!_saveNeeded) return true;

    final ThemeData theme = Theme.of(context);
    final TextStyle dialogTextStyle =
        theme.textTheme.subhead.copyWith(color: theme.textTheme.caption.color);

    return await showDialog<bool>(
            context: context,
            child: defaultTargetPlatform == TargetPlatform.iOS
                ? new CupertinoAlertDialog(
                    content: new Text('放弃此次修改?', style: dialogTextStyle),
                    actions: <Widget>[
                        new CupertinoButton(
                            child: const Text('取消'),
                            onPressed: () {
                              Navigator.of(context).pop(
                                  false); // Pops the confirmation dialog but not the page.
                            }),
                        new CupertinoButton(
                            child: const Text('放弃'),
                            onPressed: () {
                              Navigator.of(context).pop(
                                  true); // Returning true to _onWillPop will pop again.
                            })
                      ])
                : new AlertDialog(
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
                  _uploadFile();
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
                          onTap: () {
                            setState(() {
                              imageFile1 = getImage();
                              _saveNeeded = true;
                            });
                          },
                          child: new Container(
                            decoration: new BoxDecoration(
                              shape: BoxShape.rectangle,
                              border: new Border.all(width: 1.0),
//                              image: new DecorationImage(
//                                image: imageFile1!=null?new FileImage(imageFile1):const AssetImage('images/ic_center_more_icon.png'),
//                              ),
                            ),
                            height: 95.0,
                            margin: const EdgeInsets.all(15.0),
                            child: new Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new FutureBuilder(
                                    future: imageFile1,
                                    builder: (BuildContext context,
                                        AsyncSnapshot<File> snapshot) {
                                      if (snapshot.connectionState ==
                                              ConnectionState.done &&
                                          snapshot.data != null) {
                                        return new Expanded(
                                          child: new Image.file(snapshot.data),
                                        );
                                      } else {
                                        return new Column(
                                          children: <Widget>[
                                            new Icon(
                                              Icons.photo_camera,
                                              color: Colors.green[500],
                                            ),
                                            new Text('身份证正面'),
                                          ],
                                        );
                                      }
                                    },
                                  ),
                                ]),
                          ),
                        ),
                      ),
                      new Expanded(
                        child: new InkWell(
                          onTap: () {
                            setState(() {
                              imageFile2 = getImage();
                              _saveNeeded = true;
                            });
                          },
                          child: new Container(
                            decoration: new BoxDecoration(
                              border: new Border.all(
                                  width: 1.0, style: BorderStyle.solid),
                            ),
                            margin: const EdgeInsets.all(15.0),
                            child: new Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new FutureBuilder(
                                    future: imageFile2,
                                    builder: (BuildContext context,
                                        AsyncSnapshot<File> snapshot) {
                                      if (snapshot.connectionState ==
                                              ConnectionState.done &&
                                          snapshot.data != null) {
                                        return new Expanded(
                                          child: new Image.file(snapshot.data),
                                        );
                                      } else {
                                        return new Column(
                                          children: <Widget>[
                                            new Icon(
                                              Icons.photo_camera,
                                              color: Colors.green[500],
                                            ),
                                            new Text('身份证反面'),
                                          ],
                                        );
                                      }
                                    },
                                  ),
                                ]),
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
                    onPressed: !_isUploading ? _uploadFile : null,
                    child: const Text('提交'),
                  ),
                ),
                new Center(
                  child: _isUploading ? new CircularProgressIndicator() : null,
                ),
                new Container(
                  margin: const EdgeInsets.only(top: 15.0),
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 30.0),
                  child: new Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      !_uploadSuccess
                          ? new Text('选择好照片后，请点击提交按钮！')
                          : new Text(
                              '上传成功!',
                              style: const TextStyle(
                                  color: const Color.fromARGB(255, 0, 155, 0)),
                            )
                    ],
                  ),
                ),
              ])),
    );
  }

  void _handleClick(BuildContext context, int i) {}

  Future<Null> _uploadFile() async {
    if (imageFile1 == null || imageFile2 == null) {
      showDialog(
        context: context,
        child: new AlertDialog(
          title: const Text('提醒'),
          content: const Text('请先选择照片'),
          actions: <Widget>[
            new FlatButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            )
          ],
        ),
      );
      return;
    }

    UiFirebaseUser user = await Firebaseui.currentUser;

    if (user == null) {
      print("未登录");
      return;
    }
    setState(() {
      _isUploading = true;
      _uploadSuccess = false;
    });
    print('start uploading....');
    String xx;
    File imagefile;
    await imageFile1.then((file) {
      imagefile = file;
      xx = file.path.split('.')[1];
    });
    StorageReference ref = FirebaseStorage.instance
        .ref()
        .child("faceimages/${user.uid}/face1.${xx}");
    StorageUploadTask uploadTask = ref.put(imagefile);

    Uri downloadUrl = (await uploadTask.future).downloadUrl;

    await imageFile2.then((file) {
      imagefile = file;
      xx = file.path.split('.')[1];
    });

//    xx = imageFile2.path.split('.')[1];
    ref = FirebaseStorage.instance
        .ref()
        .child("faceimages/${user.uid}/face2.${xx}");
    uploadTask = ref.put(imagefile);
    downloadUrl = (await uploadTask.future).downloadUrl;

    print('complete uploading....' + downloadUrl.path);
    setState(() {
      _isUploading = false;
      _saveNeeded = false;
      _uploadSuccess = true;
    });
    Navigator.pop(context, IdentityDialogAction.save);
  }
}
