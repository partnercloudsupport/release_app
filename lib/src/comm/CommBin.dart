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
  String cities= '';
  String compAdd='';
  String compPhone='';

  Jobinfo(this.job, this.monIncome, this.compName, this.cities, this.compAdd, this.compPhone);
}
 