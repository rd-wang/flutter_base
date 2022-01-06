import 'dart:async';

import 'package:flutter/material.dart';
import 'package:roobo_base/basal/state/state_resume.dart';
import 'package:roobo_base/basal/widget/widget_empty_data.dart';
import 'package:roobo_base/basal/widget/widget_net_error.dart';
import 'package:roobo_base/basal/widget/widget_process_load.dart';
import 'package:roobo_base/context/roobo_context.dart';
import 'package:roobo_theme/config_theme.dart';

abstract class BaseState<T extends StatefulWidget> extends ResumableState<T> {
  StreamController _streamController;
  ThemeData themeData;
  bool hasAppbar;
  Text appbarText;
  Widget appbarLeading;
  List<Widget> appbarActions;

  getData(StreamController _streamController);

  getResumeData(StreamController _streamController) {}

  @override
  void initState() {
    _streamController = StreamController();
    getData(_streamController);
    super.initState();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    RooboContext.context = context;
    themeData = getThemeData();
    if (themeData == null) {
      themeData = ThemeConfig.themeList[0];
    }
    super.didChangeDependencies();
  }

  @override
  void onResume() {
    getResumeData(_streamController);
    super.onResume();
  }

  sendEmptySucceed() {
    _streamController.sink.add("no_net_succeed");
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Theme(
        data: themeData,
        child: StreamBuilder(
            stream: _streamController.stream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return buildProgressWidget(context);
              }
              Widget body = _getBodyWidget(snapshot, context);
              if (isUseSystemAppbar()) {
                return Scaffold(
                  appBar: AppBar(
                    title: getAppBarText(),
                    leading: getDefaultAppbarLeading(),
                    actions: getAction(),
                  ),
                  body: body,
                );
              } else {
                return body;
              }
            }),
      ),
    );
  }

  buildProgressWidget(BuildContext context) {
    return ProgressLoadWidget(type: ProgressLoadType.FadingCircle);
  }

  buildErrorWidget(BuildContext context) {
    return NetErrorWidget(() {
      getData(_streamController);
    });
  }

  buildEmptyWidget(BuildContext context) {
    return EmptyDataWidget();
  }

  Widget buildChild(BuildContext context, dynamic data, StreamController _streamController);

  _getBodyWidget(AsyncSnapshot<dynamic> snapshot, BuildContext context) {
    if (snapshot.hasError) {
      return buildErrorWidget(context);
    }
    if (!snapshot.hasData) {
      return buildEmptyWidget(context);
    }
    return buildChild(context, snapshot.data, _streamController);
  }

  /// if return null will use the ThemeConfig.themeList[0];
  ThemeData getThemeData();

  bool isUseSystemAppbar() {
    return true;
  }

  Text getAppBarText() {
    return null;
  }

  //注入back键点击逻辑，重写需要调用 super()
  onAppbarBackClick() {
    Navigator.pop(context);
  }

  //修改leading  leading的pressed需要自己实现或者手动调用 onAppbarBackClick()
  Widget getDefaultAppbarLeading() {
    return InkWell(
        onTap: () => onAppbarBackClick.call(),
        child: Container(
          child: Image.asset(
            "res/img/icon_back.png",
            width: 9,
            height: 16,
          ),
        ));
  }

  List<Widget> getAction() {
    return [];
  }
}
