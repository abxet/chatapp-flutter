import 'dart:math';

import 'package:app/Components/chat_user_card.dart';
import 'package:app/api/apis.dart';
import 'package:app/models/Chat_user.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:app/Components/LoginWithEmail.dart';

class ChatScreen extends StatelessWidget {
  // final List<ChatUser> list = [];
  // final GoogleSignIn _googleSignIn = GoogleSignIn();

  ChatScreen({super.key});

  Future<void> logout(BuildContext context) async {
    // await _googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginWithEmail()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat List"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => logout(context),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: APIs.firestore.collection("users").snapshots(),

        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            // loading
            case ConnectionState.waiting:
            case ConnectionState.none:
              return const Center(child: CircularProgressIndicator());
            // data loaded
            case ConnectionState.active:
            case ConnectionState.done:
              final data = snapshot.data?.docs;
              final list =
                  data?.map((e) => ChatUser.fromJson(e.data())).toList() ?? [];
              if (list.isNotEmpty) {
                return ListView.builder(
                itemCount: list.length,
                padding: EdgeInsets.only(top: 10),
                physics: ScrollPhysics(),
                itemBuilder: (context, index) {
                  return ChatUserCard(user: list[index]);
                },
              );
              } else {
                return Text("User not found");
              }
          }
        },
      ),
    );
  }
}

/*
ListView.builder(
        itemCount: 16,
        padding: EdgeInsets.only(top: 10),
        physics: ScrollPhysics(),
        itemBuilder: (context, index) {
          
          return const ChatUserCard();
        },
      ),
*/
