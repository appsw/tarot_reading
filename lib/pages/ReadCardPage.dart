import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tarot_reading/dialog/CardDetailedDialog.dart';
import 'package:tarot_reading/utils/DefaultValue.dart';
import 'package:tarot_reading/utils/NavigatorUtils.dart';

import 'HomePage.dart';

class ReadCardPage extends StatefulWidget {
  Map<String,dynamic> _data;
  String _img;
  bool _isChange;
  ReadCardPage(this._data,this._img,this._isChange);
  @override
  _ReadCardPageState createState() => _ReadCardPageState();
}

class _ReadCardPageState extends State<ReadCardPage> {
  String _text;
  @override
  Widget build(BuildContext context) {
    if(widget._isChange){
      _text = "${widget._data["back"]}";
    }else{
      _text = "${widget._data["front"]}";
    }

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
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(left: DefaultValue.leftMargin),
              margin: EdgeInsets.only(top: 40),
              child: Image.asset("assets/images/btn_close_on.png",width: 40,),
            ),
            onTap: (){
              NavigatorUtils.pushAndRemoveUntil(context, new HomePage());
            },
          ),
          Image.asset("assets/images/moon_icon2.png",width: 80,),
          Image.asset("assets/images/desert_icon.png",height: 40,),
          Expanded(
            flex: 1,
            child: Container(
              //设置背景图片
              decoration: new BoxDecoration(
                image: new DecorationImage(
                    image: new AssetImage("assets/images/result_text_bg.png"),
                    fit: BoxFit.fill
                ),
              ),
              margin: EdgeInsets.only(left: DefaultValue.leftMargin,right: DefaultValue.rightMargin),
              child: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(top: 40),
                  child: Column(
                    children: <Widget>[
                      Text("解读塔罗牌",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: DefaultValue.titleTextSize,
                        decoration: TextDecoration.none,
                      ),),
                      Container(
                        padding: EdgeInsets.only(top: 20,bottom: 20),
                        child: Image.asset("assets/images/page07_img04.png",height: 20,),
                      ),
                      Text("您抽中了\"${widget._data["name"]}\"牌。",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: DefaultValue.textSize,
                          decoration: TextDecoration.none,
                        ),),
                      Container(
                        padding: EdgeInsets.only(top: 20,bottom: 20),
                        child: Transform.rotate(
                          //旋转90度
                          angle:  widget._isChange ? pi : 0,
                          child: Container(
                            child: Image.asset(widget._img,width: 160,),
                          ),
                        ),
                      ),
                      GestureDetector(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 20),
                          height: 40.0,
                          width: 300.0,
                          decoration: new BoxDecoration(
                              border: new Border.all(width: 1.0,color:Colors.black ),
                              color: Colors.transparent,
                              borderRadius:  new BorderRadius.all(Radius.circular(20.0))
                          ),
                          child: Text("牌面释意",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: DefaultValue.titleTextSize,
                                decoration: TextDecoration.none
                            ),),
                          alignment: Alignment.center,
                        ),
                        onTap: (){
                          CardDetailedDialog.showLoadingDialog(context, widget._data, widget._img);
                        },
                      ),
                      Text("塔罗结果",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: DefaultValue.titleTextSize,
                          decoration: TextDecoration.none,
                        ),),
                      Container(
                        padding: EdgeInsets.only(top: 20,bottom: 20),
                        child: Image.asset("assets/images/page07_img04.png",height: 20,),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: DefaultValue.topMargin,bottom: DefaultValue.bottomMargin,left: DefaultValue.leftMargin,right: DefaultValue.rightMargin),
                        child: Text(_text,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: DefaultValue.textSize,
                            decoration: TextDecoration.none,
                          ),),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
