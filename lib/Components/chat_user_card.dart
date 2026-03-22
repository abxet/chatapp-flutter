import 'package:app/models/Chat_user.dart';
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
    return Card(child: InkWell(
      onTap: () {},
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(Icons.person),
        ),
        title: Text(widget.user.name),
        subtitle: Text(widget.user.about, maxLines: 1,),
        trailing: Text("12:00 PM"),
      ),
    ),);
  }
}