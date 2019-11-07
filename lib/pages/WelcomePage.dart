import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tarot_reading/pages/HomePage.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'package:http/http.dart' as http;
import 'package:package_info/package_info.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tarot_reading/utils/ToastUtil.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  var bgUrl = "assets/images/page01_bg.png";
  Timer _countdownTimer;

  get downLoadUrl => "http://39.96.196.66";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
          //设置背景图片
          decoration: new BoxDecoration(
//            border: new Border.all(width: 2.0, color: Colors.red),
//            borderRadius: new BorderRadius.all(new Radius.circular(20.0)),
            image: new DecorationImage(
              image: new AssetImage(bgUrl),
              fit: BoxFit.fill
              //这里是从assets静态文件中获取的，也可以new NetworkImage(）从网络上获取
//              centerSlice: new Rect.fromLTRB(270.0, 180.0, 1360.0, 730.0),
            ),
          ),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Image.asset("assets/images/meteor.png",height: 100,),
                ),
                Expanded(
                  flex: 1,
                  child: Image.asset("assets/images/page01_img02.png",height: 200,),
                ),
              ],
            ),
            Expanded(
              flex: 1,
              child: Container(
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                      image: new AssetImage("assets/images/loading_icon.png"),
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.center
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("塔罗占卜",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                          fontWeight: FontWeight.bold
                      ),),
                    Text("Tarot Card",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.normal
                      ),),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 12,left: 12),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Image.asset("assets/images/cactus_l.png",height: 80,),
                      Expanded(
                        flex: 1,
                        child: Image.asset("assets/images/luotuo.png",height: 80,),
                      ),
                      Image.asset("assets/images/cactus_r.png",height: 80,),
                    ],
                  ),
                  Container(
                    height: 60,
                  )
                ],
              ),
              decoration: new BoxDecoration(
                image: new DecorationImage(
                    image: new AssetImage("assets/images/desert.png"),
                    fit: BoxFit.fitWidth,
                  alignment: Alignment.bottomCenter
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(Platform.isAndroid){
      //android相关代码
      checkNewVersion().then((isNeedUpdata){
        if(isNeedUpdata){
          ToastUtil.makeToast("正在更新...");
          checkPermission().then((isHavePermission){
            if(isHavePermission){
              executeDownload();
//            _installApk();
            }else{
              requestPermission().then((isOk){
                if(isOk == PermissionStatus.authorized){
                  executeDownload();
//                _installApk();
                }else{
                  ToastUtil.makeToast("请同意权限");
                }
              });
            }
          });
        }else{

          _countdownTimer = new Timer.periodic(new Duration(seconds: 3),(duration){
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePage()),(route) => route == null);
          });
        }
      });

    }else{
      //ios相关代码
      _countdownTimer = new Timer.periodic(new Duration(seconds: 3),(duration){
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage()),(route) => route == null);
      });
    }


  }
  @override
  void dispose() {
    _countdownTimer?.cancel();
    _countdownTimer = null;
    super.dispose();
  }
  //是否有权限
  Future<bool> checkPermission() async {
    bool res = await SimplePermissions.checkPermission(
        Permission.WriteExternalStorage);
    return res;
  }

  //打开权限
  Future<PermissionStatus> requestPermission() async {
    return SimplePermissions.requestPermission(Permission.WriteExternalStorage);
  }
  Future<bool> checkNewVersion() async {
    try {
      final res = await http.get(downLoadUrl + '/version.json');
      if (res.statusCode == 200) {
        final Map<String, dynamic> body = json.decode(res.body);
        if (defaultTargetPlatform == TargetPlatform.android) {
          // 获取此时版本
          final packageInfo = await PackageInfo.fromPlatform();
          final newVersion = body['android'];
          print(packageInfo.version);
          // 此处比较版本
          return (newVersion.compareTo(packageInfo.version) == 1);
        }
      }
    } catch (e) {
      return false;
    }
    return false;
  }
  // 获取安装地址
  Future<String> get _apkLocalPath async {
    final directory = await getExternalStorageDirectory();
    return directory.path;
  }
// 下载
  Future<void> executeDownload() async {
    final path = await _apkLocalPath;
    //下载
    final taskId = await FlutterDownloader.enqueue(
        url: downLoadUrl + '/taluozhanbu.apk',
        savedDir: path,
        showNotification: true,
        openFileFromNotification: true);
    FlutterDownloader.registerCallback((id, status, progress) {
      // 当下载完成时，调用安装
      if (taskId == id && status == DownloadTaskStatus.complete) {
        _installApk();
      }
    });
  }
// 安装
  Future<Null> _installApk() async {
//    FlutterDownloader.open(taskId: taskId);
    // XXXXX为项目名
    const platform = const MethodChannel("com.zxd.tarot_reading");
    try {
      final path = await _apkLocalPath;
      // 调用app地址
      await platform.invokeMethod('install', {'path': path + '/taluozhanbu.apk'});
    } on PlatformException catch (_) {}
  }

}
