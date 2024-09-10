import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDailog extends StatelessWidget {
  final Color clr;
  final void Function()? onYesPressed;
  final void Function()? onNoPressed;
  const MyDailog(
    this.clr, {
    super.key,
    this.onYesPressed,
    this.onNoPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Dialog(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        shadowColor: clr,
        backgroundColor: clr,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Do you want to delete this note",
                style: GoogleFonts.rokkitt(
                  color: const Color(0xff060A0D),
                  fontSize: 18,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: onYesPressed,
                    child: Text(
                      "Yes",
                      style: GoogleFonts.rokkitt(
                        color: const Color(0xff060A0D),
                        fontSize: 18,
                      ),
                    )),
                TextButton(
                    onPressed: onNoPressed,
                    child: Text(
                      "No",
                      style: GoogleFonts.rokkitt(
                        color: const Color(0xff060A0D),
                        fontSize: 18,
                      ),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
