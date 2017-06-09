import 'package:firebase_database/firebase_database.dart';
import 'package:firebaseui/firebaseui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:release_app/src/comm/Colors.dart';

/**
 * Created by zgx on 2017/6/9.
 * 个人资料
 */
class UserProfile extends StatefulWidget {
  UserProfile({Key key}) : super(key: key);

  @override
  _UserProfileState createState() => new _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final TextStyle labelStyle = new TextStyle(fontSize: 16.0);
  final TextStyle highStyle =
      new TextStyle(fontSize: 16.0, color: AppColors.primary);
  final TextStyle infoStyle =
      new TextStyle(fontSize: 16.0, color: AppColors.bankCardTextCorlor);
  final DatabaseReference _rootRef = FirebaseDatabase.instance.reference();
  String userid;
  bool _readyIcon = false;
  ImageProvider<NetworkImage> bankIcon;
  Map<String, String> _bankinfo;

  @override
  void initState() {
    super.initState();
    _initValiable();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('个人资料'),
        centerTitle: true,
        actions: <Widget>[
          new CupertinoButton(
            child: new Text(
              '修改',
              style: new TextStyle(color: Theme.of(context).buttonColor),
            ),
            onPressed: () {
              Navigator.of(context).push(new MaterialPageRoute<Null>(
                  builder: (BuildContext context) => new UpdateUserProfile(),
                  fullscreenDialog: true));
            },
          ),
        ],
      ),
      body: new Container(
        padding: const EdgeInsets.all(8.0),
        child: new Column(
          children: <Widget>[
            new Card(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Container(
                    height: 48.0,
                    padding:
                        const EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
//                    margin: const EdgeInsets.only(
//                        top: 8.0, bottom: 8.0, left: 2.0, right: 2.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text(
                          '手机号码',
                          style: labelStyle,
                        ),
                        new Text(
                          '1325465464',
                          style: highStyle,
                        ),
                        new InkWell(
                          child: new Row(
                            children: <Widget>[
                              const Text('注销'),
                              new Icon(
                                Icons.chevron_right,
                                size: 24.0,
                                color: AppColors.primary,
                              )
                            ],
                          ),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  new Container(
                    height: 48.0,
                    padding:
                        const EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text(
                          '职业',
                          style: labelStyle,
                        ),
                        new Text(
                          '产品经理',
                          style: labelStyle,
                        ),
                        new Container(
                          width: 20.0,
                        ),
                      ],
                    ),
                  ),
                  new Container(
                    height: 48.0,
                    padding:
                        const EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text(
                          '收入水平',
                          style: labelStyle,
                        ),
                        new Text(
                          '1325465464',
                          style: highStyle,
                        ),
                        new Container(
                          width: 40.0,
                        ),
                      ],
                    ),
                  ),
                  new Container(
                    height: 48.0,
                    padding:
                        const EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text(
                          '亲属联系方式',
                          style: labelStyle,
                        ),
                        new Text(
                          '1325465464',
                          style: highStyle,
                        ),
                        new Container(
                          width: 40.0,
                        ),
                      ],
                    ),
                  ),
                  new Container(
                    height: 48.0,
                    padding:
                        const EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text(
                          '朋友联系方式',
                          style: labelStyle,
                        ),
                        new Text(
                          '1325465464',
                          style: highStyle,
                        ),
                        new Container(
                          width: 40.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            new Container(
              height: 100.0,
              child: new InkWell(
                onTap: () {},
                child: new Card(
                  color: AppColors.primary.shade400,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Icon(
                        Icons.account_circle,
                        size: 48.0,
                      ),
                      new Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text(
                            '身份证好  43***********2718',
                            style: infoStyle,
                          ),
                          new Text('真实姓名  **李', style: infoStyle),
                        ],
                      ),
                      const Icon(
                        Icons.check_circle_outline,
                        size: 48.0,
                      )
                    ],
                  ),
                ),
              ),
            ),
            new Container(
              height: 100.0,
              child: new InkWell(
                onTap: () {},
                child: new Card(
                  color: AppColors.bankCardCorlor,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      _readyIcon
                          ? new Image(
                              image: bankIcon,
                              width: 48.0,
                              height: 48.0,
                            )
                          : const Icon(
                              Icons.credit_card,
                              size: 48.0,
                            ),
                      new Container(
                        width: 200.0,
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Text(
                              '银行名称  ${_bankinfo != null
                                  ? _bankinfo['openBank']
                                  : ''}',
                              style: infoStyle,
                            ),
                            new Text(
                                '银行卡号  ${_bankinfo != null
                                    ? _bankinfo['cardNo']
                                    : ''}',
                                style: infoStyle),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.check_circle_outline,
                        size: 48.0,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _initValiable() async {
    if (userid == null) {
      await Firebaseui.currentUser.then((user) {
        userid = user.uid;
      });
    }
    await _rootRef
        .child('person_info')
        .child('${userid}')
        .child('bankcards')
        .once()
        .then((bank) {
      if (bank != null) {
        setState(() {
          _bankinfo = bank.value;
        });
        _rootRef
            .child("comm/banks")
            .child('${_bankinfo['openBank']}')
            .once()
            .then((bankinfos) {
          print(bankinfos.key);
          Map<String, String> bankinfo = bankinfos.value;

          bankIcon = new NetworkImage('${bankinfo['logo']}');
          if (mounted) {
            setState(() {
              _readyIcon = true;
            });
          }
        });
      }
    });
  }
}

/**
 * 更新个人资料页
 */

class UpdateUserProfile extends StatefulWidget {
  UpdateUserProfile({Key key}) : super(key: key);

  @override
  _UpdateUserProfileState createState() => new _UpdateUserProfileState();
}

class _UpdateUserProfileState extends State<UpdateUserProfile>
    with SingleTickerProviderStateMixin {
  double _kAppBarHeight = 150.0;
  List<String> _allPages = ['个人信息', '职业信息', '社会关系'];
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: _allPages.length, vsync: this);
  }

  /**
   * 个人信息维护页面
   */
  Widget _personInfoPage() {
    return new Card(
      child: new Form(
        child: new ListView(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          children: <Widget>[
            new SingleChildScrollView(
              child: new Column(
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Container(
                        alignment: FractionalOffset.centerRight,
                        width: 70.0,
                        child: new Text('QQ号码：'),
                      ),
                      new Expanded(
                        child: new TextFormField(
                          decoration: new InputDecoration(),
                        ),
                      ),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      new Text('电子邮箱：'),
                      new Expanded(
                        child: new TextFormField(
                          decoration: new InputDecoration(),
                        ),
                      ),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      new Container(
                        alignment: FractionalOffset.centerRight,
                        width: 70.0,
                        child: new Text('学历：'),
                      ),
                      new Expanded(
                        child: new TextFormField(
                          decoration: new InputDecoration(),
                        ),
                      ),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      new Text('婚姻状况：'),
                      new Expanded(
                        child: new TextFormField(
                          decoration: new InputDecoration(),
                        ),
                      ),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      new Text('子女个数：'),
                      new Expanded(
                        child: new TextFormField(
                          decoration: new InputDecoration(),
                        ),
                      ),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      new Text('居住地址：'),
                      new Expanded(
                        child: new TextFormField(
                          decoration: new InputDecoration(),
                        ),
                      ),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      new Text('居住时长：'),
                      new Expanded(
                        child: new TextFormField(
                          decoration: new InputDecoration(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            new Container(
              margin: const EdgeInsets.only(top: 16.0),
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: new RaisedButton(
                color: AppColors.primary,
                onPressed: () {
                  _tabController.animateTo(_tabController.index + 1);
                },
                child: const Text('下一页'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /**
   * 职业信息维护页面
   */
  Widget _jobInfoPage() {
    return new Card(
      child: new Form(
        child: new ListView(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          children: <Widget>[
            new SingleChildScrollView(
              child: new Column(
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Container(
                        alignment: FractionalOffset.centerRight,
                        width: 70.0,
                        child: new Text('职业：'),
                      ),
                      new Expanded(
                        child: new TextFormField(
                          decoration: new InputDecoration(),
                        ),
                      ),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      new Text('薪水范围：'),
                      new Expanded(
                        child: new TextFormField(
                          decoration: new InputDecoration(),
                        ),
                      ),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      new Container(
                        alignment: FractionalOffset.centerRight,
                        child: new Text('公司名称：'),
                      ),
                      new Expanded(
                        child: new TextFormField(
                          decoration: new InputDecoration(),
                        ),
                      ),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      new Text('所在省市：'),
                      new Expanded(
                        child: new TextFormField(
                          decoration: new InputDecoration(),
                        ),
                      ),
                      new SizedBox(
                        width: 16.0,
                      ),
                      new Expanded(
                        child: new TextFormField(
                          decoration: new InputDecoration(),
                        ),
                      ),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      new Text('详细地址：'),
                      new Expanded(
                        child: new TextFormField(
                          decoration: new InputDecoration(),
                        ),
                      ),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      new Text('单位电话：'),
                      new Expanded(
                        child: new TextFormField(
                          decoration: new InputDecoration(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new RaisedButton(
                  color: AppColors.primary,
                  onPressed: () {
                    _tabController.animateTo(_tabController.index - 1);
                  },
                  child: const Text('上一页'),
                ),
                new RaisedButton(
                  color: AppColors.primary,
                  onPressed: () {
                    _tabController.animateTo(_tabController.index + 1);
                  },
                  child: const Text('下一页'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /**
   * 社会关系维护页面
   */
  Widget _contactInfoPage() {
    return new Card(
      child: new Form(
        child: new ListView(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          children: <Widget>[
            new SingleChildScrollView(
              child: new Column(
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Container(
                        alignment: FractionalOffset.centerRight,
                        child: new Text('亲属关系：'),
                      ),
                      new Expanded(
                        child: new TextFormField(
                          decoration: new InputDecoration(),
                        ),
                      ),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      new Text('联系方式：'),
                      new Expanded(
                        child: new TextFormField(
                          decoration: new InputDecoration(),
                        ),
                      ),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      new Container(
                        alignment: FractionalOffset.centerRight,
                        child: new Text('社会关系：'),
                      ),
                      new Expanded(
                        child: new TextFormField(
                          decoration: new InputDecoration(),
                        ),
                      ),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      new Text('联系方式：'),
                      new Expanded(
                        child: new TextFormField(
                          decoration: new InputDecoration(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new RaisedButton(
                  color: AppColors.primary,
                  onPressed: () {
                    _tabController.animateTo(_tabController.index - 1);
                  },
                  child: const Text('上一页'),
                ),
                new RaisedButton(
                  color: AppColors.primary,
                  onPressed: () {

                  },
                  child: const Text('提交'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: _allPages.length,
      child: new Scaffold(
        body: new NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              new SliverAppBar(
                pinned: true,
                expandedHeight: _kAppBarHeight,
                forceElevated: innerBoxIsScrolled,
                bottom: new TabBar(
                  controller: _tabController,
                  tabs: _allPages
                      .map((String label) => new Tab(text: label))
                      .toList(),
                ),
                flexibleSpace: new LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    final Size size = constraints.biggest;
                    final double appBarHeight =
                        size.height - MediaQuery.of(context).padding.top;
                    final double t = (appBarHeight - kToolbarHeight) /
                        (_kAppBarHeight - kToolbarHeight);
                    final double extraPadding =
                        new Tween<double>(begin: 10.0, end: 24.0).lerp(t);
                    final double logoHeight = appBarHeight - 1.5 * extraPadding;
                    return new Padding(
                      padding: new EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top +
                            0.5 * extraPadding,
                        bottom: extraPadding,
                      ),
                      child: new Center(
                          child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Text('尊敬的xx', style: const TextStyle(color: Colors.white),),
                          new Text('您的身份证号:130******2252', style: const TextStyle(color: Colors.white),),
                        ],
                      )),
                    );
                  },
                ),
              ),
            ];
          },
          body: new TabBarView(
            controller: _tabController,
            children: <Widget>[
              _personInfoPage(),
              _jobInfoPage(),
              _contactInfoPage(),
            ],
//            children: _allPages.keys.map((_Page page) {
//              return new ListView(
//                padding:
//                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//                itemExtent: _CardDataItem.height,
//                children: _allPages[page].map((_CardData data) {
//                  return new Padding(
//                    padding: const EdgeInsets.symmetric(vertical: 8.0),
//                    child: new _CardDataItem(page: page, data: data),
//                  );
//                }).toList(),
//              );
//            }).toList(),
          ),
        ),
      ),
    );
  }
}
