import 'package:ChatApp/helper/authenticate.dart';
import 'package:ChatApp/helper/constants.dart';
import 'package:ChatApp/helper/helperfunctions.dart';
import 'package:ChatApp/services/auth.dart';
import 'package:ChatApp/services/database.dart';
import 'package:ChatApp/views/conversation_screen.dart';
import 'package:ChatApp/views/search.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  Stream chatRoomStream;

  Widget chatRoomList() {
    return StreamBuilder(
      stream: chatRoomStream,
      builder: ((context, snapshot) => snapshot.hasData
          ? ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: ((context, index) => ChatRoomTile(
                  snapshot.data.documents[index].data["chatroomId"]
                      .toString()
                      .replaceAll("_", "")
                      .replaceAll(Constants.myName, ""),
                  snapshot.data.documents[index].data["chatroomId"])),
            )
          : Container()),
    );
  }

  @override
  void initState() {
    getUserInfo();

    super.initState();
  }

  getUserInfo() async {
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();

    databaseMethods
        .getChatRooms(Constants.myName)
        .then((value) => setState(() => chatRoomStream = value));
    print(Constants.myName);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assets/images/logo.png",
          height: 50,
        ),
        actions: <Widget>[
          GestureDetector(
              onTap: () {
                authMethods.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Authenticate()));
              },
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(Icons.exit_to_app)))
        ],
      ),
      body: chatRoomList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SearchScreen()));
        },
      ),
    );
  }
}

class ChatRoomTile extends StatelessWidget {
  final String userName;
  final String chatRooomId;
  ChatRoomTile(this.userName, this.chatRooomId);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ConversationScreen(chatRooomId))),
      child: Container(
        color: Colors.lime,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Text(
                userName.substring(0, 1).toUpperCase(),
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              userName,
              style: TextStyle(color: Colors.white, fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
