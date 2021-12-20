library roobo_base;

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:roobo_base/preference/preference.dart';
import 'package:roobo_logger/roobo_logger.dart';
import 'package:roobo_net/net_state/net_state.dart';
import 'package:roobo_net/roobo_net.dart';
import 'package:roobo_theme/config_theme.dart';

import 'env/config_env.dart';

class RooboBase {
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
    Map<String, String> errorMsg = const {},
    Map<String, Function> errorHandle = const {},
    Function(ConnectivityResult result) listener,
  }) async {
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
