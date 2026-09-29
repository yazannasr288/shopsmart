import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../imgservices/assetsmaneger.dart';
import 'google sign in.dart';
import 'login.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _authService = AuthService();

  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      final user = credential.user;
      await user?.sendEmailVerification();
      await FirebaseAuth.instance.signOut();

      if (mounted) {
        _showMessage('Verification email sent. Check your inbox before signing in.');
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    } on FirebaseAuthException catch (error) {
      if (mounted) _showMessage(_mapAuthError(error.code), isError: true);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _signInWithGoogle() async {
    setState(() => _isLoading = true);
    try {
      await _authService.signInWithGoogle();
    } on FirebaseAuthException catch (error) {
      if (mounted) _showMessage(_mapAuthError(error.code), isError: true);
    } on GoogleSignInException catch (error) {
      if (mounted) {
        _showMessage(error.description ?? 'Google Sign-In was cancelled.', isError: true);
      }
    } catch (_) {
      if (mounted) _showMessage('Google Sign-In failed. Please try again.', isError: true);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  String _mapAuthError(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'An account already exists for this email.';
      case 'weak-password':
        return 'Choose a stronger password.';
      case 'invalid-email':
        return 'Enter a valid email address.';
      case 'operation-not-allowed':
        return 'Email/password sign-up is not enabled in Firebase.';
      default:
        return 'Unable to create the account. Please try again.';
    }
  }

  void _showMessage(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: isError ? Colors.redAccent : Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Image.asset(Assetsmaneger.logo, height: 130),
                      const SizedBox(height: 20),
                      Text(
                        'Create account',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                      const SizedBox(height: 28),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                        validator: (value) {
                          final email = value?.trim() ?? '';
                          if (email.isEmpty || !email.contains('@')) {
                            return 'Enter a valid email address.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 14),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            onPressed: () => setState(
                              () => _obscurePassword = !_obscurePassword,
                            ),
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if ((value ?? '').length < 6) {
                            return 'Password must be at least 6 characters.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 14),
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: _obscureConfirmPassword,
                        decoration: InputDecoration(
                          labelText: 'Confirm password',
                          prefixIcon: const Icon(Icons.lock_reset_outlined),
                          suffixIcon: IconButton(
                            onPressed: () => setState(
                              () => _obscureConfirmPassword = !_obscureConfirmPassword,
                            ),
                            icon: Icon(
                              _obscureConfirmPassword
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value != _passwordController.text) {
                            return 'Passwords do not match.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: _isLoading ? null : _signUp,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 13),
                            child: Text('Create account'),
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: _isLoading ? null : _signInWithGoogle,
                          icon: Image.asset(Assetsmaneger.googleLogo, height: 22),
                          label: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 11),
                            child: Text('Continue with Google'),
                          ),
                        ),
                      ),
                      const SizedBox(height: 22),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Already have an account?'),
                          TextButton(
                            onPressed: _isLoading
                                ? null
                                : () => Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (_) => const LoginScreen(),
                                      ),
                                    ),
                            child: const Text('Sign in'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (_isLoading)
              const Positioned.fill(
                child: ColoredBox(
                  color: Colors.black26,
                  child: Center(
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(22),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 14),
                            Text('Please wait...'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
