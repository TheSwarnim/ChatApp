import 'package:ChatApp/helper/constants.dart';
import 'package:ChatApp/services/database.dart';
import 'package:ChatApp/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

QuerySnapshot searchSnapshot;

class _SearchScreenState extends State<SearchScreen> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController searchText = new TextEditingController();

  initiateSearch() {
    databaseMethods
        .getUserByUserName(searchText.text)
        .then((val) => setState(() => searchSnapshot = val));
  }

  createChatRoomAndStartConversation(String userName)
  {
    List<String> users= [userName,Constants.myName];
    Map<String,dynamic> chatRoomMap={
      "users":users,
      
    }
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

  @override
  void initState() {
    initiateSearch();
    super.initState();
  }

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

class SearchTile extends StatelessWidget {
  final String userName;
  final String userEmail;

  SearchTile(this.userEmail, this.userName);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      padding: EdgeInsets.all(24),
      child: Row(
        children: <Widget>[
          Column(
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
          Spacer(),
          GestureDetector(onTap: () => ,
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
}
