import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebaseui/firebaseui.dart';
import 'package:flutter/material.dart';

/**
 * Created by zgx on 2017/5/24.
 */
class UserData {
  String phoneno = '';
  String password = '';
  String confirmpassword = '';

  UserData(this.phoneno, this.password, this.confirmpassword);
}

class Message {
  String title = '';
  String body = '';
  String time = '';
  AnimationController animationController;

  Message(this.title, this.body, this.time, this.animationController);
}

class Jobinfo {
  String job = '';
  String monIncome = '';
  String compName = '';
  String cities = '';
  String compAdd = '';
  String compPhone = '';

  Jobinfo(this.job, this.monIncome, this.compName, this.cities, this.compAdd,
      this.compPhone);
}

class Contacts {
  String type1 = '';
  String phoneNo1 = '';
  String type2 = '';
  String phoneNo2 = '';

  Contacts(this.type1, this.phoneNo1, this.type2, this.phoneNo2);
}

class BankCard {
  String openBank = '';
  String opencity = '';
  String phoneNo = '';
  String cardNo = '';

  BankCard(this.openBank, this.opencity, this.phoneNo, this.cardNo);
}

UiFirebaseUser currentUser;
Future<UiFirebaseUser> getFirebaseUser() async{
  print('获取用户:${currentUser==null}');
  if(currentUser==null){
     await Firebaseui.currentUser.then((user){
       if(user!=null){
         currentUser = user;
       }
       return currentUser;
     }).catchError((e){print('获取用户出错了${e}'); return null;});
  }
  return currentUser;
}

final DatabaseReference _rootRef = FirebaseDatabase.instance.reference();
final FirebaseMessaging firebaseMessaging = new FirebaseMessaging();

/**
 * 保存推送token的状态,退出登录后将不会收到推送的消息
 */
saveToken(bool islogin) async{
  String token = await firebaseMessaging.getToken();
  if(token==null){
    return;
  }
  String uid;
  if (currentUser!=null){
    uid = currentUser.uid;
  }else {
    await getFirebaseUser().then((user) {
      if (user == null) {
        return;
      }
      uid = user.uid;
    });
  }

  await _rootRef.child('notificationTokens/${uid}').set({
    '${token}': islogin, //token
  });
}

clearUser() {
  currentUser = null;
  print('清理成功: ${currentUser==null}');
}

configMessage(context) async{
  print('注册通知');
//  firebaseMessaging.configure(
//    onMessage: (Map<String, dynamic> message) {
//      print("onMessage: $message");
//      print(message);
//      //我的页面显示红色提醒，点击后红色消失,待添加处理
////        _showItemDialog(message);
//    },
//    onLaunch: (Map<String, dynamic> message) {
//      print("onLaunch: $message");
//      Navigator.of(context).pushNamed('/borrowRecord');
////        _navigateToItemDetail(message);
//    },
//    onResume: (Map<String, dynamic> message) {
//      print("onResume: $message");
//      Navigator.of(context).pushNamed('/borrowRecord');
////        _navigateToItemDetail(message);
//    },
//  );
  firebaseMessaging.getToken().then((token){print(token);});
}