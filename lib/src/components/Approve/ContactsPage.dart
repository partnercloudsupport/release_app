import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:release_app/src/comm/CommBin.dart';

/**
 * Created by zgx on 2017/6/7.
 * 紧急联系人
 */
class ContactsInfoPage extends StatefulWidget {
  ContactsInfoPage(this.contacts, {Key key}) : super(key: key);
  final Contacts contacts;
  @override
  _ContactsInfoPageState createState() => new _ContactsInfoPageState();
}

class _ContactsInfoPageState extends State<ContactsInfoPage> {
  final DatabaseReference _rootRef = FirebaseDatabase.instance.reference();
  final GlobalKey<FormState> _fomrKey = new GlobalKey<FormState>();
  Contacts contact;

  String _kindtype1 = '';

  String _kindtype2 = '';

  TextEditingController _phoneController1;
  TextEditingController _phoneController2;

  SliverChildListDelegate _incomeSlivertList =
      new SliverChildListDelegate(<Widget>[]);

  int _index =0;

  @override
  void initState() {
    super.initState();
    print(widget.contacts.type1);
    _phoneController1 = new TextEditingController(
        text: widget.contacts.phoneNo1 != null
            ? widget.contacts.phoneNo1
            : TextEditingValue.empty);
    _phoneController2 = new TextEditingController(
        text: widget.contacts.phoneNo2 != null
            ? widget.contacts.phoneNo2
            : TextEditingValue.empty);
    _kindtype1 = widget.contacts.type1;
    _kindtype2 = widget.contacts.type2;
    _initValiable();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget _bottonInputItem(String label, int index) {
      return new InkWell(
        onTap: () {
          _handleClick(index);
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
                    ? new Text(_kindtype1)
                    : index == 1 ? new Text(_kindtype2) : null,
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

    return new Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: new AppBar(
        title: const Text('紧急联系人'),
        centerTitle: true,
      ),
      body: new Form(
        key: _fomrKey,
        child: new SingleChildScrollView(
          child: new Container(
            child: new Column(
              children: <Widget>[
                new SizedBox(height: 16.0,),
                new Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: new Column(
                    children: <Widget>[
                      _bottonInputItem('亲属关系', 0),
                      new Divider(),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Expanded(
                            flex: 1,
                            child: new Text('联系方式'),
                          ),
                          new Expanded(
                            flex: 3,
                            child: new TextFormField(
                              decoration: new InputDecoration(
                                hideDivider: true,
                              ),
                              controller: _phoneController1 != null
                                  ? _phoneController1
                                  : null,
                              validator: _validCompInfo,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                new SizedBox(height: 16.0,),
                new Container(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  color: Colors.white,
                  child: new Column(
                    children: <Widget>[
                      _bottonInputItem('社会关系', 1),
                      new Divider(),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Expanded(
                            child: new Text('联系方式'),
                            flex: 1,
                          ),
                          new Expanded(
                            flex: 3,
                            child: new TextFormField(
                              decoration: new InputDecoration(
                                hideDivider: true,
                              ),
                              controller: _phoneController2 != null
                                  ? _phoneController2
                                  : null,
                              validator: _validCompInfo,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                new Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 30.0),
                  child: new RaisedButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      _handleSubmit();
                    },
                    child: const Text('确定'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _bottomModel(String value) {
    return new InkWell(
//      key: key,
      child: new Container(
        child: new Text(value),
        alignment: FractionalOffset.center,
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        height: 48.0,
      ),
      onTap: () {
        setState(() {
          switch (_index) {
            case 0:
              _kindtype1 = value;
              break;
            case 1:
              _kindtype2 = value;
              break;
          }
        });
        Navigator.pop(context);
      },
    );
  }

  void _handleClick(int index) {
    setState((){_index = index;});
    showModalBottomSheet<String>(
        context: context,
        builder: (BuildContext context) {
          return new CustomScrollView(slivers: <Widget>[
            new SliverList(
              delegate: _incomeSlivertList,
            ),
          ]);
        }).then((value) {
      setState(() {});
    });
  }

  _initValiable() async {
    _rootRef.child('comm/kind_type').once().then((data) {
      print("key:" + data.key + " Value:" + data.value.toString());
      Map<String, String> maps = data.value;
      setState(() {
        for (var key in maps.keys) {
          _incomeSlivertList.children.add(_bottomModel(maps[key]));
        }
      });
    });
  }

  void _handleSubmit() {
    FormState form = _fomrKey.currentState;
    if (!form.validate()) {
      return;
    } else {
      contact = new Contacts(_kindtype1, _phoneController1.value.text,_kindtype2,
           _phoneController2.value.text);
      print(_phoneController1.value.text);
      Navigator.pop(context, contact);
    }
  }

  String _validCompInfo(String value) {
    if (value.isEmpty) {
      return '请输入此项内容!';
    }
    return null;
  }
}
