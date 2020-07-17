import 'package:ChatApp/helper/constants.dart';
import 'package:ChatApp/services/database.dart';
import 'package:ChatApp/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'conversation_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

// String _myName;

class _SearchScreenState extends State<SearchScreen> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController searchText = new TextEditingController();

  QuerySnapshot searchSnapshot;

  initiateSearch() {
    databaseMethods
        .getUserByUserName(searchText.text)
        .then((val) => setState(() => searchSnapshot = val));
  }

  createChatRoomAndStartConversation(String userName) {
    if (userName != Constants.myName) {
      String chatRoomId = getChatRoomId(userName, Constants.myName);

      List<String> users = [userName, Constants.myName];
      Map<String, dynamic> chatRoomMap = {
        "users": users,
        "chatroomId": chatRoomId
      };

      databaseMethods.createChatRoom(chatRoomId, chatRoomMap);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ConversationScreen()));
    } else {
      print("You cann't send request to yourself");
    }
  }

  Widget SearchTile(String userName, String userEmail) {
    return Container(
      color: Colors.grey,
      padding: EdgeInsets.all(24),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  userName,
                  style: TextStyle(fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  userEmail,
                  style: TextStyle(fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () => createChatRoomAndStartConversation(userName),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(13)),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Text(
                "Message",
                style: TextStyle(fontSize: 16),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget searchList() {
    return searchSnapshot != null
        ? ListView.builder(
            itemCount: searchSnapshot.documents.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return SearchTile(
                searchSnapshot.documents[index].data["email"],
                searchSnapshot.documents[index].data["name"],
              );
            },
          )
        : Container();
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  @override
  void initState() {
    super.initState();
  }

  // getUserInfo() async {
  //   _myName = await HelperFunctions.getUserNameSharedPreference();
  //   setState(() => {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              color: Colors.black87,
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: TextField(
                    controller: searchText,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                    decoration: InputDecoration(
                        hintText: "search username...",
                        hintStyle: TextStyle(color: Colors.white54),
                        border: InputBorder.none),
                  )),
                  GestureDetector(
                    onTap: () {
                      initiateSearch();
                    },
                    child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  const Color(0x36FFFFFF),
                                  const Color(0x0FFFFFFF)
                                ],
                                begin: FractionalOffset.topLeft,
                                end: FractionalOffset.bottomRight),
                            borderRadius: BorderRadius.circular(40)),
                        padding: EdgeInsets.all(10),
                        child: Image.asset("assets/images/search_white.png")),
                  )
                ],
              ),
            ),
            searchList(),
          ],
        ),
      ),
    );
  }
}
