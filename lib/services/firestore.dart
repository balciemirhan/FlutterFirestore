import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:crud_operations/models/notes_model.dart';

class FirestoreService {
  // Get collection of notes

  final CollectionReference<Map<String, dynamic>> notes =
      FirebaseFirestore.instance.collection("notes");

  // CREATE
  Future addNote(Note note) async {
    return notes.add(note.toMap());
  }

  // READ
  Stream<QuerySnapshot> getNotesStream(String userId) {
    return notes
        .where('userId', isEqualTo: userId)
        /*   .orderBy('timestamp', descending: false) */
        .snapshots(includeMetadataChanges: true);
  }

  // UPDATE
  Future<void> updateNote(String docID, Note newNote) async {
    return notes.doc(docID).update(newNote.toMap());
  }

  // DELETE
  Future<void> deleteNote(String docID) {
    return notes.doc(docID).delete();
  }
}
