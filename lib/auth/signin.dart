import 'package:firebase_auth/firebase_auth.dart';

class LoginService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> loginUser(String email, String password) async {
 
    await _auth.signInWithEmailAndPassword(email: email, password: password);

   
  }
}
