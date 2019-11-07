import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tarot_reading/utils/DefaultValue.dart';
import 'package:tarot_reading/utils/NavigatorUtils.dart';

import 'HomePage.dart';
import 'ReadCardPage.dart';

class AnswerCardPage extends StatefulWidget {
  @override
  _AnswerCardPageState createState() => _AnswerCardPageState();
}

class _AnswerCardPageState extends State<AnswerCardPage> {
  List imgs = ["assets/images/page06_card_1.png","assets/images/page06_card_2.png","assets/images/page06_card_3.png",
  "assets/images/page06_card_4.png","assets/images/page06_card_5.png","assets/images/page06_card_6.png",
  "assets/images/page06_card_7.png","assets/images/page06_card_8.png","assets/images/page06_card_9.png",
  "assets/images/page06_card_10.png","assets/images/page06_card_11.png","assets/images/page06_card_12.png",
  "assets/images/page06_card_13.png","assets/images/page06_card_14.png","assets/images/page06_card_15.png",
  "assets/images/page06_card_16.png","assets/images/page06_card_17.png","assets/images/page06_card_18.png",
  "assets/images/page06_card_19.png","assets/images/page06_card_20.png","assets/images/page06_card_21.png",
  "assets/images/page06_card_22.png",];
  var _cardNumner = 0;
  var _isChange = false;
  List _data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cardNumner = Random().nextInt(21);
    _isChange = Random().nextBool();
    rootBundle.loadString('assets/data/mean.json').then((v) {
      _data = json.decode(v);
      print(_data[_cardNumner]);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      //设置背景图片
      decoration: new BoxDecoration(
        image: new DecorationImage(
            image: new AssetImage("assets/images/page02_bg.png"),
            fit: BoxFit.fill
        ),
      ),
      child: Column(
        children: <Widget>[
          GestureDetector(
            child: Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: DefaultValue.leftMargin),
              margin: EdgeInsets.only(top: 40),
              child: Image.asset("assets/images/btn_menu_on.png",width: 60,),
            ),
            onTap: (){
              NavigatorUtils.pushAndRemoveUntil(context, new HomePage());
            },
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Image.asset("assets/images/page07_img04.png",height: 30,color: Colors.white,),
          ),
          Container(
            padding: EdgeInsets.only(top: 12),
            child: Text("您选择了以下塔罗牌",
              style: TextStyle(
                  fontSize: 14,
                  decoration: TextDecoration.none,
                  color: Colors.grey
              ),),
          ),
          Container(
            padding: EdgeInsets.only(top: 4),
            child: Text("请点击查看结果",
              style: TextStyle(
                  fontSize: 14,
                  decoration: TextDecoration.none,
                  color: Colors.grey
              ),),
          ),
          Expanded(
            flex: 1,
            child: Transform.rotate(
              //旋转90度
              angle:  _isChange ? pi : 0,
              child: Container(
              child: Image.asset(imgs[_cardNumner],width: 260,),
            ),
            ),
          ),
          Container(
            child: GestureDetector(
              child: Image.asset("assets/images/btn_result_on.png",height: 80,),
              onTap: (){
                NavigatorUtils.push(context, new ReadCardPage(_data[_cardNumner],imgs[_cardNumner],_isChange));
              },
            ),
          ),
          Image.asset("assets/images/bg_wave.png",fit: BoxFit.fill,width: MediaQuery.of(context).size.width,),
        ],
      ),
    );
  }
}
