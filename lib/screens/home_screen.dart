import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/data/local/db_provider.dart';
import 'package:note_app/screens/note_screen.dart';
import 'package:note_app/widgets/colors.dart';
import 'package:note_app/widgets/floating_btn.dart';
import 'package:note_app/widgets/main_bg.dart';
import 'package:note_app/widgets/my_dailog.dart';
import 'package:note_app/widgets/note_bg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DataProvider? dbProvider;
  List<Map<String, dynamic>> notes = [];

  @override
  void initState() {
    super.initState();
    dbProvider = DataProvider.getInstance;
    getNotes();
  }

  void getNotes() async {
    notes = await dbProvider!.fetchNotes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: AppBar(
          title: Text(
            "Note",
            style: GoogleFonts.rokkitt(
              color: const Color(0xffFF0000),
              fontSize: 50,
            ),
          ),
          backgroundColor: const Color(0xff060A0D),
        ),
        body: MainBg(
            int.parse(colors[0]),
            int.parse(colors[1]),
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NoteScreen(
                            upSno: notes[index][dbProvider!.columnSno],
                            notes[index][dbProvider!.columnClr],
                            notes[index][dbProvider!.columnTitle],
                            notes[index][dbProvider!.columnDesc]),
                      ),
                    );
                  },
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (context) => MyDailog(
                        Color(int.parse(notes[index][dbProvider!.columnClr])),
                        onYesPressed: () {
                          var snoValue = notes[index][dbProvider!.columnSno];
                          Future<int> result = deleteNote(snoValue);
                          result.then(
                            (value) {
                              getNotes();
                            },
                          );
                          Navigator.pop(context);
                        },
                        onNoPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    );
                  },
                  child: NoteBg(
                    notes[index][dbProvider!.columnClr],
                    notes[index][dbProvider!.columnDate],
                    notes[index][dbProvider!.columnTitle],
                    notes[index][dbProvider!.columnDesc],
                  ),
                );
              },
              itemCount: notes.length,
            )),
        floatingActionButton:
            FloatingBtn(int.parse(colors[2]), Icons.add, "Add", () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return NoteScreen(noteColors[2], "", "");
            },
          ));
        }),
      ),
    );
  }

  Future<int> deleteNote(int sno) async {
    int result = await dbProvider!.deleteNotes(sno);
    return result;
  }
}
