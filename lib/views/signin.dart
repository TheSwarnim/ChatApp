import 'package:ChatApp/widgets/widget.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn(this.toggle);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
              TextField(
                decoration: InputDecoration(hintText: "Email"),
              ),
              TextField(
                decoration: InputDecoration(hintText: "Password"),
              ),
              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.all(16),
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Container(
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
