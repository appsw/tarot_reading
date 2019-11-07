import 'package:flutter/material.dart';
import 'package:tarot_reading/utils/DefaultValue.dart';

import 'AnswerCardPage.dart';

class ChoseCardPage extends StatefulWidget {
  @override
  _ChoseCardPageState createState() => _ChoseCardPageState();
}

class _ChoseCardPageState extends State<ChoseCardPage> with TickerProviderStateMixin{
  AnimationController controller;//动画控制器
  CurvedAnimation curved;//曲线动画，动画插值，
  bool forward = false;
  bool allForward = false;
  List imgs = ["assets/images/page05_card_1.png","assets/images/page05_card_2.png","assets/images/page05_card_3.png",
  "assets/images/page05_card_4.png","assets/images/page05_card_5.png","assets/images/page05_card_6.png",
  "assets/images/page05_card_7.png","assets/images/page05_card_8.png","assets/images/page05_card_9.png",
  "assets/images/page05_card_10.png","assets/images/page05_card_11.png","assets/images/page05_card_12.png",
  "assets/images/page05_card_13.png","assets/images/page05_card_14.png","assets/images/page05_card_15.png",
  "assets/images/page05_card_16.png","assets/images/page05_card_17.png","assets/images/page05_card_18.png",
  "assets/images/page05_card_19.png","assets/images/page05_card_20.png","assets/images/page05_card_21.png",
  "assets/images/page05_card_22.png",];
  ScrollController _scrollController = ScrollController();
  var cilckNumber = -1;
  @override
  void initState() {//初始化，当当前widget被插入到树中时调用
    super.initState();
    controller = new AnimationController(
        vsync: this, duration: const Duration(seconds: 3));
    curved = new CurvedAnimation(parent: controller, curve: Curves.easeIn)
    ..addStatusListener((AnimationStatus status) {
      print(status);
      if (status == AnimationStatus.completed || status == AnimationStatus.dismissed) {
        if(allForward){
          setState(() {
            allForward = false;
          });
        }else{
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AnswerCardPage()));
        }

      }
    });
//    controller.forward();//放在这里开启动画 ，打开页面就播放动画
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
          getAppBar(),
          Container(
            height: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Image.asset("assets/images/card06_icon.png",height: 60,),
                Text("请集中精力选择一张牌",
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
            margin: EdgeInsets.only(top: DefaultValue.topMargin,bottom: DefaultValue.bottomMargin,left: DefaultValue.leftMargin,right: DefaultValue.rightMargin),
            child: GridView.count(
              crossAxisCount: 6,
              //主轴间隔
              mainAxisSpacing: 1.0,
              //横轴间隔
              crossAxisSpacing: 1.0,
              childAspectRatio: 0.5,
              controller:  _scrollController,
              shrinkWrap: true,
              children: List.generate(imgs.length, (index){
                return getImageItem(index);
              }),
            ),
          ),
        ],
      ),
    );
  }
  Widget getImageItem(int index){
    return GestureDetector(
      child: allForward ? getTurn() : cilckNumber == index ? getTurn() : Image.asset("assets/images/page05_card_back.png",fit: BoxFit.fitWidth),
      onTap: (){
//        _selectedImage(index);
      setState(() {
        cilckNumber = index;
        controller.forward();
      });
      },
    );
  }
  Widget getTurn(){
    return RotationTransition(//旋转动画
      turns: curved,
      child: GestureDetector(
        child: Image.asset("assets/images/page05_card_back.png"),
        onTap: (){
          if (forward)
            controller.forward();//向前播放动画
          else
            controller.reverse();//向后播放动画
          forward = !forward;
        },
      ),
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
          GestureDetector(
            child: Image.asset("assets/images/btn_reset_off.png",height: 30,),
            onTap: (){
              setState(() {
                allForward = true;
                if (forward)
                  controller.forward();//向前播放动画
                else
                  controller.reverse();//向后播放动画
                forward = !forward;

              });
            },
          ),
        ],
      ),
    );
  }
}
