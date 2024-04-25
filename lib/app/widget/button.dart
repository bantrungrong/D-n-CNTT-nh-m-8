import 'package:flutter/material.dart';

import '../core/values/strings.dart';

class ButtonApp extends StatefulWidget {
  final double height;
  final double width;
  final String title;
  final Color colorTitle;
  final Color color;
  const ButtonApp(
      {super.key,
      required this.height,
      required this.width,
      required this.title,
      required this.color,
      required this.colorTitle});

  @override
  State<ButtonApp> createState() => _ButtonAppState();
}

class _ButtonAppState extends State<ButtonApp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
          color: widget.color,
          border: Border.all(color: Colors.red),
          borderRadius: BorderRadius.circular(12)),
      child: Center(
          child: Text(
        widget.title,
        style: AppStyle.bold(color: widget.colorTitle),
      )),
    );
  }
}
