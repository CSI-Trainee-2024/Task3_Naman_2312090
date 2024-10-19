import 'package:flutter/material.dart';

class Titledata extends StatelessWidget {
  final Icon icon;
  final Color color;
  final BorderRadius? borderRadius;
  final Border? border;
  final String text;
  final VoidCallback? callback;

  Titledata(
      {required this.icon,
      required this.color,
      required this.text,
      this.border,
      this.borderRadius,
      this.callback});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        decoration: BoxDecoration(
            color: color, borderRadius: borderRadius, border: border),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            icon,
            Text(
              text,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
