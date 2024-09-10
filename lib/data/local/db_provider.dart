import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DataProvider {
  DataProvider._();

  static final DataProvider getInstance = DataProvider._();

  // Table and column names
  final String tableNote = "note";
  final String columnSno = "sno";
  final String columnTitle = "title";
  final String columnDesc = "desc";
  final String columnDate = "date";
  final String columnClr = "clr";

  Database? db;

  // Initialize and get database
  Future<Database> getDB() async {
    db ??= await initializeDB();
    return db!;
  }

  Future<Database> initializeDB() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String appDirPath = join(appDir.path, "note_app.db");

    // Create the database and table if it doesn't exist
    Database openDB = await openDatabase(appDirPath,
        version: 1, // Increment this version number
        onCreate: (db, version) async {
      await db.execute('CREATE TABLE IF NOT EXISTS $tableNote ('
          '$columnSno INTEGER PRIMARY KEY AUTOINCREMENT, '
          '$columnDate TEXT, '
          '$columnTitle TEXT, '
          '$columnDesc TEXT, '
          '$columnClr TEXT)');
    }, onUpgrade: (db, oldVersion, newVersion) async {
      if (oldVersion < newVersion) {
        await db.execute('DROP TABLE IF EXISTS $tableNote');
        await db.execute('CREATE TABLE IF NOT EXISTS $tableNote ('
            '$columnSno INTEGER PRIMARY KEY AUTOINCREMENT, '
            '$columnDate TEXT, '
            '$columnTitle TEXT, '
            '$columnDesc TEXT, '
            '$columnClr TEXT)');
      }
    });
    return openDB;
  }

  // Fetch notes from database
  Future<List<Map<String, dynamic>>> fetchNotes() async {
    Database mDB = await getDB();
    return await mDB.query(tableNote);
  }

  // Insert new note
  Future<int> insertNotes(
      String date, String title, String desc, String clr) async {
    try {
      Database mDB = await getDB();
      int result = await mDB.insert(
        tableNote,
        {
          columnDate: date,
          columnTitle: title,
          columnDesc: desc,
          columnClr: clr,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return result;
    } catch (e) {
      // Handle the error
      return -1; // Return -1 to indicate failure
    }
  }

  // Update existing note
  Future<int> updateNotes(
      int sno, String date, String title, String desc, String clr) async {
    try {
      Database mDB = await getDB();
      int result = await mDB.update(
        tableNote,
        {
          columnDate: date,
          columnTitle: title,
          columnDesc: desc,
          columnClr: clr,
        },
        where: "$columnSno = ?",
        whereArgs: [sno],
      );
      return result;
    } catch (e) {
      return -1;
    }
  }

  // Delete a note
  Future<int> deleteNotes(int sno) async {
    Database mDB = await getDB();
    int result = await mDB.delete(
      tableNote,
      where: "$columnSno = ?",
      whereArgs: [sno],
    );
    return result;
  }
}
