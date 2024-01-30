import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

class RegisterService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> createUser(String username, String email, String password,
      String confirmPassword) async {
    // Create a new user with email and password

    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    // Get the newly created user's UID
    String uid = userCredential.user!.uid; // (anlık kullanıcı id'si)

    final CollectionReference users = _firestore.collection('users');
    // Add the user to the users collection in Firestore
    await users.doc(uid).set({
      "username": username,
      "userId": uid,
      "email": email,
    });
  }
}
