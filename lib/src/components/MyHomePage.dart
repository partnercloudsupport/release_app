import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  // This widget is the home page of your application. It is stateful,
  // meaning that it has a State object (defined below) that contains
  // fields that affect how it looks.

  // This class is the configuration for the state. It holds the
  // values (in this case the title) provided by the parent (in this
  // case the App widget) and used by the build method of the State.
  // Fields in a Widget subclass are always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{
  final List<Widget> _tabs = [
    new Tab(text: 'tab1', icon: const Icon(Icons.home)),
    new Tab(text: 'tab2', icon: const Icon(Icons.assignment)),
    new Tab(text: 'tab3', icon: const Icon(Icons.person_pin)),
  ];

  TabController _tabController;


  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: _tabs.length, vsync: this);
  }


  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance
    // as done by the _incrementCounter method above.
    // The Flutter framework has been optimized to make rerunning
    // build methods fast, so that you can just rebuild anything that
    // needs updating rather than having to individually change
    // instances of widgets.
    return new Scaffold(
//      appBar: new AppBar(
//        title: new Text(widget.title),
//      ),
    appBar: new AppBar(
      title: new Text(widget.title),
        bottom: new TabBar(
            tabs: _tabs,
          controller: _tabController,
          isScrollable: false,
        ),
    ),
      body: new Builder(
          builder: (BuildContext context){
            return new Center(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new MaterialButton(
                    child: const Text('你好'),
                    onPressed: (){
                      Scaffold.of(context).showSnackBar(new SnackBar(
                          content: const Text('snake bar'),
                          action: new SnackBarAction(label: '确定', onPressed: (){
//                            Scaffold.of(context).showSnackBar(
//                                new SnackBar(
//                                    content: new Text('您点击了确定',
//                                        style: new TextStyle(
//                                          color: Colors.red,
//                                          fontSize: 15.0,
//                                          fontWeight: FontWeight.w200,
//                                        ))));
                          })
                      ));
                      setState((){
//                _message = _testSignInAnonymously();

                      });
                    },
                    padding: const EdgeInsets.only(top: 10.0),
                    splashColor: Colors.red[200],
                    textColor: Colors.green[200],
                    highlightColor: Colors.orange[200],
                  ),
                  new MaterialButton(
                    child: const Text('按钮'),
                    onPressed: (){
                      if (widget.title =='我要借钱') {
                        Navigator.of(context).push(
                          new MaterialPageRoute(
                              builder: (BuildContext context){
                                return new Center(
                                  child: new GestureDetector(
                                    child: new Text('OK'),
                                    onTap: () {Navigator.of(context).pop(true);},
                                  ),
                                );
                              },
                          ),
                        );
                      }else {
                        Navigator.of(context).pushNamed('/b');
                      }
                    },
                    padding: const EdgeInsets.only(top: 10.0),
                  ),
                  new Text(''),
                ],
              ),
            );
          },
      ),
    );
  }
}