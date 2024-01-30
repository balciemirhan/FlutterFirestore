import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_operations/auth/signout.dart';
import 'package:crud_operations/models/notes_model.dart';
import 'package:crud_operations/services/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // FirestoreService
  final FirestoreService _firestoreService = FirestoreService();
  // FirebaseAuth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // text controller
  final TextEditingController _textController = TextEditingController();

  // open a dialog  to add a note.
  void openNoteBox(String? docID) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: _textController,
        ),
        actions: [
          // buton to save
          ElevatedButton(
              onPressed: () {
                // add a new note
                if (docID == null) {
                  _firestoreService.addNote(
                    Note(
                      userId: _auth.currentUser!.uid,
                      note: _textController.text,
                      timestamp: Timestamp.now(),
                    ),
                  );

                  // update an existing note
                } else {
                  _firestoreService.updateNote(
                    docID,
                    Note(
                      userId: _auth.currentUser!.uid,
                      note: _textController.text,
                      timestamp: Timestamp.now(),
                    ),
                  );
                }

                // clear the text controller
                _textController.clear();

                // close the box
                Navigator.of(context).pop();
              },
              child: const Text("Add"))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => OutService().signOut(),
              icon: const Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ))
        ],
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
        title: const Text("Notes"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () => openNoteBox(null),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestoreService.getNotesStream(_auth.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List noteList = snapshot.data!.docs;

            return ListView.builder(
              itemCount: noteList.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document = noteList[index];
                String docID = document.id;

                Note note =
                    Note.fromMap(document.data() as Map<String, dynamic>);
                String noteText = note.note;

                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color.fromARGB(255, 244, 221, 248),
                  ),
                  margin: const EdgeInsets.all(15),
                  padding: const EdgeInsets.all(15),
                  child: ListTile(
                      title: Text(
                        noteText,
                        style: const TextStyle(fontSize: 18),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // update button
                          IconButton(
                            onPressed: () => openNoteBox(docID),
                            icon: const Icon(Icons.change_circle),
                          ),

                          // delete button
                          IconButton(
                              onPressed: () =>
                                  _firestoreService.deleteNote(docID),
                              icon: const Icon(Icons.delete)),
                        ],
                      )),
                );
              },
            );
            // eğer veri yok ise
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
