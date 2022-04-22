import 'package:flutter/material.dart';
import 'package:roobo_theme/config_theme.dart';

class NetErrorWidget extends StatelessWidget {
  final Function f;

  NetErrorWidget(this.f);

  @override
  Widget build(BuildContext context) {
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
}
