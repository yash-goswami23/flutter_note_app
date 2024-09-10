import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoteBg extends StatelessWidget {
  final String mTitle;
  final String mDate;
  final String mDesc;
  final String color;
  const NoteBg(this.color, this.mDate, this.mTitle, this.mDesc, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(top: 5, left: 15, right: 10, bottom: 15),
      decoration: BoxDecoration(
        color: Color(int.parse(color)),
        boxShadow: [
          BoxShadow(
            spreadRadius: 5,
            color: Color(int.parse(color)).withOpacity(0.6),
            blurRadius: 15,
          )
        ],
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                mTitle,
                style: GoogleFonts.rokkitt(
                    color: const Color(0xff060A0D),
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              Expanded(
                child: Text(
                  mDate,
                  style: GoogleFonts.rokkitt(
                    color: const Color(0xff060A0D),
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          const Divider(
            color: Color(0xff060A0D),
            height: 2,
          ),
          Text(
            mDesc,
            style: GoogleFonts.rokkitt(
                color: const Color(0xff060A0D),
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
