
import 'package:flutter/material.dart';

class SmallTextWidget extends StatelessWidget {
  final String data;
  final Color color;

  SmallTextWidget({required this.data, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(fontSize: 13, color: color),
    );
  }
}

class MediumTextWidget extends StatelessWidget {
  final String data;
  final Color color;
  MediumTextWidget({required this.data, required this.color});
  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(fontSize: 16, color: color),
    );
  }
}

class BigTextWidget extends StatelessWidget {
  final String data;
  final Color color;

  BigTextWidget({required this.data, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(fontSize: 22, color: color, fontWeight: FontWeight.bold),
    );
  }
}
