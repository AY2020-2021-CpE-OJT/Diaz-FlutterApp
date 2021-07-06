
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contactsapp/screens/Contact_Add.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build (BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title:'Contacts Application with Flutter',
      theme: ThemeData(
        primaryColor:Colors.deepPurple,
        accentColor:Colors.redAccent,
      ),
      home:ContactList(),
    );
  }
}
class ContactList extends StatefulWidget {
  @override
  _ContactsState createState() => _ContactsState();
}
class _ContactsState extends State<ContactList> {
  late Query _ref;
  DatabaseReference reference =
  FirebaseDatabase.instance.reference().child('Contacts');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ref = FirebaseDatabase.instance
        .reference()
        .child('Contacts')
        .orderByChild('last_name');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Contacts'),
      ),
      body: Container(
        height:double.infinity,
        child: FirebaseAnimatedList(
          query: _ref,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            Map contact = snapshot.value;
            return _buildContactList(contact : contact);
          },
        ),
      ),
        floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context,MaterialPageRoute(builder: (_){
          return AddContacts();
        }),
        );
      },
        child: Icon(Icons.add,color:Colors.white),
      ),
    );
  }
  Widget _buildContactList({required Map contact}){
    return Container(
      height:100,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
          thickness: 5,
            color: Colors.blueGrey
          ),
          Row(children: [
              Icon(Icons.person,
              size:20,),
              SizedBox( width:6,),
              Text(contact['first_name'],style:TextStyle(fontSize:16)),
          ],),
          Row(children: [
            SizedBox( width:25,),
            Text(contact['last_name'],style:TextStyle(fontSize:16)),
          ],),
          Row(children: [
            Icon(Icons.phone,
              size:20,),
            SizedBox( width:6,),
            Text(contact['first_number'],style:TextStyle(fontSize:16)),
          ],),
          Row(children: [
            SizedBox( width:25,),
            Text(contact['second_number'],style:TextStyle(fontSize:16)),
          ],),
        ],
      ),
    );
  }
}