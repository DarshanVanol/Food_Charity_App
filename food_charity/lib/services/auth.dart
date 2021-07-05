import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_charity/Model/user.dart';
import 'package:food_charity/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  MyUser? userfromFirebaseUser(UserCredential user) {
    // ignore: unnecessary_null_comparison
    return (user != null) ? (MyUser(uid: user.user!.uid)) : null;
  }

  bool isSignedIn() {
    return _auth.currentUser != null;
  }

  Stream<MyUser?> userStream() {
    return _auth.authStateChanges().map((User? user) => MyUser(uid: user!.uid));
  }

  // ignore: non_constant_identifier_names
  Future CreateNewUser(String email, String password, String first, String last,
      String phone) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await DatabaseService()
          .updateUserData(first, last, phone, result.user!.uid);
      return userfromFirebaseUser(result);
    } catch (e) {
      print('failed');
      print(e.toString());
    }
  }

  Future logIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userfromFirebaseUser(result);
    } catch (e) {
      print(e.toString());
    }
  }

  Future logOut() async {
    await _auth.signOut();
  }
}
