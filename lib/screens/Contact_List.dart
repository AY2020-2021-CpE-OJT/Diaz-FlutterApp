import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contactsapp/screens/Contact_Add.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build (BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title:'Contacts Application with Flutter',
      home:ContactList(),
    );
  }
}
class ContactList extends StatefulWidget {
  @override
  Contacts createState() => Contacts();
}
class Contacts extends State<ContactList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _db = FirebaseDatabase.instance.reference().child('Contacts');
  }
  late Query _db;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Contacts'),
      ),
      body: Container(
        height:double.infinity,
        child: FirebaseAnimatedList(
          query: _db,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            Map contact = snapshot.value;
            return _buildContactList(contact : contact);
          },
        ),
      ),
      floatingActionButton: buildNavigateButton(),
    );
  }
  //To build the
  Widget _buildContactList({required Map contact}){
    return Center(
      child:ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.primaries[Random().nextInt(Colors.primaries.length)],
            child: Text(contact['first_name'].substring(0,1).toUpperCase()+contact['last_name'].substring(0,1).toUpperCase()),
      ),
        isThreeLine: true,
        title: Text(contact['first_name']+' '+contact['last_name']),
        subtitle: Text('Numbers: '+contact['first_number']+ ' , '+contact['second_number']
            +' , '+contact['third_number'],style:TextStyle(fontSize:15)),
      ),
    );
  }
  Widget buildNavigateButton()=>FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: (){
        Navigator.push(context,MaterialPageRoute(builder: (context) => AddContacts()),
        );
      }
  );
}
