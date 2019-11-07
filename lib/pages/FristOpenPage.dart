import 'package:flutter/material.dart';
import 'package:tarot_reading/utils/DefaultValue.dart';

class FristOpenPage extends StatefulWidget {
  @override
  _FristOpenPageState createState() => _FristOpenPageState();
}

class _FristOpenPageState extends State<FristOpenPage> {
  var Texts = ["欢迎来到塔罗牌世界","塔罗占卜\n将由多位塔罗名家\n联合提供优质服务","占卜塔罗的时候\n请一定要最诚挚的心对待哦",
  "希望您能在\塔罗占卜世界治愈内心","开始吧",];
  var Images = ["assets/images/page02_01.png","assets/images/page02_02.png","assets/images/page02_03.png",
  "assets/images/page02_04.png","assets/images/page02_05.png"];
  int _count = 0;
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
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Image.asset("assets/images/tarot_card.png",width: 100,),
                  Image.asset("assets/images/page02_icon01.png",width: 100,)
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 80),
                child: Image.asset("assets/images/page07_img04.png",height: 30,color: Colors.white,),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(Texts[_count],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: DefaultValue.bigTextSize,
                        decoration: TextDecoration.none
                    ),),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: Image.asset(Images[_count],width: 180,),
              )
            ],
          ),
          GestureDetector(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.transparent,
            ),
            onTap: (){
              setState(() {
                if(_count < 4){
                  _count ++;
                }else{
                  Navigator.pop(context);
                }
              });
            },
          ),
        ],
      )
    );
  }
}
