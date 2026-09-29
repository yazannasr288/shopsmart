import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  AuthService({
    FirebaseAuth? auth,
    FirebaseFirestore? firestore,
    GoogleSignIn? googleSignIn,
  })  : _auth = auth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.instance;

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final GoogleSignIn _googleSignIn;
  bool _googleInitialized = false;

  Future<void> _ensureGoogleInitialized() async {
    if (_googleInitialized) return;
    await _googleSignIn.initialize();
    _googleInitialized = true;
  }

  Future<UserCredential> signInWithGoogle() async {
    await _ensureGoogleInitialized();

    if (!_googleSignIn.supportsAuthenticate()) {
      throw UnsupportedError(
        'Google Sign-In authentication is not supported on this platform.',
      );
    }

    final googleUser = await _googleSignIn.authenticate();
    final googleAuth = googleUser.authentication;
    final idToken = googleAuth.idToken;

    if (idToken == null || idToken.isEmpty) {
      throw FirebaseAuthException(
        code: 'missing-google-id-token',
        message: 'Google did not return a valid ID token.',
      );
    }

    final credential = GoogleAuthProvider.credential(idToken: idToken);
    final userCredential = await _auth.signInWithCredential(credential);

    final user = userCredential.user;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).set(
        {
          'name': user.displayName,
          'email': user.email,
          'photoUrl': user.photoURL,
          'updatedAt': FieldValue.serverTimestamp(),
        },
        SetOptions(merge: true),
      );
    }

    return userCredential;
  }

  Future<void> signOut() async {
    try {
      await _ensureGoogleInitialized();
      await _googleSignIn.signOut();
    } catch (_) {
      // Google Sign-In may not be configured or initialized on this device.
    } finally {
      await _auth.signOut();
    }
  }
}
