import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:tarot_reading/utils/Constant.dart';
import 'package:tarot_reading/utils/NavigatorUtils.dart';
import 'package:tarot_reading/utils/SharedPreferencesUtil.dart';
import 'package:tarot_reading/utils/ToastUtil.dart';

import 'ChoseCardPage.dart';
import 'FristOpenPage.dart';
import 'SettingPage.dart';
import 'SwitchCardPage.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _banner = [
    "assets/images/maincard01_01.png",
    "assets/images/maincard02_01.png",
    "assets/images/maincard03_01.png",
    "assets/images/maincard04_01.png",
    "assets/images/maincard05_01.png",
    "assets/images/maincard06_01.png",
    "assets/images/maincard07_01.png",
    "assets/images/maincard08_01.png",
    "assets/images/maincard09_01.png",
    "assets/images/maincard10_01.png",
    "assets/images/maincard11_01.png",
    "assets/images/maincard12_01.png",
    "assets/images/maincard13_01.png"
  ];
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
          Container(
            padding: EdgeInsets.only(top: 80),
            child: Image.asset("assets/images/page07_img04.png",height: 30,color: Colors.white,),
          ),
          Container(
            padding: EdgeInsets.only(top: 12),
            child: Text("请确定您想了解的主题",
            style: TextStyle(
              fontSize: 18,
              decoration: TextDecoration.none,
              color: Colors.deepPurpleAccent
            ),),
          ),
          Expanded(
            flex: 1,
            child: getSwiperBody(),
          ),
          Container(
            child: Stack(
              children: <Widget>[
                Image.asset("assets/images/bg_wave.png",fit: BoxFit.fill,width: MediaQuery.of(context).size.width,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    child: Image.asset("assets/images/page03_btn03.png",width: 50),
                    onTap: (){
                      NavigatorUtils.push(context, new SettingPage());
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget getSwiperBody(){
    return Container(
      width: MediaQuery.of(context).size.width,
//        height: 400.0,
      alignment: Alignment.center,
      child: Swiper(
        itemBuilder: _swiperBuilder,
        itemCount: _banner.length,
        pagination: null,
        control: null,
        scrollDirection: Axis.horizontal,
        autoplay: true,
        onTap: goBountyTask,

        viewportFraction: 0.6,
        scale: 0.8,
      ),
      margin: EdgeInsets.only(top: 40.0,bottom: 40.0),
    );
  }
  Widget _swiperBuilder(BuildContext context, int index){

    return Image.asset(_banner[index],
      width: 180.0,
      height: 400.0,
      fit: BoxFit.contain,);
  }
  void goBountyTask(int index){

    Navigator
        .of(context)
        .push(new MaterialPageRoute(builder:  (context) => new SwitchCardPage()));
    if(index == 4){
//      Navigator
//          .of(context)
//          .push(new MaterialPageRoute(builder:  (context) => new BountyTaskPage()));
    }else{
//      ToastUtil.makeToast("敬请期待");
    }

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkIsFristOpen(context);
  }
  void checkIsFristOpen(BuildContext context){
    SharedPreferencesUtil.getString(Constant.ISFRISTOPEN).then((s){
      if (s == null  || s != "1"){
        SharedPreferencesUtil.saveString(Constant.ISFRISTOPEN, "1", (bool result){
          if(result){
            NavigatorUtils.push(context, new FristOpenPage());
          }
        });
      }
    });
  }
}
