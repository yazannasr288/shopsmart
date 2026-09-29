import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../imgservices/assetsmaneger.dart';
import 'google sign in.dart';
import 'signup.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, this.showVerificationMessage = false});

  final bool showVerificationMessage;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();

  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      final user = credential.user;
      await user?.reload();
      final refreshedUser = FirebaseAuth.instance.currentUser;

      if (refreshedUser != null && !refreshedUser.emailVerified) {
        await FirebaseAuth.instance.signOut();
        if (mounted) {
          _showMessage('Please verify your email before signing in.', isError: true);
        }
        return;
      }
    } on FirebaseAuthException catch (error) {
      if (!mounted) return;
      _showMessage(_mapAuthError(error.code), isError: true);
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
    } catch (error) {
      if (mounted) _showMessage('Google Sign-In failed. Please try again.', isError: true);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _resetPassword() async {
    final email = _emailController.text.trim();
    if (email.isEmpty || !email.contains('@')) {
      _showMessage('Enter your email first.', isError: true);
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      if (mounted) _showMessage('Password reset email sent.');
    } on FirebaseAuthException catch (error) {
      if (mounted) _showMessage(_mapAuthError(error.code), isError: true);
    }
  }

  String _mapAuthError(String code) {
    switch (code) {
      case 'invalid-credential':
      case 'wrong-password':
      case 'invalid-email':
        return 'Invalid email or password.';
      case 'user-not-found':
        return 'No account was found for this email.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      case 'network-request-failed':
        return 'Network error. Check your internet connection.';
      case 'operation-not-allowed':
        return 'This sign-in method is not enabled in Firebase.';
      default:
        return 'Unable to sign in. Please try again.';
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
    final theme = Theme.of(context);

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
                        'Welcome back',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Sign in to continue to ShopSmart',
                        style: theme.textTheme.bodyMedium,
                      ),
                      if (widget.showVerificationMessage) ...[
                        const SizedBox(height: 18),
                        const Card(
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.info_outline, color: Colors.orange),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    'Your email is not verified yet. Check your inbox and try again.',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                      const SizedBox(height: 28),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        autofillHints: const [AutofillHints.email],
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
                        textInputAction: TextInputAction.done,
                        autofillHints: const [AutofillHints.password],
                        onFieldSubmitted: (_) => _signIn(),
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
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: _isLoading ? null : _resetPassword,
                          child: const Text('Forgot password?'),
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: _isLoading ? null : _signIn,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 13),
                            child: Text('Sign in'),
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
                          const Text("Don't have an account?"),
                          TextButton(
                            onPressed: _isLoading
                                ? null
                                : () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => const Signup(),
                                      ),
                                    ),
                            child: const Text('Sign up'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (_isLoading)
              Positioned.fill(
                child: ColoredBox(
                  color: Colors.black26,
                  child: Center(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(22),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
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
