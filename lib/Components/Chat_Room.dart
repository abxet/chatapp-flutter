import 'package:app/models/Chat_user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChatRoom extends StatefulWidget {
  final ChatUser user;
  const ChatRoom({super.key, required this.user});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  @override
  Widget build(BuildContext context) {

    // Fix status bar
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 1,
        flexibleSpace: _appBar(),
      ),

      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Text(
                "Start chatting ",
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ),
          ),
          _chatInput(),
        ],
      ),
    );
  }

  //  AppBar
  Widget _appBar() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, color: Colors.black87),
            ),

            // Profile image
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: CachedNetworkImage(
                height: 42,
                width: 42,
                fit: BoxFit.cover,
                imageUrl: widget.user.image,
                errorWidget: (context, url, error) =>
                    const CircleAvatar(child: Icon(Icons.person)),
              ),
            ),

            const SizedBox(width: 12),

            // Name + status
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.user.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "Online",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.green.shade600,
                    ),
                  ),
                ],
              ),
            ),

            // Actions
          
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }

  // Chat Input
  Widget _chatInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      color: Colors.white,
      child: Row(
        children: [

          // Input field
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: [
                  Icon(Icons.emoji_emotions_outlined,
                      color: Colors.grey.shade600),

                  const SizedBox(width: 8),

                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: "Type a message...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  Icon(Icons.photo_library_outlined,
                      color: Colors.grey.shade600),

                  const SizedBox(width: 8),

                  Icon(Icons.camera_alt_outlined,
                      color: Colors.grey.shade600),
                ],
              ),
            ),
          ),

          const SizedBox(width: 8),

          // Send button
          Container(
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(50),
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.send, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}