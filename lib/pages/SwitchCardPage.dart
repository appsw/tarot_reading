import 'package:flutter/material.dart';
import 'package:tarot_reading/utils/DefaultValue.dart';
import 'package:tarot_reading/utils/ToastUtil.dart';

import 'ChoseCardPage.dart';

class SwitchCardPage extends StatefulWidget {
  @override
  _SwitchCardPageState createState() => _SwitchCardPageState();
}

class _SwitchCardPageState extends State<SwitchCardPage>  with TickerProviderStateMixin{
  AnimationController controller;//动画控制器
  bool forward = true;
  Animation<EdgeInsets> movement;
  AnimationController controller1;//动画控制器
  bool forward1 = false;
  Animation<EdgeInsets> movement1;
  bool forward2 = true;

  @override
  void initState() {//初始化，当当前widget被插入到树中时调用
    super.initState();
    controller = new AnimationController(
        vsync: this, duration: const Duration(seconds: 1));
    movement = EdgeInsetsTween(
      begin: EdgeInsets.only(top: 190.0),
      end: EdgeInsets.only(top: 0),
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.1,
          0.5,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((AnimationStatus status) {
        print(status);
        if (status == AnimationStatus.completed) {
          controller1.forward();
        } else if (status == AnimationStatus.dismissed) {
          controller1.reverse();//向后播放动画
        }
      });
    controller1 = new AnimationController(
        vsync: this, duration: const Duration(seconds: 1));
    movement1 = EdgeInsetsTween(
      begin: EdgeInsets.only(top: 190.0),
      end: EdgeInsets.only(top: 380),
    ).animate(
      CurvedAnimation(
        parent: controller1,
        curve: Interval(
          0.1,
          0.5,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((AnimationStatus status) {
        print(status);
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
//          ToastUtil.makeToast("洗牌完成");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChoseCardPage()));
        }
      });

  }
//  Transform.translate(offset: Offset(100.0 * curve.value, 0.0), child: FlutterLogo(size: 100.0))
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
          getAppBar(),
          Container(
            height: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Image.asset("assets/images/card14_icon.png",height: 60,),
                Text("请集中精力想自己想要问的问题",
                style: TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  fontSize: DefaultValue.textSize
                ),),
              ],
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(top: DefaultValue.topMargin,bottom: DefaultValue.bottomMargin),
            child: Stack(
              children: <Widget>[
                Container(
                  height: 500,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset("assets/images/page05_card1_back.png",width: 200,),
                    ],
                  ),
                ),
                Container(
                  child: Image.asset("assets/images/page05_card1_back.png",width: 200,),
                  margin: movement.value,
                ),
                Container(
                  child: Image.asset("assets/images/page05_card1_back.png",width: 200,),
                  margin: movement1.value,
                )
              ],
            ),
          ),
          GestureDetector(
            child: Image.asset("assets/images/btn_reset_off.png",height: 80,),
            onTap: (){
              if(forward2){
                forward2 = false;
                controller.forward();//放在这里开启动画 ，打开页面就播放动画
              }
            },
          ),
        ],
      )
    );
  }
  Widget getAppBar(){
    return Container(
      height: 80,
      color: Colors.transparent,
      padding: EdgeInsets.only(left: 12,right: 12,top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            child: Image.asset("assets/images/btn_back_on.png",height: 30,),
            onTap: (){
              Navigator.of(context).pop();
            },
          ),

        ],
      ),
    );
  }
}
