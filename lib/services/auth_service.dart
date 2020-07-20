import 'package:coffee_crew/models/user.dart';
import 'package:coffee_crew/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based on fireBase user // --helper method
  User _parseFirebaseUser(FirebaseUser firebaseUser) {
    return firebaseUser != null ? User(uid: firebaseUser.uid) : null;
  }

  // auth change user stream
  Stream<User> get user => _auth.onAuthStateChanged
      // .map((FirebaseUser fbUser) => _parseFirebaseUser(fbUser));
      .map(_parseFirebaseUser);

  // sign in anonymously
  Future signInAnonymously() async {
    try {
      AuthResult authResult = await _auth.signInAnonymously();
      FirebaseUser _firebaseUser = authResult.user;
      return _parseFirebaseUser(_firebaseUser);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and passwort
  Future signInWithEmailAndPasswort(String email, String password) async {
    try {
      AuthResult _authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser _firebaseUser = _authResult.user;
      return _parseFirebaseUser(_firebaseUser);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with email and password

  Future registerWithEmailAndPasswort(String email, String password) async {
    try {
      AuthResult _authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser _firebaseUser = _authResult.user;

      // create a new document for the user with the uid
      await DatabaseService(uid: _firebaseUser.uid)
          .updateUserData('0', 'new coffee crew member', 100);

      return _parseFirebaseUser(_firebaseUser);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future<void> signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
