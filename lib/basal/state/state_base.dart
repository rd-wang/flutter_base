import 'dart:async';

import 'package:flutter/material.dart';
import 'package:roobo_base/basal/state/state_resume.dart';
import 'package:roobo_base/basal/widget/widget_empty_data.dart';
import 'package:roobo_base/basal/widget/widget_net_error.dart';
import 'package:roobo_base/basal/widget/widget_process_load.dart';
import 'package:roobo_base/context/roobo_context.dart';
import 'package:roobo_base/roobo_base.dart';
import 'package:roobo_theme/config_theme.dart';

abstract class BaseState<T extends StatefulWidget> extends ResumableState<T> {
  late StreamController _streamController;
  ThemeData? themeData;
  bool? hasAppbar;
  Widget? appbarLeading;
  List<Widget>? appbarActions;

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
      themeData = ThemeConfig.themeList![0];
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
      type: MaterialType.transparency,
      child: Theme(
        data: themeData!,
        child: StreamBuilder(
            stream: _streamController.stream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Material(
                  child: buildProgressWidget(context),
                );
              }
              Widget body = _getBodyWidget(snapshot, context);
              if (isUseSystemAppbar()) {
                return getScaFFold(context, body);
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
    if (RooboBase.netErrorWidget != null) {
      return RooboBase.netErrorWidget!(() {
        getData(_streamController);
      });
    } else {
      return NetErrorWidget(() {
        getData(_streamController);
      });
    }
  }

  buildEmptyWidget(BuildContext context) {
    if (RooboBase.emptyWidget != null) {
      return RooboBase.emptyWidget;
    } else {
      return EmptyDataWidget();
    }
  }

  Widget buildChild(BuildContext context, dynamic data, StreamController? _streamController);

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
  ThemeData? getThemeData() {
    return null;
  }

  bool isUseSystemAppbar() {
    return true;
  }

  Widget getScaFFold(BuildContext context, Widget body) {
    return Scaffold(
      appBar: getAppBar(context),
      body: body,
    );
  }

  AppBar getAppBar(BuildContext context) {
    return AppBar(
      title: getAppBarText(),
      leading: getDefaultAppbarLeading(),
      actions: getAction(),
    );
  }

  Widget? getAppBarText() {
    return null;
  }

  //??????back???????????????????????????????????? super()
  onAppbarBackClick() {
    Navigator.pop(context);
  }

  //??????leading  leading???pressed???????????????????????????????????? onAppbarBackClick()
  Widget getDefaultAppbarLeading() {
    return InkWell(
        onTap: () => onAppbarBackClick.call(),
        child: Container(
          child: Image.asset(
            "res/img/icon_back.png",
            package: 'roobo_base',
            width: 9,
            height: 16,
          ),
        ));
  }

  List<Widget> getAction() {
    return [];
  }
}
