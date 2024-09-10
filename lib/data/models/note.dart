import 'package:flutter/material.dart';

class Note {
  String? sno;
  String date;
  String title;
  String desc;
  Color clr;
  Note({
    this.sno,
    required this.date,
    required this.title,
    required this.desc,
    required this.clr,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sno': sno,
      'date': date,
      'title': title,
      'desc': desc,
      'clr': clr,
    };
  }
}
