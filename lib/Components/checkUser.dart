import 'package:app/Components/ChatList.dart';
import 'package:app/Components/LoginWithEmail.dart';
import 'package:app/api/apis.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CheckUser extends StatefulWidget {
  const CheckUser({super.key});

  @override
  State<CheckUser> createState() => _CheckUserState();
}

class _CheckUserState extends State<CheckUser> {

  @override
  void initState() {
    super.initState();
    checkUser();
  }
  
  Future<void> checkUser() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      //  Ensure user exists in Firestore
      await _ensureUserInFirestore();

      //Navigate to Chat Screen
      _navigateTo( ChatScreen());
    } else {
      // Navigate to Login Screen
      _navigateTo(const LoginWithEmail());
    }
  }

  
  Future<void> _ensureUserInFirestore() async {
    if (!(await APIs.userExists())) {
      await APIs.createUser();
    }
  }

  
  void _navigateTo(Widget screen) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => screen),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Loading screen 
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

