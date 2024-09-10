import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/data/local/db_provider.dart';
import 'package:note_app/screens/home_screen.dart';
import 'package:note_app/widgets/colors.dart';
import 'package:note_app/widgets/floating_btn.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class NoteScreen extends StatefulWidget {
  String clr;
  String title;
  String desc;
  int? upSno;
  NoteScreen(this.clr, this.title, this.desc, {this.upSno, super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  DataProvider? dbProvider;
  List<Map<String, dynamic>> notes = [];
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dbProvider = DataProvider.getInstance;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.desc.isEmpty && widget.title.isEmpty) {
      titleController.clear();
      descController.clear();
    } else {
      titleController.text = widget.title;
      descController.text = widget.desc;
    }
    return Material(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back),
            color: Color(int.parse(widget.clr)),
          ),
          title: Text(
            "Note",
            style: GoogleFonts.rokkitt(
              color: Color(int.parse(widget.clr)),
              fontSize: 50,
            ),
          ),
          backgroundColor: const Color(0xff060A0D),
        ),
        body: Container(
          padding: const EdgeInsets.only(top: 30, right: 10, left: 15),
          margin: const EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            color: Color(int.parse(widget.clr)),
            boxShadow: [
              BoxShadow(
                spreadRadius: 5,
                color: Color(int.parse(widget.clr)).withOpacity(0.6),
                blurRadius: 15,
              )
            ],
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(80)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "Date",
                  style: GoogleFonts.rokkitt(
                    color: const Color(0xff060A0D),
                    fontSize: 16,
                  ),
                ),
              ),
              TextField(
                controller: titleController,
                maxLines: null,
                style: GoogleFonts.rokkitt(
                    color: const Color(0xff060A0D),
                    fontSize: 25,
                    fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Title",
                  hintStyle: GoogleFonts.rokkitt(
                      color: const Color(0xff060A0D),
                      fontSize: 25,
                      fontWeight: FontWeight.w700),
                ),
              ),
              const Divider(
                color: Color(0xff060A0D),
              ),
              TextField(
                controller: descController,
                maxLines: null,
                style: GoogleFonts.rokkitt(
                    color: const Color(0xff060A0D),
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Descration",
                  hintStyle: GoogleFonts.rokkitt(
                      color: const Color(0xff060A0D),
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton:
            FloatingBtn(int.parse(colors[2]), Icons.check, "Done", () {
          var title = titleController.text.toString();
          var desc = descController.text.toString();
          DateTime now = DateTime.now();
          String formattedDate = DateFormat('yyyy-MM-dd').format(now);
          if (title.isEmpty || desc.isEmpty) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Write Note')));
          } else {
            String nClr = widget.clr;
            Future<int> result;
            // int nClr = int.parse(widget.clr.toString());
            if (widget.upSno == null) {
              result = saveNote(formattedDate, title, desc, nClr);
            } else {
              result = dbProvider!
                  .updateNotes(widget.upSno!, formattedDate, title, desc, nClr);
            }

            result.then((onValue) {
              if (onValue > 0) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return const HomeScreen();
                }));
              }
            });
            // bool check = await locDB!.addNotes(
            //     mDate: "date",
            //     mTitle: titleController.text.toString(),
            //     mDesc: descController.text.toString());
            // print("this value is add note : $check");
            // if (check) {
            //   ScaffoldMessenger.of(context)
            //       .showSnackBar(const SnackBar(content: Text('Some Error')));
            // } else {
            //   Navigator.of(context).pop();
            // }
          }
        }),
        bottomNavigationBar: BottomAppBar(
          color: Color(int.parse(colors[0])),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: noteColors.map((e) {
                return InkWell(
                  onTap: () {
                    widget.clr = e;
                    setState(() {});
                  },
                  child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Color(int.parse(e)),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: Color(int.parse(e)),
                              spreadRadius: 2,
                              blurRadius: 5)
                        ],
                      )),
                );
              }).toList()),
        ),
      ),
    );
  }

  Future<int> saveNote(date, title, desc, clr) async {
    int result = await dbProvider!.insertNotes(date, title, desc, clr);
    return result;
  }
}



/*



 isOpen
          ? 

          : isOpen


          : isOpen
            ? 



            : isOpen
            ?


NoteBg(widget.clr, "02-02-2024", widget.title, widget.desc)
*/ 