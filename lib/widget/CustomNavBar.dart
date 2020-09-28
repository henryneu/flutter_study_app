import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomNavBar extends StatelessWidget {
  CustomNavBar({Key key, this.title, this.color});

  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      constraints: BoxConstraints(
        minHeight: 52.0,
        maxWidth: double.infinity,
      ),
      decoration: BoxDecoration(
        color: color,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 3),
            blurRadius: 3,
          )
        ],
      ),
      child: Text(
        title,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color:
                color.computeLuminance() < 0.5 ? Colors.white : Colors.black),
      ),
    );
  }
}
