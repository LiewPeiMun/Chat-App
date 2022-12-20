import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResetPage extends StatelessWidget {
  // const ResetPage({Key? key}) : super(key: key);
var emailEditingController = TextEditingController();
FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Reset Password"),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            TextField(decoration: InputDecoration(border: OutlineInputBorder(),hintText: "Enter your email"),controller: emailEditingController,),
            SizedBox(height: 40),
            TextButton(onPressed: (){
              _auth.sendPasswordResetEmail(email: emailEditingController.text).then((value){
                // print("Email successfully sent");
                final snackBar = SnackBar(
                  content: const Text('Email successfully sent!'),
                  //if no action, the snackbar will disappear few seconds
                  // action: SnackBarAction(
                  //   label: 'OK',
                  //   onPressed: () {
                  //     // Some code to undo the change.
                  //   },
                  // ),
                );

                // Find the ScaffoldMessenger in the widget tree
                // and use it to show a SnackBar.
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }).catchError((onError)
                  {
                    // print(err);
                    final snackBar = SnackBar(
                      content: Text(onError.message!),
                      //if no action, the snackbar will disappear few seconds
                      // action: SnackBarAction(
                      //   label: 'OK',
                      //   onPressed: () {
                      //     // Some code to undo the change.
                      //   },
                      // ),
                    );

                    // Find the ScaffoldMessenger in the widget tree
                    // and use it to show a SnackBar.
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
              );
            }, child: Text("Reset password"),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blueAccent),foregroundColor: MaterialStateProperty.all(Colors.white))
    ,)
          ],
        ),
      ),
    );
  }
}
