import 'package:ChatApp/helper/constants.dart';
import 'package:ChatApp/services/database.dart';
import 'package:ChatApp/widgets/widget.dart';
import 'package:flutter/material.dart';

class ConversationScreen extends StatefulWidget {
  final String chatRoomId;
  ConversationScreen(this.chatRoomId);

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  DatabaseMethods databaseMethods = new DatabaseMethods();

  TextEditingController messageController = new TextEditingController();

  Stream chatMessagesStream;

  Widget ChatMessageList() {
    return StreamBuilder(
      stream: chatMessagesStream,
      builder: (context, snapshot) => snapshot.hasData
          ? ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) => MessageTile(
                snapshot.data.documents[index].data["message"],
                snapshot.data.documents[index].data["sendBy"] ==
                    Constants.myName,
              ),
            )
          : Container(
              color: Colors.white,
            ),
    );
  }

  sendMessage() {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "message": messageController.text,
        "sendBy": Constants.myName,
        "time": DateTime.now().millisecondsSinceEpoch
      };

      databaseMethods.addConversationMessages(widget.chatRoomId, messageMap);
      messageController.text = null;
    }
  }

  @override
  void initState() {
    databaseMethods
        .getConversationMessages(widget.chatRoomId)
        .then((val) => setState(() => chatMessagesStream = val));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: Stack(
          children: [
            ChatMessageList(),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                color: Colors.black87,
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: TextField(
                      controller: messageController,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                      decoration: InputDecoration(
                          hintText: "Message...",
                          hintStyle: TextStyle(color: Colors.white54),
                          border: InputBorder.none),
                    )),
                    GestureDetector(
                      onTap: () {
                        sendMessage();
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
                          child: Image.asset("assets/images/send.png")),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool isSendByMe;
  MessageTile(this.message, this.isSendByMe);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: isSendByMe ? 48 : 24, right: isSendByMe ? 24 : 48),
      margin: EdgeInsets.symmetric(vertical: 8),
      width: MediaQuery.of(context).size.width,
      alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isSendByMe
                    ? [const Color(0xff007EF4), const Color(0xff2A75BC)]
                    : [const Color(0xff007EF4), const Color(0xff2A75BC)],
              ),
              borderRadius: isSendByMe
                  ? BorderRadius.only(
                      topLeft: Radius.circular(23),
                      topRight: Radius.circular(23),
                      bottomLeft: Radius.circular(23))
                  : BorderRadius.only(
                      topLeft: Radius.circular(23),
                      topRight: Radius.circular(23),
                      bottomRight: Radius.circular(23))),
          child: Text(
            message,
            style: TextStyle(fontSize: 16, color: Colors.white),
          )),
    );
  }
}
