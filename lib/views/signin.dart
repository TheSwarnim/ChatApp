import 'package:ChatApp/helper/helperfunctions.dart';
import 'package:ChatApp/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../services/auth.dart';
import '../services/auth.dart';
import '../services/database.dart';
import '../services/database.dart';
import 'chatRoomsScreen.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn(this.toggle);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  TextEditingController mail = new TextEditingController();
  TextEditingController passd = new TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool isLoading=false;

  signIn(){
    HelperFunctions.saveUserEmailSharedPreference(mail.text);
    
    if(formKey.currentState.validate()){
      setState(() {
      isLoading=true;
    });
    
    QuerySnapshot userInfoSnapshot;
    databaseMethods.getUserByUserEmail(mail.text)
    .then((val){
      userInfoSnapshot=val;
      HelperFunctions.saveUserNameSharedPreference(userInfoSnapshot.documents[0].data["name"]);
    });
    
    authMethods.signInWithEmailAndPassword(mail.text, passd.text)
    .then((value) {
      if(value!=null){

        HelperFunctions.saveUserLoggedInSharedPreference(true);

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ChatRoom(),
            ));
      }

    });
    
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) =>
                          RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)
                              ? null
                              : "PLease provide a valid emailid",
                      controller: mail,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: "Email"),
                    ),
                    TextFormField(
                      validator: (val) {
                        return val.length < 6
                            ? "Enter Password 6+ characters"
                            : null;
                      },
                      controller: passd,
                      obscureText: true,
                      decoration: InputDecoration(labelText: "Password"),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.all(16),
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              GestureDetector(onTap: () => ,
                              child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        const Color(0xff007EF4),
                        const Color(0xff2A75BC)
                      ]),
                      borderRadius: BorderRadius.circular(30)),
                  margin: EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    "Sign In",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(30)),
                margin: EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  "Sign In with Google",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Don't have account? ",
                    style: TextStyle(fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () => widget.toggle(),
                    child: Text(
                      "Register now",
                      style: TextStyle(
                          decoration: TextDecoration.underline, fontSize: 16),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
