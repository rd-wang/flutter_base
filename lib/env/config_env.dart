import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';
import 'package:roobo_logger/roobo_logger.dart';

class EnvConfig {
  // 是否为release版本
  static bool get isReleased => bool.fromEnvironment("dart.vm.product");

  // 判断网络环境
  static bool isOnline = true;

  static bool isLog = true;

  // 这个参数由服务端分配；同一个项目的android/ios使用同一个app_package_id
  static String appPackageID;

  // 这个参数由服务端分配；机构的唯一标识
  static String appID;

  // 平台信息
  static String platform = Platform.operatingSystem;

  // 设备厂商
  static String deviceModel = "";

  // 应用名称
  static String appName = "";

  // 包名
  static String appPackageName = "";

  // 应用主版本号
  static String appMajorVersion = "";

  // 应用次版本号
  static String appMinorVersion = "";

  // 系统版本号
  static String operatingSystemVersion = Platform.operatingSystemVersion;

  // dart vm 版本号
  static String platformVersion = Platform.version;

  // 语言
  static String local = Platform.localeName;

  // 渠道
  static String channel = "10000";

  // push id
  static String pushID = "123";

  // push service
  static String pushService = "pushService";

  // 网络类型
  static String net = "";

  //支持多媒体文件格式
  static List<String> logicFilesType = [
    "jpg",
    "jpeg",
    "heic",
    "png",
    "gif",
    "mp3",
    "wav",
    "mp4",
    "m4v",
    "mov",
    "qt",
    "avi",
    "flv",
    "wmv",
    "asf",
    "mkv",
    "mpeg",
    "mpg",
    "vob",
    "ts",
    "dat"
  ];

  static Future<bool> init() async {
    Map<String, dynamic> configs = json.decode(await rootBundle.loadString("res/json/id_config.json"));
    Map<String, dynamic> ids = configs["ids"];
    appPackageID = ids['com.roobo.AppPackageId'];
    appID = ids['com.roobo.AppId'];
    isOnline = ids['env'] == "online";

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appName = packageInfo.appName;
    appPackageName = packageInfo.packageName;
    appMajorVersion = packageInfo.version;
    appMinorVersion = packageInfo.buildNumber;
    if (isLog) printArg();
    return true;
  }

  static void printArg() {
    Logger.i('=============EnvConfig===============\n' +
        "是否为release版本: $isReleased\n" +
        "appPackageId: $appPackageID\n" +
        "appID: $appID\n" +
        "当前环境网络是否为正式服务器: $isOnline\n" +
        "应用运行platform: $platform\n" +
        "deviceModel: $deviceModel\n" +
        "appName: $appName\n" +
        "appPackageName: $appPackageName\n" +
        "app版本号: $appMajorVersion\n" +
        "app构建号: $appMinorVersion\n" +
        "operatingSystemVersion: $operatingSystemVersion\n" +
        "platformVersion: $platformVersion\n" +
        "local语言: $local\n" +
        "channel渠道: $channel\n" +
        "pushID: $pushID\n" +
        "pushService: $pushService\n" +
        "net类型: $net\n" +
        "多媒体格式: $logicFilesType\n");
  }
}
