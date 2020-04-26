import 'package:flutter/material.dart';
import 'data.dart';
import 'globals.dart' as globals;

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final Data data = new Data();
  final TextEditingController usernameController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  void checkPassword() {
    if (data.getData(usernameController.text, "password") == passwordController.text) {
      globals.currentUser = usernameController.text;
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text('Invalid username or password'),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Close'))
              ],
            );
          });
    }
  }
  void register() {
    data.addUser(usernameController.text, passwordController.text, 0, "0", 0, 0, 0, 0, 0, 0);
    globals.currentUser = usernameController.text;
    Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Material(
            child: TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: "Username",
              ),
            ),
          ),
          Material(
            child: TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: "Password",
              ),
            ),
          ),
          Row(
            children: <Widget>[
              RaisedButton(
                onPressed: checkPassword,
                child: Text("Login"),
              ),
              RaisedButton(
                onPressed: register,
                child: Text("Register"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
