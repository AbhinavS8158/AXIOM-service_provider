// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:service_provider/model/login_model.dart';
import 'package:service_provider/view/screen/get%20Start/get_start.dart';
import 'package:service_provider/view/screen/widget/bottom_navigation.dart';

class LoginController with ChangeNotifier {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final obscurePassword = ValueNotifier<bool>(true);
bool isLoading = false;

// usercredentials
 Future<void> loginUser(BuildContext context) async {
  if (isLoading) return;

  final loginData = LoginModel(
    email: emailController.text.trim(),
    password: passwordController.text,
  );

  if (loginData.email.isEmpty || loginData.password.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please enter both email and password'),
        backgroundColor: Colors.redAccent,
      ),
    );
    return;
  }

  try {
    isLoading = true;
    notifyListeners();

    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: loginData.email,
      password: loginData.password,
    );

    emailController.clear();
    passwordController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Login successful!'),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => BottomNav()),
      (route) => false,
    );
  } on FirebaseAuthException catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(e.message ?? 'Login failed'),
        backgroundColor: Colors.redAccent,
      ),
    );
  } finally {
    isLoading = false;
    notifyListeners();
  }
}

//  Google
 Future<bool> googlelogin(BuildContext context) async {
  if (isLoading) return false;

  try {
    isLoading = true;
    notifyListeners();

    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();

    final GoogleSignInAccount? googleUser =
        await googleSignIn.signIn();

    if (googleUser == null) {
      isLoading = false;
      notifyListeners();
      return false;
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final OAuthCredential credential =
        GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential =
        await FirebaseAuth.instance
            .signInWithCredential(credential);

    final User? user = userCredential.user;

    if (user == null) {
      throw Exception('User is null after Google sign-in');
    }


    final docRef = FirebaseFirestore.instance
        .collection('service_provider')
        .doc(user.uid);

    final docSnapshot = await docRef.get();

    if (!docSnapshot.exists) {
      await docRef.set({
        'uid': user.uid, 
        'name': user.displayName ?? '',
        'email': user.email ?? '',
        'phone': user.phoneNumber ?? '',
        'photoUrl': user.photoURL ?? '',
      });
    }
   

    isLoading = false;
    notifyListeners();
    return true;
  } on FirebaseAuthException catch (e) {
    _handleError(context, e.message ?? 'Google sign-in failed');
    return false;
  } catch (e) {
    _handleError(context, 'Something went wrong. Try again.');
    return false;
  }
}
void _handleError(BuildContext context, String message) {
  isLoading = false;
  notifyListeners();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Colors.redAccent,
    ),
  );
}

  
  // LOGOUT USER
  Future<void> logout(BuildContext context) async {
    bool confirmLogout = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Confirm Logout'),
              content: const Text('Are you sure you want to logout?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text(
                    'Logout',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            );
          },
        ) ??
        false;

    if (confirmLogout) {
      try {
        await FirebaseAuth.instance.signOut();

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const GetStartedScreen()),
          (Route<dynamic> route) => false,
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Logout Failed: ${e.toString()}'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  // ---------------------------------------------------------
  // RESET PASSWORD
  // ---------------------------------------------------------
 Future<void> sendPasswordResetEmail(
  String email,
  BuildContext context,
) async {
  final trimmedEmail = email.trim();

  if (trimmedEmail.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please enter your email address'),
        backgroundColor: Colors.redAccent,
      ),
    );
    return;
  }

  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(
      email: trimmedEmail,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 12),
            Text('Password reset email sent successfully'),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(16),
      ),
    );
  } on FirebaseAuthException catch (e) {
    String message;

    switch (e.code) {
      case 'user-not-found':
        message = 'No account found with this email';
        break;
      case 'invalid-email':
        message = 'Please enter a valid email address';
        break;
      default:
        message = e.message ?? 'Something went wrong';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.redAccent,
      ),
    );
  } catch (_) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Unable to send reset email'),
        backgroundColor: Colors.redAccent,
      ),
    );
  }
}


  // ---------------------------------------------------------
  // DISPOSE CONTROLLERS (avoid memory leaks)
  // ---------------------------------------------------------
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    obscurePassword.dispose();
    super.dispose();
  }
}

