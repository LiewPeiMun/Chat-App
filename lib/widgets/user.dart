import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Own Profile"),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20),
              TextField(decoration: InputDecoration(border: OutlineInputBorder(),hintText: "Name"),),
              SizedBox(height: 20),
              TextField(decoration: InputDecoration(border: OutlineInputBorder(),hintText: "Email (not editable)"),),
              SizedBox(height: 20),
              TextField(decoration: InputDecoration(border: OutlineInputBorder(),hintText: "Phone number"),),
              SizedBox(height: 20),
              TextField(decoration: InputDecoration(border: OutlineInputBorder(),hintText: "Department"),),
              SizedBox(height: 20),
              TextField(decoration: InputDecoration(border: OutlineInputBorder(),hintText: "Address"),),
              SizedBox(height: 40),
              TextButton(onPressed: (){

              }, child: Text("Save"), style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blueAccent),foregroundColor: MaterialStateProperty.all(Colors.white))
                ,)

            ],
          ),
        ),
      ),
    );
  }
}

