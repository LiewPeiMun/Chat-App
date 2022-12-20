import 'package:chat_app/widgets/detail.dart';
import 'package:chat_app/widgets/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//cannot edit this ListPage class unless retrieve the data from other page(pass forward or pass backward data)
class ListPage extends StatefulWidget {
  // const ListPage({Key? key}) : super(key: key);
  final String email;
  final String userId;
  ListPage({required this.email, required this.userId});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Employee List"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>UserPage()));
            },
          ),
          // add more IconButton
        ],
      ),
      body:
      StreamBuilder<QuerySnapshot>(
        //what is y0o0ur source of data
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
    //what to show once you get he data
    builder: (context,snapshot) {
      if (!snapshot.hasData) {
        return CircularProgressIndicator();
      }
      else {
        final List<DocumentSnapshot> employees = snapshot.requireData.docs;

        return //    listview is the entire list
          ListView.builder(
            //listview needs below two things
              itemCount: employees.length,
              itemBuilder: (context, index) {
                return Card(
                  //listtile is one of the row
                  child:
                  widget.email != employees[index]["email"]?
                  ListTile(
                    title: Text(employees[index]["email"]!),
                    subtitle: Text(employees[index]["id"]!),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailPage(userId: widget.userId, friendId: employees[index]["id"],)));
                    },
                  ):SizedBox(),
                );
              });
      }
    },

    )
    );
  }
}
