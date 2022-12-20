import 'package:chat_app/widgets/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'register.dart';
import 'reset.dart';
import 'list.dart';

class LoginPage extends StatelessWidget {
  // const LoginPage({Key? key}) : super(key: key);
  var emailEditingController = TextEditingController();
  var passwordEditingController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login")),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              TextField(decoration: InputDecoration(border: OutlineInputBorder(),hintText: "Enter your email"),controller: emailEditingController,),
              SizedBox(height: 20),
              TextField(decoration: InputDecoration(border: OutlineInputBorder(),hintText: "Enter your password"),obscureText: true, controller: passwordEditingController,),
              SizedBox(height: 40),
              TextButton(onPressed: (){
                _auth.signInWithEmailAndPassword(email: emailEditingController.text, password: passwordEditingController.text).then((value){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ListPage(email: value.user!.email!, userId: value.user!.uid,))); //.value from FirebaseAuth _auth = FirebaseAuth.instance;
                }).catchError((error){
                  //print the error at *run*
                  print(error);
                });

              }, child: Text("Login"), style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blueAccent), foregroundColor: MaterialStateProperty.all(Colors.white)),
              ),
              SizedBox(height: 20),
              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterPage()));
              }, child: Text("No account? Sign up")),
              SizedBox(height: 20),
              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ResetPage()));
              }, child: Text("Forgot Password"))
            ],
          ),
        )
    );
  }
}
