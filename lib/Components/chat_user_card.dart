import 'package:app/Components/ChatList.dart';
import 'package:app/Components/Chat_Room.dart';
import 'package:app/models/Chat_user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ChatUserCard extends StatefulWidget {
  final ChatUser user;
  const ChatUserCard({super.key, required this.user});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => ChatRoom(user: widget.user,)));
        },
        child: ListTile(
          //leading: CircleAvatar(child: Icon(Icons.person),),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: CachedNetworkImage(
              height: 50,
              width: 50,
              imageUrl: widget.user.image,
              // placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) =>
                  CircleAvatar(child: Icon(Icons.person)),
            ),
          ),

          title: Text(widget.user.name),
          subtitle: Text(widget.user.about, maxLines: 1),
          trailing: Container(
            height: 10,
            width: 10,
            decoration: BoxDecoration(
              color: Colors.greenAccent.shade400,
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
      ),
    );
  }
}
