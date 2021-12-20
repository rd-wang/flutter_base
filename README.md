# roobo_base

roobo基础组件库 提供开发中各种基础组件 详见api

## Getting Started

# use

请注意 调用init之前 必须先调用preinit preinit 初始化了设备相关信息，这些信息在生成 Authorization 需要使用

所以在init的时候，必须先初始化EnvConfig中的内容

1. 调用preinit 必须先于init调用
```text
    await RooboBase.preInit();
```


2.调用init 主要内容进行网络相关的设置

```text
await RooboBase.init(
  NetConfig.hostName,getAuthorization(),
  isOpenProxy(),
  {
  PROXY_IP: Preference.getString(PROXY_IP),
  PROXY_PORT: Preference.getString(PROXY_PORT),
  },
  EnvConfig.isLog,
  errorMsg: _error,
  errorHandle: _errorFunction,
  listener: _updateConnectionState,
);
/// 参数说明
/// hostName 域名
/// authorization 登录签名
/// isOpenProxy 是否开启代理, 主要用于debug包给测试抓包用
/// proxyData Map 代理的ip和端口 指定key
///             const String PROXY_IP = "debug_proxy_ip";
//              const String PROXY_PORT = "debug_proxy_port";
    {
PROXY_IP: '182.2.2.2',
PROXY_PORT: '8833',
}
/// isLog 是否输出log
/// errorMsg Map<String, String> 错误码集 错误码和提示文案
static Map<String, String> _error = {
  '-400': '服务内部错误，内部调用错误',
  '-401': '请重新登陆',
  '-406': '您没有使用权限，\n请联系机构管理员',
  '-422': '参数或者header头必要信息错误',
  '-429': '验证码请求次数过多，\n请1小时后重试',
  '-451': '验证码已失效\n请重新获取',
  '-500': '服务内部错误',
  '-100': '网络不给力，请检查网络设置或稍后重试',
};

/// errorHandle Map<String, Function> 错误码处理集 错误码和响应操作
static Map<String, Function> _errorFunction = {
  '-401': showLoginDialog,
  '-406': clearAuth,
  '-100': showMessage,
  '-100866': proxyClean,
};

```

# API

## net

1. 请求

```text
   /// data: {"id": 12, "name": "xx"},
/// options: Options(method: "GET"),
/// T data : ResponseType  ResultData
/// cancelToken
/// onSendProgress
/// onReceiveProgress
await Net.request(_PATH_USER_UPLOAD_AVATAR, options: Options(contentType: "multipart/form-data"),data: postData, cancelToken: cancelToken);
```

2. 下载

```text
 await Net.download(url, savePath, onReceiveProgress: progressCallback, cancelToken: cancelToken)；
```

3.response

```text
// 结果封装
class ResultData {
  var data;
  var headers;
  dynamic model;
  bool isSuccess;
  String msg;
  int code;

  ResultData(this.data, this.isSuccess, this.code, {this.headers, this.msg});

  @override
  String toString() {
    return ' code:$code\n msg:$msg\n data:$data\n';
  }

```

## toast

1.调用

```text
  ToastUtil.showToast("xxxxx",type: ToastType.Error);
```

```text
  ToastType { Success, Info, Error, Toast, Loading, Progress }
```

## preference

支持 string int bool 除了bool默认值为false其他默认值为null

1.存值

```text
  Preference.setString("xx",xx);

```

2.取值

```text
 Preference.getString("xx");
```

3.删除

```text
Preference.clear("xx");
```

## env

是否为release版本: isReleased   
appPackageId: appPackageID   
appID: appID   
当前环境网络是否为正式服务器: isOnline   
应用运行platform: platform   
deviceModel: deviceModel   
appName: appName   
appPackageName: appPackageName   
app版本号: appMajorVersion   
app构建号: appMinorVersion   
operatingSystemVersion: operatingSystemVersion   
platformVersion: platformVersion   
local语言: local   
channel渠道: channel   
pushID: pushID   
pushService: pushService   
net类型: net   
多媒体格式: logicFilesType

1.调用

```text
 EnvConfig.isReleased
```

## top_context  RooboContext

在baseState的didChangeDependencies()中更新RooboContext中的context 所以每当有widget渲染，context 为最新的context 在一些工具类中
如果需要context 可以如下调用

```text
 RooboContext.context
```

## BaseState

基类 原则上 使用本库的母项目需使用本库提供的state作为基类 1.BaseState 2.ResumableState

### 提供默认的UI切换

功能 | 展示 | 默认实现 |        
--|--|--                               
进入loading并发起网络请求 | buildProgressWidget()           | ProgressLoadWidget 请求错误/无网络| buildErrorWidget(
context)                                       |NetErrorWidget 空页面 | buildEmptyWidget(context);
|EmptyDataWidget 正常页面 | buildChild(context, snapshot.data, _streamController)              |无默认实现

### 统一的Appbar

onAppbarBackClick()  重写可注入额外的返回逻辑 重写需要调用 super()
getAction()          重写可实现右侧按钮区功能

### 统一的Theme设置

默认页面为roobo_theme中预置的第一个theme

### 生命周期注入

提供生命周期监听，以便注入相应操作

## LoginAuthModel

登录本地化存储




