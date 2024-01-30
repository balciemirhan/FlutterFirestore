import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  String userId;
  String note;
  Timestamp timestamp;

  Note({
    required this.userId,
    required this.note,
    required this.timestamp,
  });

  factory Note.fromMap(Map<String, dynamic> json) {
    return Note(
      userId: json['userId'] as String,
      note: json['note'] as String,
      timestamp: json['timestamp'] as Timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'note': note,
      'timestamp': timestamp,
    };
  }
}
