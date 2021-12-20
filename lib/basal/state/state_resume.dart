import 'package:flutter/material.dart';

class Resume {
  dynamic data;
  String source;
}

abstract class ResumableState<T extends StatefulWidget> extends State<T> with WidgetsBindingObserver {
  Resume resumeData = new Resume();
  bool _isPaused = false;

  //处理LessonLifecycle 中改为resume状态时 子widget（如：倒计时widget）连续多次调用setState()方法 导致多次build() 多次调用resume()
  bool resumeHasCall = false;

  void onResume() {
  }

  void onReady() {
  }

  void onPause() {
  }

  /// 代替Navigator.push(),
  Future<T> push<T extends Object>(BuildContext context, Route<T> route, [String source]) {
    _isPaused = true;
    onPause();

    return Navigator.of(context).push(route).then((value) {
      _isPaused = false;

      resumeData.data = value;
      resumeData.source = source;

      onResume();
      return value;
    });
  }

  /// 代替showDialog,
  Future<T> showLifecycleDialog<T>({
    @required BuildContext context,
    WidgetBuilder builder,
    bool barrierDismissible = true,
    Color barrierColor,
    bool useSafeArea = true,
    bool useRootNavigator = true,
    RouteSettings routeSettings,
    @Deprecated('child-is useless please use builder') Widget child,
  }) {
    _isPaused = true;
    onPause();

    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      useSafeArea: useSafeArea,
      useRootNavigator: useRootNavigator,
      routeSettings: routeSettings,
      builder: (BuildContext context) {
        return child;
      },
    ).then((value) {
      _isPaused = false;
      resumeData.data = value;
      onResume();
      return value;
    });
  }

  /// 代替Navigator.pushNamed()
  Future<T> pushNamed<T extends Object>(BuildContext context, String routeName, {Object arguments}) {
    _isPaused = true;
    onPause();

    return Navigator.of(context).pushNamed<T>(routeName, arguments: arguments).then((value) {
      _isPaused = false;

      resumeData.data = value;
      resumeData.source = routeName;

      onResume();
      return value;
    });
  }

  @override
  void initState() {
    super.initState();
    resumeHasCall = true;
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) => onReady());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      if (!_isPaused) {
        onPause();
      }
    } else if (state == AppLifecycleState.resumed) {
      if (!_isPaused) {
        onResume();
      }
    }
  }
}
