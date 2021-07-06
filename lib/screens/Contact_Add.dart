import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AddContacts extends StatefulWidget {
  @override
  _AddContactsState createState() => _AddContactsState();
}

class _AddContactsState extends State<AddContacts> {
   late TextEditingController _firstnameController, _lastnameController,_numbercontroller1,
   _numbercontroller2;
  late DatabaseReference _ref;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firstnameController = TextEditingController();
    _lastnameController = TextEditingController();
    _numbercontroller1 = TextEditingController();
    _numbercontroller2 = TextEditingController();
    _ref = FirebaseDatabase.instance.reference().child('Contacts');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a Contact'),
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _firstnameController,
              decoration: InputDecoration(
                labelText: 'Enter First Name',
                prefixIcon: Icon(
                  Icons.account_circle,
                  size: 30,
                ),
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.all(15),
              ),
            ),
            TextFormField(
              controller: _lastnameController,
              decoration: InputDecoration(
                labelText: 'Enter Last Name',
                prefixIcon: Icon(
                  Icons.account_circle,
                  size: 30,
                ),
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.all(15),
              ),
            ),
            TextFormField(
              controller: _numbercontroller1,
              decoration: InputDecoration(
                hintText: 'Enter First Number',
                prefixIcon: Icon(
                  Icons.phone,
                  size: 30,
                ),
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.all(15),
              ),
            ),
            TextFormField(
              controller: _numbercontroller2,
              decoration: InputDecoration(
                hintText: 'Enter Second Number',
                prefixIcon: Icon(
                  Icons.phone,
                  size: 30,
                ),
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.all(15),
              ),
            ),
            Container(
              height: 40,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: ElevatedButton(child: Text('Save Contact',style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w600,

              ),),
                onPressed: (){
                  saveContact();
                },
              ),
            )

          ],
        ),
      ),
    );
  }
  void saveContact(){

    String first_name = _firstnameController.text;
    String last_name = _lastnameController.text;
    String first_number = _numbercontroller1.text;
    String second_number = _numbercontroller2.text;

    Map<String,String> contact = {
      'first_name':first_name,
      'last_name':last_name,
      'first_number': first_number,
      'second_number': second_number,
    };

    _ref.push().set(contact).then((value) {
      Navigator.pop(context);
    });


  }
}