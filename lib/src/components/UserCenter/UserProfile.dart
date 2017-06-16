import 'package:firebase_database/firebase_database.dart';
import 'package:firebaseui/firebaseui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:release_app/src/comm/Colors.dart';
import 'package:release_app/src/comm/commBottomModel.dart';

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
  List<TextEditingController> _controllers = [
    new TextEditingController(),
  ];

  bool _saveNeeded = false;
  String _education = '';
  String _marriage = '';
  String _childencount = '';
  String _livetime = '';

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: _allPages.length, vsync: this);
  }

  /**
   * 文本输入框
   */
  Widget _textInputItem(
      String label, String hintText, TextInputType inputType, int i) {
    return new Container(
      color: Colors.white,
        padding: const EdgeInsets.only(left: 16.0),
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Container(
              alignment: FractionalOffset.centerLeft,
//                padding: const EdgeInsets.only(right: 16.0),
              child: new Text(label),
            ),
            flex: 1,
          ),
          new Expanded(
            flex: 3,
            child: new TextFormField(
              decoration: new InputDecoration(
                hideDivider: true,
                hintText: hintText,
              ),
              controller: _controllers[i] != null ? _controllers[i] : null,
              keyboardType: inputType,
            ),
          ),
        ],
      ),
    );
  }

  void showDemoDialog<T>({BuildContext context, int index, Widget child}) {
    showDialog<DialogItemValue>(
      context: context,
      child: child,
    ).then<Null>((DialogItemValue item) {
      // The value passed to Navigator.pop() or null.
//        print('序号:' + index.toString() + '返回数据:' + value);
      setState(() {
        if (item != null) {
          _saveNeeded = true;
          switch (index) {
            case 0:
              _education = item.key;
              break;
            case 1:
              _marriage = item.key;
              break;
            case 2:
              _childencount = item.key;
              break;
            case 3:
              _livetime = item.key;
              break;
          }
        }
      });
    });
  }

  Widget _dropdownInputItem(String label, int index) {
    return new InkWell(
      onTap: () {
        showDemoDialog<String>(
          context: context,
          index: index,
          child: index == 0
              ? new BottomModelDiolog(title: label)
              : index == 1
              ? new MarriageDiolog()
              : index == 2 ? new ChildenDiolog() : new LivetimeDiolog(),
        );
      },
      child: new Container(
        color: Colors.white,
        padding: const EdgeInsets.only(left: 16.0),
        height: 45.0,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Expanded(
              flex: 1,
              child: new Container(
                alignment: FractionalOffset.centerLeft,
                  padding: const EdgeInsets.only(right: 16.0),
                child: new Text(label),
              ),
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

  /**
   * 个人信息维护页面
   */
  Widget _personInfoPage() {
    return new Container(
      child: new Form(
        child: new ListView(
//          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          children: <Widget>[
            new Column(
                children: <Widget>[
                  _textInputItem('QQ:', '请输入QQ号码', TextInputType.number, 0),
                  new Divider(height: 1.0, indent: 16.0,),
                  _textInputItem('电子邮箱:', '请输入电子邮箱', TextInputType.text, 0),
                  new SizedBox(height: 16.0,),
                  _dropdownInputItem('学历:', 0),
                  new SizedBox(height: 16.0,),
                  _dropdownInputItem('婚姻:', 1),
                  new Divider(height: 1.0, indent: 16.0,),
                  _dropdownInputItem('子女个数:', 2),
                  new SizedBox(height: 16.0,),
                  _textInputItem('居住地址:', '', TextInputType.text, 0),
                  new Divider(height: 1.0, indent: 16.0,),
                  _dropdownInputItem('居住时长:', 3),
                ]
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
                  _dropdownInputItem('职业:', 0),
                  _dropdownInputItem('薪水范围:', 1),
                  _textInputItem('公司名称:', '', TextInputType.text, 0),
                  _textInputItem('电子邮箱:', '请输入电子邮箱', TextInputType.text, 0),
                  _dropdownInputItem('所在省市:', 2),
                  _textInputItem('详细地址:', '', TextInputType.text, 0),
                  _textInputItem('单位电话:', '', TextInputType.phone, 0),
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
                  _dropdownInputItem('亲属关系:', 0),
                  _textInputItem('联系方式:', '', TextInputType.phone, 0),
                  _dropdownInputItem('亲属关系:', 0),
                  _textInputItem('联系方式:', '', TextInputType.phone, 0),
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
                  onPressed: () {},
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
                      .map((String label) => new Tab(text: label,))
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
                          new Text(
                            '尊敬的xx',
                            style: const TextStyle(color: Colors.white),
                          ),
                          new Text(
                            '您的身份证号:130******2252',
                            style: const TextStyle(color: Colors.white),
                          ),
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
