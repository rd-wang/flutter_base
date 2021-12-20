import 'package:flutter/material.dart';

class EmptyDataWidget extends StatelessWidget {
  final String imageString;
  final String tips;
  double height;
  final double margin;
  final double radius;
  final AlignmentType type;
  final Color color;

  EmptyDataWidget({
    Key key,
    this.imageString = "res/img/bg_no_course_icon.png",
    this.tips = '暂无数据',
    this.height = 0,
    this.margin = 0,
    this.radius = 0,
    this.type = AlignmentType.Top,
    this.color = Colors.white
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (height == 0) {
      height = MediaQuery.of(context).size.height;
    }
    Widget widget = Stack(
      children: [
        Align(alignment: Alignment(0.0, -0.27), child: Image.asset(imageString)),
        Align(alignment: Alignment.center, child: Text(tips, textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)))
      ],
    );

    if (type == AlignmentType.Center) {
      widget = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imageString),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(tips, textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
          ),
        ],
      );
    }

    return Container(
      margin: EdgeInsets.all(margin),
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(radius)), color: color),
      child: widget,
    );
  }
}

enum AlignmentType {
  Center,
  Top,
}
