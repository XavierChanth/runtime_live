import 'package:at_chat_flutter/at_chat_flutter.dart';
import 'package:chit_chat_runtime_live/chats_screen.dart';
import 'package:flutter/material.dart';
import 'package:at_contacts_flutter/at_contacts_flutter.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    return ContactsScreen(
      context: context,
      onSendIconPressed: (String atsign) {
        setChatWithAtSign(atsign);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return ChatsScreen(atsign);
          }),
        );
      },
    );
  }
}
