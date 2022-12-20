import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login.dart';

class RegisterPage extends StatelessWidget {
  // const RegisterPage({Key? key}) : super(key: key);
  var emailEditingController = TextEditingController();
  var passwordEditingController = TextEditingController();
  //to use firebase authentication service
  FirebaseAuth _auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register"),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            TextField(decoration: InputDecoration(border: OutlineInputBorder(),hintText: "Enter your email"),controller: emailEditingController,),
            SizedBox(height: 20),
            TextField(decoration: InputDecoration(border: OutlineInputBorder(),hintText: "Enter your password"),obscureText: true,controller: passwordEditingController,),
            SizedBox(height: 40),
            TextButton(onPressed: (){
              _auth.createUserWithEmailAndPassword(email: emailEditingController.text, password: passwordEditingController.text).then((value) {
                if(value !=null){
                  FirebaseFirestore.instance.collection('users').doc(value.user!.uid).set(
                      {"id":value.user?.uid,
                        "email":value.user?.email,
                        "createAt":DateTime.now(),
                        "chattingWith":null
                      });
                }


                // print("Register successfully");
                final snackBar = SnackBar(
                  content: const Text('Register successfully!'),
                  action: SnackBarAction(
                    label: 'OK',
                    onPressed: () {
                      // Some code to undo the change.
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                    },
                  ),
                );

                // Find the ScaffoldMessenger in the widget tree
                // and use it to show a SnackBar.
                ScaffoldMessenger.of(context).showSnackBar(snackBar);

              //  to catch the firebase error
              }).catchError((error){
                print(error);

              });


            }, child: Text("Register"), style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blueAccent),foregroundColor: MaterialStateProperty.all(Colors.white))
              ,)

          ],
        ),
      ),
    );
  }
}
