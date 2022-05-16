import 'package:flutter/material.dart';
import 'package:roobo_base/context/roobo_error_content.dart';
import 'package:roobo_theme/config_theme.dart';

class NetErrorWidget extends StatelessWidget {
  final Function f;

  NetErrorWidget(this.f);

  @override
  Widget build(BuildContext context) {
    if (RooboErrorContent.style == ErrorStyle.style_2) {
      return _getStyle_2(context);
    } else {
      return _getStyle_1(context);
    }
  }

  _getStyle_1(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(0),
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(0)), color: Colors.white),
      child: Stack(
        children: [
          Align(alignment: Alignment(0.0, -0.1), child: Image.asset('res/img/bg_no_net.png')),
          Align(alignment: Alignment(0.0, 0.2), child: Text("糟糕，网络开小差了\n刷新试试", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey))),
          Align(
            alignment: Alignment(0.0, 0.45),
            child: RaisedButton(
              onPressed: () {
                f();
              },
              color: ThemeConfig.currentThemeData!.primaryColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("重新加载", style: ThemeConfig.getCurrentPrimaryButtonTextStyle(context)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _getStyle_2(BuildContext context) {
    return Material(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(0)), color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('res/img/bg_no_net.png'),
            Padding(
              padding: EdgeInsets.only(top: 80,left: 40, right: 40),
              child: InkWell(
                onTap: () {
                  f();
                },
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [Color(0xFF075EE2), Color(0xFF7381FF)]),
                    boxShadow: [BoxShadow(color: Color(0x80A8D3FF), offset: Offset(0, 6.67), blurRadius: 13.33, spreadRadius: 0)],
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '重新加载',
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
