import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queuemusic/common/QueueMusicColor.dart';
import 'package:queuemusic/common/QueueMusicTheme.dart';
import 'package:queuemusic/widgets/TextFieldWidget.dart';
import 'package:uuid/uuid.dart';

import '../models/Session.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final _auth = FirebaseAuth.instance;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: theme(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Login to Host"),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              TextFieldWidget(
                  emailController,
                  "Email",
                  32,
                  BoolWrapper(true)
              ),
              TextFieldWidget(
                  passwordController,
                  "Password",
                  32,
                  BoolWrapper(true)
              ),
              SizedBox(height: 20,),
              ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(QueueMusicColor.green),
                ),
                onPressed: () async {
                  try {
                    UserCredential user = await _auth.signInWithEmailAndPassword(
                        email: emailController.value.text,
                        password: passwordController.value.text
                    );
                    String sessionCode = const Uuid().v1();
                    Provider.of<Session>(context, listen: false).joinSession(user.user!.uid, sessionCode);
                    FirebaseFirestore.instance.collection("sessions").add({
                      "sessionCode" : sessionCode,
                      "activeUntil" : DateTime.now().add(Duration(hours: 2)),
                    });
                    Navigator.pop(context);
                  } catch(e) {
                    // TODO login failed popup
                  }
                },
                icon: Icon(Icons.login),
                label: Text("Login"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
