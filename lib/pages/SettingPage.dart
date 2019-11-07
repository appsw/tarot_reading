import 'package:flutter/material.dart';
import 'package:tarot_reading/utils/DefaultValue.dart';
import 'package:tarot_reading/utils/NavigatorUtils.dart';

import 'FristOpenPage.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(left: DefaultValue.leftMargin),
              margin: EdgeInsets.only(top: 40),
              child: Image.asset("assets/images/btn_close_on.png",width: 40,),
            ),
            onTap: (){
              Navigator.pop(context);
            },
          ),
          Image.asset("assets/images/page01_bi.png",width: 300,),
          Container(
            margin: EdgeInsets.only(top: 80),
            height: 50,
            alignment: Alignment.centerLeft,
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              GestureDetector(
                child: Container(
                  width: 260,
                  height: 40,
                  color: Colors.transparent,
                  margin: EdgeInsets.only(left: 60),
                  alignment: Alignment.centerLeft,
                  child: Text("关于塔罗牌",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: DefaultValue.titleTextSize,
                      decoration: TextDecoration.none,
                    ),),
                ),
                onTap: (){
                  NavigatorUtils.push(context, new FristOpenPage());
                },
              ),
              Image.asset("assets/images/line_2.png",width: 260,),
            ],
            )
          ),

        ],
      ),
    );
  }
}
