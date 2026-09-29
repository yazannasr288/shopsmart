import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login.dart';
import '../rootscreen.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final user = snapshot.data;
        if (user == null) {
          return const LoginScreen();
        }

        // Google users are already authenticated through the provider.
        final isGoogleUser = user.providerData.any(
          (provider) => provider.providerId == 'google.com',
        );

        if (user.emailVerified || isGoogleUser) {
          return const Rootscreen();
        }

        return const LoginScreen(showVerificationMessage: true);
      },
    );
  }
}
