import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
class AddContacts extends StatefulWidget {
  @override
  _AddContactsScreen createState() => _AddContactsScreen();
}
// Define a custom Form widget.
class _AddContactsScreen extends State<AddContacts> {
   late TextEditingController _firstnameController, _lastnameController,_numbercontroller1,
   _numbercontroller2, _numbercontroller3;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firstnameController = TextEditingController();
    _lastnameController = TextEditingController();
    _numbercontroller1 = TextEditingController();
    _numbercontroller2 = TextEditingController();
    _numbercontroller3 = TextEditingController();
    //Specifies that the Destination would be under the Collection named: "Contacts"
    _db =FirebaseDatabase.instance.reference().child('Contacts');
  }
   late DatabaseReference _db;
   @override
   void dispose() {
     _firstnameController.dispose();
     _lastnameController.dispose();
     _numbercontroller1.dispose();
     _numbercontroller2.dispose();
     _numbercontroller3.dispose();
     super.dispose();
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a Contact'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CircleAvatar(
              child:Align(
                alignment: Alignment.topCenter,
              ),
              backgroundImage: NetworkImage('https://www.pngfind.com/pngs/m/678-6781630_icon-profile-bio-avatar-person-symbol-chat-circle.png'),
              radius: 50,
              backgroundColor: Colors.cyan[100],
            ),
            TextFormField(
              controller: _lastnameController,
              enabled: false,
                textAlign:TextAlign.center,
                decoration: InputDecoration.collapsed(
                hintText: "Last Name",
                border: InputBorder.none,
              ),
            ),
            TextFormField(
                controller: _firstnameController,
                enabled: false,
                textAlign:TextAlign.center,
                decoration: InputDecoration.collapsed(
                hintText: "First Name",
                border: InputBorder.none,
              ),
            ),
            Divider(
                thickness: 5,
                color: Colors.blueGrey
            ),
            TextFormField(
              controller: _firstnameController,
              textCapitalization: TextCapitalization.words,
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
              textCapitalization: TextCapitalization.words,
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
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter First Number',
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
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Second Number',
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
              controller: _numbercontroller3,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Third Number',
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
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: ElevatedButton(child: Text('Save',style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w600,

              ),),
                onPressed: (){
                  addContact();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
  void addContact(){
//Save them as Strings
    String first_name = _firstnameController.text;
    String last_name = _lastnameController.text;
    String first_number = _numbercontroller1.text;
    String second_number = _numbercontroller2.text;
    String third_number = _numbercontroller3.text;
//"Loads" up the strings and prepares a Map which can be used to send to the Database
    Map<String,String> contactmap = {
      'first_name':first_name,
      'last_name':last_name,
      'first_number': first_number,
      'second_number': second_number,
      'third_number': third_number,
    };
//Send and 'pop' back to previous screen
    _db.push().set(contactmap).then((value) {
      Navigator.pop(context);
    });


  }
}