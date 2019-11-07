import 'package:flutter/material.dart';
import 'package:tarot_reading/utils/DefaultValue.dart';

class CardDetailedDialog extends Dialog{
  Map<String,dynamic> _data;
  String _img;
  CardDetailedDialog(this._data,this._img);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      type:  MaterialType.transparency, //透明类型
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new SizedBox(
              child: Container(
                //设置背景图片
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                      image: new AssetImage("assets/images/girl_text_bg.png"),
                      fit: BoxFit.fill
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(top: DefaultValue.topMargin,bottom: DefaultValue.bottomMargin,left: DefaultValue.leftMargin,right: DefaultValue.rightMargin),
                    child: Column(
                      children: <Widget>[
                        Text("牌面释意",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: DefaultValue.titleTextSize,
                            decoration: TextDecoration.none,
                          ),),
                        Container(
                          padding: EdgeInsets.only(top: 20,bottom: 20),
                          child: Image.asset("assets/images/page07_img04.png",height: 20,),
                        ),
                        Image.asset(_img,width: 160,),
                        Container(
                          margin: EdgeInsets.only(top: DefaultValue.topMargin,bottom: DefaultValue.bottomMargin),
                          child: Text("${_data["name"]}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: DefaultValue.titleTextSize,
                              decoration: TextDecoration.none,
                            ),),
                        ),
                        Text("${_data["mean"]}",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: DefaultValue.textSize,
                            decoration: TextDecoration.none,
                          ),),
                        Container(
                          margin: EdgeInsets.only(top: DefaultValue.topMargin,bottom: DefaultValue.bottomMargin),
                          child: Text("正位释义",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: DefaultValue.titleTextSize,
                              decoration: TextDecoration.none,
                            ),),
                        ),
                        Text("${_data["front"]}",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: DefaultValue.textSize,
                            decoration: TextDecoration.none,
                          ),),
                        Container(
                          margin: EdgeInsets.only(top: DefaultValue.topMargin,bottom: DefaultValue.bottomMargin),
                          child: Text("逆位释义",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: DefaultValue.titleTextSize,
                              decoration: TextDecoration.none,
                            ),),
                        ),
                        Text("${_data["back"]}",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: DefaultValue.textSize,
                            decoration: TextDecoration.none,
                          ),),
                      ],
                    ),
                  ),

                ),
              ),
            ),
            GestureDetector(
              child: Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: DefaultValue.leftMargin),
                margin: EdgeInsets.only(top: 20),
                child: Image.asset("assets/images/btn_close_on.png",width: 60,),
              ),
              onTap: (){
                dismissLoadingDialog(context);
              },
            ),
          ],
        )
      ),
    );
  }
  static void showLoadingDialog(BuildContext context,Map<String,dynamic> _data,String _img){
    showDialog(context: context,
        barrierDismissible: false,
        builder:(context){
          return new CardDetailedDialog(_data,_img);
        } );
  }
  static void dismissLoadingDialog(BuildContext context){
    Navigator.of(context).pop();
  }
}