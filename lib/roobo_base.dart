library roobo_base;

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:roobo_base/basal/widget/widget_net_error.dart';
import 'package:roobo_base/preference/preference.dart';
import 'package:roobo_logger/roobo_logger.dart';
import 'package:roobo_net/net_state/net_state.dart';
import 'package:roobo_net/roobo_net.dart';
import 'package:roobo_theme/config_theme.dart';

import 'env/config_env.dart';

typedef RooboNetErrorWidget = Widget Function(Function f);

class RooboBase {
  static RooboNetErrorWidget? _netErrorWidget;

  static RooboNetErrorWidget? get netErrorWidget => _netErrorWidget;

  static Widget? _emptyWidget;

  static Widget? get emptyWidget => _emptyWidget;

  static preInit() async {
    Logger.i("Preference.init");
    await Preference.init();
    Logger.i("EnvConfig.init");
    await EnvConfig.init();
  }

  static init(
    String hostName,
    String authorization,
    bool isOpenProxy,
    Map proxyData,
    bool isLog, {
    RooboNetErrorWidget? netErrorWidget,
    Widget? emptyWidget,
    Map<String, String> errorMsg = const {},
    Map<String, Function> errorHandle = const {},
    required Function(ConnectivityResult result) listener,
  }) async {
    _netErrorWidget = netErrorWidget;
    _emptyWidget = emptyWidget;
    Logger.i("NetState.init");
    await NetState.init(listener);
    Logger.i("Net.init");
    Net.init(hostName, authorization, isOpenProxy, proxyData, isLog, errorMsg: errorMsg, errorHandle: errorHandle);
  }

  static initTheme(BuildContext context) {
    Logger.i("ThemeConfig.init");
    ThemeConfig.init(context);
  }
}
