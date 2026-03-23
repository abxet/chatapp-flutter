import 'package:app/Components/chat_user_card.dart';
import 'package:app/api/apis.dart';
import 'package:app/models/Chat_user.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:app/Components/LoginWithEmail.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginWithEmail()),
    );
  }

  @override
  Widget build(BuildContext context) {

    
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      // ✅ Modern AppBar
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: const Text(
          "Chats",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [

          // Search button (future use)
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black87),
            onPressed: () {},
          ),

          // Logout
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.black87),
            onPressed: () => logout(context),
          ),
        ],
      ),

      body: StreamBuilder(
        stream: APIs.firestore.collection("users").snapshots(),

        builder: (context, snapshot) {
          switch (snapshot.connectionState) {

            case ConnectionState.waiting:
            case ConnectionState.none:
              return const Center(child: CircularProgressIndicator());

            case ConnectionState.active:
            case ConnectionState.done:
              final data = snapshot.data?.docs;
              final list =
                  data?.map((e) => ChatUser.fromJson(e.data())).toList() ?? [];

              // If users exist
              if (list.isNotEmpty) {
                return ListView.separated(
                  itemCount: list.length,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  physics: const BouncingScrollPhysics(),

                  separatorBuilder: (_, __) => const SizedBox(height: 4),

                  itemBuilder: (context, index) {
                    return ChatUserCard(user: list[index]);
                  },
                );
              }

              
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.chat_bubble_outline,
                        size: 80, color: Colors.grey.shade400),
                    const SizedBox(height: 10),
                    Text(
                      "No users found",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              );
          }
        },
      ),

      // Floating button
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {},
        child: const Icon(Icons.chat, color: Colors.white),
      ),
    );
  }
}