import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  AuthService();

  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  static Future<void>? _googleInitialization;

  static Future<void> _ensureGoogleInitialized() {
    return _googleInitialization ??= _googleSignIn.initialize();
  }

  Future<void> signOut() async {
    try {
      await _ensureGoogleInitialized();
      await _googleSignIn.signOut();
    } finally {
      await _auth.signOut();
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      await _ensureGoogleInitialized();

      if (!_googleSignIn.supportsAuthenticate()) {
        throw StateError('Google Sign-In authentication is not supported on this platform.');
      }

      final GoogleSignInAccount googleUser =
          await _googleSignIn.authenticate();
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      final String? idToken = googleAuth.idToken;

      if (idToken == null || idToken.isEmpty) {
        throw StateError('Google Sign-In did not return an ID token.');
      }

      final credential = GoogleAuthProvider.credential(idToken: idToken);
      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;

      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'name': user.displayName,
          'email': user.email,
          'photoUrl': user.photoURL,
          'provider': 'google.com',
          'updatedAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
      }

      return user;
    } on GoogleSignInException catch (error) {
      debugPrint('Google Sign-In error: ${error.code} ${error.description}');
      rethrow;
    } catch (error, stackTrace) {
      debugPrint('Google Sign-In error: $error');
      debugPrintStack(stackTrace: stackTrace);
      rethrow;
    }
  }
}
