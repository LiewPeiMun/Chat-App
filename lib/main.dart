import 'package:flutter/material.dart';
import 'widgets/login.dart';
import 'package:firebase_core/firebase_core.dart';


//if has await must have async also (!important)
void main() async{
  //initialise firebase in the mobile app
  WidgetsFlutterBinding.ensureInitialized();
  //asynchrounous process (process that run in the background)
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      //firstpage
      home: LoginPage(),
    );
  }
}



