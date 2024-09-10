import 'package:flutter/material.dart';

class MainBg extends StatelessWidget {
  final int color;
  final int shColor;
  final Widget mChild;
  const MainBg(this.color, this.shColor, this.mChild, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      margin: const EdgeInsets.only(top: 30),
      padding: const EdgeInsets.only(top: 40, left: 30, right: 15),
      decoration: BoxDecoration(
        color: Color(color),
        boxShadow: [
          BoxShadow(
            spreadRadius: 5,
            color: Color(shColor).withOpacity(0.5),
            blurRadius: 15,
          )
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(80),
        ),
      ),
      child: mChild,
    );
  }
}
