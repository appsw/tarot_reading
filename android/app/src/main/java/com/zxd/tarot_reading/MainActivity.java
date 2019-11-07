package com.zxd.tarot_reading;

import android.Manifest;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.provider.Settings;
import android.util.Log;

import androidx.core.app.ActivityCompat;
import androidx.core.app.NotificationCompat;
import androidx.core.content.FileProvider;


import java.io.File;

import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;


public class MainActivity extends FlutterActivity {
  private NotificationCompat.Builder builder;
  private String path;
  private boolean isQuestPerssion = false;
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    MethodChannel channel = new MethodChannel(getFlutterView(), "com.zxd.tarot_reading");
    //在android端的MethodChannel设置MethodHandler，去处理Flutter申请要调用的method的值。
    channel.setMethodCallHandler(new MethodChannel.MethodCallHandler() {
        @Override
        public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
          switch (methodCall.method) {
            case "install":
              path = (String) methodCall.argument("path");
//              install(new File(path));
              Log.e("path===",path);
              Log.e("SDK",Build.VERSION.SDK_INT + "");
              chenckIntallPermission();
              break;
          }
        }
      });
  }

  @Override
  protected void onResume() {
    super.onResume();
    if (isQuestPerssion){
      isQuestPerssion = false;
      chenckIntallPermission();
    }
  }

  private void chenckIntallPermission(){
    if (Build.VERSION.SDK_INT >= 26) {
      boolean isRequested = getPackageManager().canRequestPackageInstalls();
      Log.e("Permission",isRequested + "");
      if (isRequested) {
        install();
      } else {
        getIntallApkPermission();
      }
    } else {
      install();
    }
  }

  private void getIntallApkPermission(){
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
//      requestPermissions(new String[]{Manifest.permission.REQUEST_INSTALL_PACKAGES},1);
      //请求安装未知应用来源的权限
      ActivityCompat.requestPermissions(this, new String[]{Manifest.permission.REQUEST_INSTALL_PACKAGES},1);
    }else {
      install();
    }
  }

  @Override
  public void onRequestPermissionsResult(int requestCode, String[] permissions, int[] grantResults) {
    super.onRequestPermissionsResult(requestCode, permissions, grantResults);
    Log.e("requestCode",requestCode + "");
    Log.e("grantResults[0] ",grantResults[0]  + "");
    if (requestCode == 1){
      if (grantResults[0] == PackageManager.PERMISSION_GRANTED){
        install();
      }else {
        isQuestPerssion = true;
        //  引导用户手动开启安装权限
        Intent intent = new Intent(Settings.ACTION_MANAGE_UNKNOWN_APP_SOURCES);
        intent.setData(Uri.parse("package:" + getPackageName()));
        startActivityForResult(intent, 1);

      }
    }
  }
    private void install(){
      File apkFile = new File(path);
    if (Build.VERSION.SDK_INT>=24){

      Uri apkUri = FileProvider.getUriForFile(getBaseContext(), getBaseContext().getPackageName()+".flutter_downloader.provider", apkFile);
      Intent install = new Intent(Intent.ACTION_VIEW);
      install.addCategory(Intent.CATEGORY_DEFAULT);
      install.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
      install.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
      install.setDataAndType(apkUri, "application/vnd.android.package-archive");

//      PendingIntent pendingIntent
//              = PendingIntent.getActivity(MainActivity.this, 0, install, PendingIntent.FLAG_UPDATE_CURRENT);
//      builder.setContentIntent(pendingIntent);
//      builder.setAutoCancel(true);
//            manager.notify(0, builder.build());

      startActivity(install);
    } else {
      Intent intent = new Intent();
      intent.setAction(Intent.ACTION_VIEW);
      intent.addCategory(Intent.CATEGORY_DEFAULT);
      intent.setType("application/vnd.android.package-archive");
      intent.setData(Uri.fromFile(apkFile));
      intent.setDataAndType(Uri.fromFile(apkFile), "application/vnd.android.package-archive");
      intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);

//      PendingIntent pendingIntent
//              = PendingIntent.getActivity(MainActivity.this, 0, intent, PendingIntent.FLAG_UPDATE_CURRENT);
//      builder.setContentIntent(pendingIntent);
//      builder.setAutoCancel(true);
//            manager.notify(0, builder.build());
      startActivity(intent);
    }
  }

  @Override
  protected void onActivityResult(int requestCode, int resultCode, Intent data) {
    super.onActivityResult(requestCode, resultCode, data);
    if (requestCode == 1 && resultCode == RESULT_OK){
      install();
    }
  }
}
