import 'package:flutter/material.dart';


/**
 * Created by zgx on 2017/6/7.
 */
 class JobInfoPage extends StatefulWidget {
  JobInfoPage({Key key}) : super(key: key);

  @override
  _JobInfoPageState createState() => new _JobInfoPageState();
}

class _JobInfoPageState extends State<JobInfoPage> {
  String _jobName='';

  String _income='';

  String _compName ='';

  String _city ='';

  String _compAdd ='';

  String _compPhone ='';

  
  @override
  Widget build(BuildContext context) {


    Widget _bottonInputItem(String label, int index) {
      return new InkWell(
        onTap: () {
          _handleClick();
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
                    : index == 5
                    ? new Text(_compPhone) : null,
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
        child: new ListView(
          padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 5.0),
          children: <Widget>[
            _bottonInputItem('职业',0),
            new Divider(),
            _bottonInputItem('月收入',1),
            new Divider(),
            _bottonInputItem('单位名称',2),
            new Divider(),
            _bottonInputItem('所在省市',3),
            new Divider(),

            new Container(
              margin: const EdgeInsets.only(top: 20.0),
              padding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
              child: new RaisedButton(
                color: Theme.of(context).primaryColor,
                onPressed: () {
//                  _handleSubmit();
                },
                child: const Text('确定'),
              ),
            ),

          ],
        ),
      ),

    );
  }

  void _handleClick() {
    showModalBottomSheet<String>(context: context,builder: (BuildContext context){
      return new Container(
        child: new Padding(
          padding: const EdgeInsets.all(32.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new InkWell(
                child: new Text('程序员'),
                onTap: (){
                  setState((){_jobName='程序员';});
                  Navigator.pop(context);
                },
              ),
              new InkWell(
                child: new Text('医生'),
                onTap: (){
                  setState((){_jobName='医生';});
                  Navigator.pop(context);
                },
              ),
              new InkWell(
                child: new Text('设计师'),
                onTap: (){
                  setState((){_jobName='设计师';});
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      );
    }).then((value){
      setState((){});
    });
  }
}

 