import 'package:flutter/cupertino.dart';
import 'package:flutter_contactsapp/screens/Contact_List.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contactsapp/screens/Contact_Login.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';

class EditContacts extends StatefulWidget {
  final String id;
  final String first_name;
  final String last_name;
  final String number1;
  final String number2;
  final String number3;
  final String token;
  EditContacts({Key? key, required this.id,required this.first_name,required this.last_name,
    required this.number1, required this.number2,required this.number3,required this.token,}) : super(key: key);

  @override
  _EditContacts createState() => _EditContacts();
}

class _EditContacts extends State<EditContacts> {
  late TextEditingController _firstnameController, _lastnameController,
      _numbercontroller1,
      _numbercontroller2, _numbercontroller3;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firstnameController = TextEditingController(text: widget.first_name);
    _lastnameController = TextEditingController(text: widget.last_name);
    _numbercontroller1 = TextEditingController(text: widget.number1);
    _numbercontroller2 = TextEditingController(text: widget.number2);
    _numbercontroller3 = TextEditingController(text: widget.number3);
    //Specifies that the Destination would be under the Collection named: "Contacts"
    //_db =FirebaseDatabase.instance.reference().child('Contacts');
  }
  // receive data from ContactList
  void ModifyContact()async{
    String first_name = _firstnameController.text;
    String last_name = _lastnameController.text;
    String number1 = _numbercontroller1.text;
    String number2 = _numbercontroller2.text;
    String number3 = _numbercontroller3.text;
    await put(Uri.http('contactsapptask.herokuapp.com', '/students/' + widget.id),
        headers: {"token": widget.token},
        body:{
          'first_name': first_name,
          'last_name':last_name,
          'number1': number1,
          'number2': number2,
          'number3': number3,
        });
    Navigator.push(context,MaterialPageRoute(builder: (context) => ContactList(token: widget.token,))).then((value) {
      setState(() {});
       }
    );
  }
    /*final response = await patch(Uri.http('contactsapptask.herokuapp.com/students/','/$widget.id'),
        body:{
          'first_name': first_name,
          'last_name':last_name,
          'number1': number1,
          'number2': number2,
          'number3': number3,
        });
    Navigator.pop(context);
  }*/
 showConfirmDeleteDialog(BuildContext context){
    // set up the buttons
    Widget CancelButton = TextButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget ConfirmButton = TextButton(
      child: Text("Continue"),
      onPressed:  () {
        Navigator.of(context, rootNavigator: true).pop();
        http.delete(Uri.parse('https://contactsapptask.herokuapp.com/students/' + widget.id),
            headers:{"token":widget.token});
        Navigator.push(context,MaterialPageRoute(builder: (context) => ContactList(token: widget.token,))).then((value) {
          setState(() {});
        });
        Contacts();
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("Delete a Contact Confirmation"),
      content: Text("Are you sure you would want to delete this contact?"),
      actions: [
        CancelButton,
        ConfirmButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit A Contact'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.delete_outline,
                size: 30.0,
                color: Colors.red[900],
              ),
              onPressed: () {
                showConfirmDeleteDialog(context);
                /*http.delete(Uri.parse('https://contactsapptask.herokuapp.com/students/' + widget.id));
                Navigator.push(context,MaterialPageRoute(builder: (context) => MyApp())).then((value) {
                  setState(() {});
                });*/
              },
            )
          ],
        ),
        body: buildEditContactList(context)
    );
  }
  @override
  Widget buildEditContactList (BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                child: Icon(
                    Icons.person_outline_rounded,
                    size: 90,
                ),
                radius: 50,
                backgroundColor: Colors.cyan[100],
              ),
            ),
            TextFormField(
              controller: _lastnameController,
              enabled: false,
              textAlign: TextAlign.center,
              decoration: InputDecoration.collapsed(
                hintText: "Last Name",
                border: InputBorder.none,
              ),
            ),
            TextFormField(
              controller: _firstnameController,
              enabled: false,
              textAlign: TextAlign.center,
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
                labelText: 'Edit First Name',
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
                labelText: 'Edit Last Name',
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
                labelText: 'Edit First Number',
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
                hintText: '(Optional)',
                labelText: 'Edit Second Number',
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
                hintText: '(Optional)',
                labelText: 'Edit Third Number',
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
              child: ElevatedButton(child: Text('Modify Contact', style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),),
                onPressed: () {
                  ModifyContact();
                  }
              ),
            )
          ],
        ),
      ),
    );
  }
}

