import 'package:flutter/material.dart';

class FloatingBtn extends StatelessWidget {
  final int color;
  final IconData icons;
  final String text;
  final void Function()? onPressed;

  const FloatingBtn(this.color, this.icons, this.text, this.onPressed,
      {super.key});
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: Color(color),
      tooltip: text,
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      child: Center(
        child: Icon(
          icons,
          color: Colors.white,
          size: 35,
        ),
      ),
    );
  }
}
