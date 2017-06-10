// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:release_app/src/components/singlePage/Approve.dart';
import 'package:release_app/src/components/singlePage/BorrowHome.dart';
import 'package:release_app/src/components/singlePage/UserCenter.dart';

class NavigationIconView {
  NavigationIconView({
    Widget icon,
    Widget title,
    Color color,
    Widget screen,
    TickerProvider vsync,
  })
      : _icon = icon,
        _color = color,
        _screen = screen,
        item = new BottomNavigationBarItem(
          icon: icon,
          title: title,
          backgroundColor: color,
        ),
        controller = new AnimationController(
          duration: kThemeAnimationDuration,
          vsync: vsync,
        ) {
    _animation = new CurvedAnimation(
      parent: controller,
      curve: const Interval(0.2, 0.5, curve: Curves.fastOutSlowIn),
    );
  }

  final Widget _icon;
  final Color _color;
  final Widget _screen;
  final BottomNavigationBarItem item;
  final AnimationController controller;
  CurvedAnimation _animation;

  FadeTransition transition(
      BottomNavigationBarType type, Widget screen, BuildContext context) {
    Color iconColor;
    if (type == BottomNavigationBarType.shifting) {
      iconColor = _color;
    } else {
      final ThemeData themeData = Theme.of(context);
      iconColor = themeData.brightness == Brightness.light
          ? themeData.primaryColor
          : themeData.accentColor;
    }

    return new FadeTransition(
      opacity: _animation,
      child: new SlideTransition(
        position: new FractionalOffsetTween(
          begin:
              const FractionalOffset(0.0, 0.02), // Small offset from the top.
          end: FractionalOffset.topLeft,
        )
            .animate(_animation),
        child: screen,
//        child: new IconTheme(
//          data: new IconThemeData(
//            color: iconColor,
//            size: 120.0,
//          ),
//          child: _icon,
//        ),
      ),
    );
  }
}

class CustomIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);
    return new Container(
      margin: const EdgeInsets.all(4.0),
      width: iconTheme.size - 8.0,
      height: iconTheme.size - 8.0,
      color: iconTheme.color,
    );
  }
}

class BottomNavigationHome extends StatefulWidget {
  static const String routeName = '/material/bottom_navigation';

  @override
  _BottomNavigationHomeState createState() => new _BottomNavigationHomeState();
}

class _BottomNavigationHomeState extends State<BottomNavigationHome>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  BottomNavigationBarType _type = BottomNavigationBarType.shifting;
  List<NavigationIconView> _navigationViews;

  @override
  void initState() {
    super.initState();
    _navigationViews = <NavigationIconView>[
      new NavigationIconView(
        icon: const Icon(Icons.cloud),
        title: const Text('借钱'),
        color: Colors.teal,
        vsync: this,
      ),
      new NavigationIconView(
        icon: const Icon(Icons.favorite),
        title: const Text('认证'),
        color: Colors.indigo,
        vsync: this,
      ),
      new NavigationIconView(
        icon: const Icon(Icons.event_available),
        title: const Text('我的'),
        color: Colors.pink,
        vsync: this,
      )
    ];

    for (NavigationIconView view in _navigationViews)
      view.controller.addListener(_rebuild);

    _navigationViews[_currentIndex].controller.value = 1.0;
  }

  @override
  void dispose() {
    for (NavigationIconView view in _navigationViews) view.controller.dispose();
    super.dispose();
  }

  void _rebuild() {
    setState(() {
      // Rebuild in order to animate views.
    });
  }

  Widget _buildTransitionsStack() {
    final List<FadeTransition> transitions = <FadeTransition>[];
    final List<Widget> screenListe = [
      new BorrowHome(title: '借钱'),
      new Approve(),
      new UserCenter(),
    ];

//    for (NavigationIconView view in _navigationViews) {
//    }

    for (var i = 0; i < _navigationViews.length; ++i) {
      NavigationIconView view = _navigationViews[i];
      transitions.add(view.transition(_type, screenListe[i], context));
    }

    // We want to have the newly animating (fading in) views on top.
    transitions.sort((FadeTransition a, FadeTransition b) {
      final Animation<double> aAnimation = a.listenable;
      final Animation<double> bAnimation = b.listenable;
      final double aValue = aAnimation.value;
      final double bValue = bAnimation.value;
      return aValue.compareTo(bValue);
    });

    return new Stack(children: transitions);
  }

  @override
  Widget build(BuildContext context) {
    final BottomNavigationBar botNavBar = new BottomNavigationBar(
      items: _navigationViews
          .map((NavigationIconView navigationView) => navigationView.item)
          .toList(),
      currentIndex: _currentIndex,
      type: _type,
      onTap: (int index) {
        setState(() {
          _navigationViews[_currentIndex].controller.reverse();
          _currentIndex = index;
          _navigationViews[_currentIndex].controller.forward();
        });
      },
    );

    final CupertinoTabBar iosTabbar = new CupertinoTabBar(
      items: _navigationViews
          .map((NavigationIconView navigationView) => navigationView.item)
          .toList(),
      currentIndex: _currentIndex,
      onTap: (int index) {
        setState(() {
          _navigationViews[_currentIndex].controller.reverse();
          _currentIndex = index;
          _navigationViews[_currentIndex].controller.forward();
        });
      },
    );

    return new Scaffold(
//      appBar: new AppBar(),
//      appBar: new AppBar(
//        title: const Text('Bottom navigation'),
//        actions: <Widget>[
//          new PopupMenuButton<BottomNavigationBarType>(
//            onSelected: (BottomNavigationBarType value) {
//              setState(() {
//                _type = value;
//              });
//            },
//            itemBuilder: (BuildContext context) => <PopupMenuItem<BottomNavigationBarType>>[
//              const PopupMenuItem<BottomNavigationBarType>(
//                value: BottomNavigationBarType.fixed,
//                child: const Text('Fixed'),
//              ),
//              const PopupMenuItem<BottomNavigationBarType>(
//                value: BottomNavigationBarType.shifting,
//                child: const Text('Shifting'),
//              )
//            ],
//          )
//        ],
//      ),
      body: new Center(child: _buildTransitionsStack()),
      bottomNavigationBar: defaultTargetPlatform ==
          TargetPlatform.iOS?iosTabbar:botNavBar,
    );
  }
}
