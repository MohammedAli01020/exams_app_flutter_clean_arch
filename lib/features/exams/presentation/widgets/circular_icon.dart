import 'package:flutter/material.dart';

class CircularIcon extends StatefulWidget {
  final IconData icon;
  final Color color;

  const CircularIcon({
    Key? key,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  State<CircularIcon> createState() => _CircularIconState();
}

class _CircularIconState extends State<CircularIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24.0,
      width: 24.0,
      decoration: BoxDecoration(
        color: widget.color,
        shape: BoxShape.circle,

      ),
      child: Icon(
        widget.icon,
        color: Colors.white,
        size: 16.0,
      ),
    );
  }
}