import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:release_app/src/comm/CommBin.dart';

/**
 * Created by zgx on 2017/6/7.
 */
class JobInfoPage extends StatefulWidget {
  JobInfoPage(this.job, {Key key}) : super(key: key);
  final Jobinfo job;
  @override
  _JobInfoPageState createState() => new _JobInfoPageState();
}

class _JobInfoPageState extends State<JobInfoPage> {
  final DatabaseReference _rootRef = FirebaseDatabase.instance.reference();
  final GlobalKey<FormState> _fomrKey = new GlobalKey<FormState>();
  Jobinfo job;
  String _jobName = '';

  String _income = '';

  String _compName = '';

  String _city = '';

  String _compAdd = '';

  String _compPhone = '';

  TextEditingController _commNameController;
  TextEditingController _commAddController;
  TextEditingController _commPhoneController;

  List<String> _jobList = [];

  SliverChildListDelegate _jobSlivertList =
      new SliverChildListDelegate(<Widget>[]);
  SliverChildListDelegate _incomeSlivertList =
      new SliverChildListDelegate(<Widget>[]);
  SliverChildListDelegate _citySlivertList =
      new SliverChildListDelegate(<Widget>[]);

  @override
  void initState() {
    super.initState();
    print(widget.job.job);
    _commNameController = new TextEditingController(
        text: widget.job.compName != null
            ? widget.job.compName
            : TextEditingValue.empty);
    _commAddController = new TextEditingController(
        text: widget.job.compAdd != null
            ? widget.job.compAdd
            : TextEditingValue.empty);
    _commPhoneController = new TextEditingController(
        text: widget.job.compPhone != null
            ? widget.job.compPhone
            : TextEditingValue.empty);
    _jobName = widget.job.job;
    _income = widget.job.monIncome;
    _city = widget.job.cities;
    _initValiable();
  }

  @override
  void dispose() {
    super.dispose();
//    _jobSubscription.cancel();
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
                    ? new Text(_jobName)
                    : index == 1
                        ? new Text(_income)
                        : index == 2
                            ? new Text(_compName)
                            : index == 3
                                ? new Text(_city)
                                : index == 4
                                    ? new Text(_compAdd)
                                    : index == 5 ? new Text(_compPhone) : null,
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
      appBar: new AppBar(
        title: const Text('职业信息'),
        centerTitle: true,
      ),
      body: new Form(
        key: _fomrKey,
        child: new SingleChildScrollView(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
          child: new Container(
            child: new Column(
              children: <Widget>[
                _bottonInputItem('职业', 0),
                new Divider(),
                _bottonInputItem('月收入', 1),
                new Divider(),
//            _bottonInputItem('单位名称', 2),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Container(
                      child: new Text('单位名称'),
                      margin: const EdgeInsets.only(right: 3.0),
                    ),
                    new Expanded(
                      child: new TextFormField(
                        controller: _commNameController != null
                            ? _commNameController
                            : null,
                        validator: _validCompInfo,
                      ),
                    ),
                  ],
                ),
                new Divider(),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Container(
                      child: new Text('单位地址'),
                      margin: const EdgeInsets.only(right: 3.0),
                    ),
                    new Expanded(
                      child: new TextFormField(
                        decoration: new InputDecoration(
                          hintText: '请输入单位地址',
                        ),
                        controller: _commAddController != null
                            ? _commAddController
                            : null,
                        validator: _validCompInfo,
                      ),
                    ),
                  ],
                ),
                new Divider(),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Container(
                      child: new Text('单位电话'),
                      margin: const EdgeInsets.only(right: 3.0),
                    ),
                    new Expanded(
                      child: new TextFormField(
                        decoration: new InputDecoration(
                          hintText: '区号+号码(选填)',
                        ),
                        controller: _commPhoneController != null
                            ? _commPhoneController
                            : null,
                      ),
                    ),
                  ],
                ),
                _bottonInputItem('所在省市', 3),
                new Divider(),
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

  Widget _bottomModel(String value, int index) {
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
          switch (index) {
            case 0:
              _jobName = value;
              break;
            case 1:
              _income = value;
              break;
            case 3:
              _city = value;
              break;
          }
        });
        Navigator.pop(context);
      },
    );
  }

  void _handleClick(int index) {
    showModalBottomSheet<String>(
        context: context,
        builder: (BuildContext context) {
          return new CustomScrollView(slivers: <Widget>[
            new SliverList(
              delegate: index == 0
                  ? _jobSlivertList
                  : index == 1 ? _incomeSlivertList : _citySlivertList,
            ),
          ]
//        ),
              );
        }).then((value) {
      setState(() {});
    });
  }

  _initValiable() async {
    _rootRef.child('comm/income').once().then((data) {
      print("key:" + data.key + " Value:" + data.value.toString());
      Map<String, String> maps = data.value;
      setState(() {
        for (var key in maps.keys) {
          _incomeSlivertList.children.add(_bottomModel(maps[key], 1));
        }
      });
    });

    _rootRef.child('comm/citis').once().then((data) {
      print("key:" + data.key + " Value:" + data.value.toString());
      Map<String, String> maps = data.value;
      setState(() {
        for (var key in maps.keys) {
          _citySlivertList.children.add(_bottomModel(maps[key], 3));
        }
      });
    });

    _rootRef.child('comm/jobname').onChildAdded.listen((Event event) {
      print("add a new job:" + event.snapshot.value);
      setState(() {
        _jobSlivertList.children.add(_bottomModel(event.snapshot.value, 0));
      });
    });
  }

  void _handleSubmit() {
    FormState form = _fomrKey.currentState;
    if (!form.validate()) {
      return;
    } else {
      job = new Jobinfo(
          _jobName,
          _income,
          _commNameController.value.text,
          _city,
          _commAddController.value.text,
          _commPhoneController.value.text);
      Navigator.pop(context, job);
    }
  }

  String _validCompInfo(String value) {
    if (value.isEmpty) {
      return '请输入此项内容!';
    }
    return null;
  }
}
