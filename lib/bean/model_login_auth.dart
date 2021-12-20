import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:roobo_base/preference/preference.dart';
///修改此处时需要保证auth的内存和缓存的一致性
///修改要同时修改，不能单一修改
class LoginAuthModel extends ChangeNotifier{
  LoginAuth _loginAuth;

  LoginAuthModel() {
    String authJson = Preference.getString("auth");
    if (authJson == null) {
      return;
    }
    _loginAuth = LoginAuth.fromJson(jsonDecode(authJson));
  }

  set auth(LoginAuth auth) {
    if (auth == null || auth.appUserID == null) return;
    _loginAuth = auth;
    Preference.setString("auth", jsonEncode(_loginAuth.toJson()));
    notifyListeners();
  }

  clearAuth() {
    if (_loginAuth != null) {
      _loginAuth = null;
      Preference.clear("auth");
      notifyListeners();
    }

  }

  bool get isLogin {
    return _loginAuth != null;
  }
}

// 登陆认证info
class LoginAuth {
  String appUserID;
  String accessToken;
  String accessTokenExpires;
  String refreshToken;
  String refreshTokenExpires;

  LoginAuth(
      {this.appUserID,
      this.accessToken,
      this.accessTokenExpires,
      this.refreshToken,
      this.refreshTokenExpires});

  LoginAuth.fromJson(Map<String, dynamic> json) {
    appUserID = json['appUserID'];
    accessToken = json['accessToken'];
    accessTokenExpires = json['accessTokenExpires'];
    refreshToken = json['refreshToken'];
    refreshTokenExpires = json['refreshTokenExpires'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appUserID'] = this.appUserID;
    data['accessToken'] = this.accessToken;
    data['accessTokenExpires'] = this.accessTokenExpires;
    data['refreshToken'] = this.refreshToken;
    data['refreshTokenExpires'] = this.refreshTokenExpires;
    return data;
  }
}
