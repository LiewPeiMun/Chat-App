import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  // const DetailPage({Key? key}) : super(key: key);
  final String userId;
  final String friendId;
  //constructor
  DetailPage({required this.userId, required this.friendId});


  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  var messages = [
    // {"sender": "AAA",
    // "message": "Jom Makan",
    //   "time": "12.15pm"
    // },
    // {"sender": "BBB",
    //   "message": "Jom!! Makan mana?",
    //   "time": "12.15pm"
    // }
  ];

  var messageEditingController = TextEditingController();
  var groupChatId = "";

  @override
  Widget build(BuildContext context) {
    if (widget.userId.hashCode<widget.friendId.hashCode){
      groupChatId = '${widget.userId}-${widget.friendId}';
    }
    else{
      groupChatId = '${widget.friendId}-${widget.userId}';
    }

    return Scaffold(
      appBar: AppBar(title: Text("Chat"),),
      body:
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [

              SizedBox(height: 20),

              Expanded(
                child:
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('chats').doc(groupChatId).collection(groupChatId).snapshots(),
                    builder: (context,snapshot) {
                    if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                    }
                    else {
                      var messages = snapshot.requireData.docs;
                      return
                        ListView.builder(
                            itemCount: messages.length,
                            itemBuilder: (context,index){
                              return Card(
                                child: ListTile(
                                  title: Text(messages[index]["message"]!),
                                  subtitle: Text("${messages[index]["fromId"]!} - ${messages[index]["timestamp"]!}"),
                                ),
                              );
                            });
                    }
                    },
                )
              ),
              Row(
                children: [
                  Expanded(child: TextField(decoration: InputDecoration(hintText: "Enter message"),controller: messageEditingController,)),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: TextButton(onPressed: (){
                        FirebaseFirestore.instance.collection('chats').doc(groupChatId).collection(groupChatId).doc(DateTime.now().microsecondsSinceEpoch.toString()).set({
                          'fromId':widget.userId,
                          'toId': widget.friendId,
                          'message': messageEditingController.text,
                          'timestamp': DateTime.now().microsecondsSinceEpoch.toString()
                        });
                    }, child: Text("Send"), style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blueAccent), foregroundColor: MaterialStateProperty.all(Colors.white)),),
                  ),
                ],
              )
            ],
          ),
        ),

    );
  }
}
