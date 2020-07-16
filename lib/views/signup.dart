import 'package:ChatApp/helper/helperfunctions.dart';
import 'package:ChatApp/services/auth.dart';
import 'package:ChatApp/services/database.dart';
import 'package:ChatApp/views/chatRoomsScreen.dart';
import 'package:ChatApp/widgets/widget.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  final Function toggle;
  SignUp(this.toggle);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoading = false;

  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  HelperFunctions helperFunctions = new HelperFunctions();

  TextEditingController userName = new TextEditingController();
  TextEditingController mail = new TextEditingController();
  TextEditingController passd = new TextEditingController();

  final formKey = GlobalKey<FormState>();

  signMeUp() {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      authMethods
          .signUpWithEmailAndPassword(mail.text, passd.text)
          .then((value) {
        Map<String, String> userInfoMap = {
          "name": userName.text,
          "email": mail.text
        };

        HelperFunctions.saveUserEmailSharedPreference(mail.text);
        HelperFunctions.saveUserNameSharedPreference(userName.text);

        databaseMethods.uploadUserInfo(userInfoMap);

        HelperFunctions.saveUserLoggedInSharedPreference(true);

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ChatRoom(),
            ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Form(
                        key: formKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              validator: (val) {
                                return val.isEmpty || val.length < 3
                                    ? "Enter Username 3+ characters"
                                    : null;
                              },
                              controller: userName,
                              decoration:
                                  InputDecoration(labelText: "Username"),
                            ),
                            TextFormField(
                              validator: (value) =>
                                  RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(value)
                                      ? null
                                      : "PLease provide a valid emailid",
                              controller: mail,
                              keyboardType: TextInputType.emailAddress,
                              textCapitalization: TextCapitalization.none,
                              autocorrect: false,
                              decoration: InputDecoration(labelText: "Email"),
                            ),
                            TextFormField(
                              controller: passd,
                              obscureText: true,
                              decoration:
                                  InputDecoration(labelText: "Password"),
                              validator: (val) {
                                return val.length < 6
                                    ? "Enter Password 6+ characters"
                                    : null;
                              },
                            ),
                          ],
                        )),
                    Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.all(16),
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        signMeUp();
                      },
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
                          "Sign Up",
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
                        "Sign Up with Google",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Already have account? ",
                          style: TextStyle(fontSize: 16),
                        ),
                        GestureDetector(
                          onTap: () => widget.toggle(),
                          child: Text(
                            "SignIn now",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 16),
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
