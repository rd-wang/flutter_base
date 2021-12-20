import 'package:flutter/material.dart';

class ToastInfoWidget extends StatelessWidget {

  final String msg;
  const ToastInfoWidget({@required this.msg, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(50.0),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(16),
      child: ClipRect(
        child: Text(
          msg,
          style: TextStyle(fontSize: 16,color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

}

class ToastIconWidget extends StatelessWidget {
  final String msg;
  final bool flag;

  const ToastIconWidget({@required this.msg, this.flag = true, Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(50.0),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(16),
      child: ClipRect(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(flag ? Icons.check_circle_outline :Icons.cancel, color: Colors.white),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                msg,
                style: TextStyle(fontSize: 16,color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}