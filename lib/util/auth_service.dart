import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> getUserLogged() async {
    return await _auth.currentUser() == null;
  }

  Future<FirebaseUser> handleSignIn() async {
    GoogleSignInAccount user = await _googleSignIn.currentUser;

    if (user == null) {
      user = await _googleSignIn.signInSilently();
    }

    if (user == null) {
      user = await _googleSignIn.signIn();
    }

    if (await _auth.currentUser() == null) {
      GoogleSignInAuthentication googleAuth = await user.authentication;
      return await _auth.signInWithGoogle(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    }
    return await _auth.currentUser();
  }
}
