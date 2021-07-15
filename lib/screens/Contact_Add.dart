import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter_contactsapp/screens/Contact_List.dart';
/*Future<http.Response> createAlbum(String first_name,last_name,number1,number2,number3) {
  return http.post(

    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'first_name':first_name,
      'last_name':last_name,
      'number1': number1,
      'number2': number2,
      'number3 ': number3,
    }),

  );

}*/
/*Future<Album> createAlbum(String first_name,last_name,number1,number2,number3) async {
  final response = await http.post(
    Uri.parse('10.0.2.2:3000/students'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'first_name':first_name,
      'last_name':last_name,
      'number1': number1,
      'number2': number2,
      'number3 ': number3,
    }),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

class Album {
  final int id;
  final String first_name;
  final String last_name;
  final String number1;
  final String number2;
  final String number3;

  Album({required this.id, required this.first_name,required this.last_name,
    required this.number1,
    required this.number2,
    required this.number3,});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'], first_name: json['first_name'],last_name: json['last_name'],
      number1: json['number1'],
      number2: json['number2'],
      number3: json['number3'],
    );
  }
}*/
class AddContacts extends StatefulWidget {
  @override
  _AddContactsScreen createState() => _AddContactsScreen();
}
// Define a custom Form widget.
class _AddContactsScreen extends State<AddContacts> {
  final _formKey = GlobalKey<FormState>(); // For Storing Form state

  late TextEditingController _firstnameController, _lastnameController,
      _numbercontroller1,
      _numbercontroller2, _numbercontroller3;
  void addContact()async{
    String first_name = _firstnameController.text;
    String last_name = _lastnameController.text;
    String number1 = _numbercontroller1.text;
    String number2 = _numbercontroller2.text;
    String number3 = _numbercontroller3.text;
     await post(Uri.http('contactsapptask.herokuapp.com', '/students'),
        body:{
      'first_name': first_name,
      'last_name':last_name,
      'number1': number1,
      'number2': number2,
      'number3': number3,
        });
    Navigator.push(context,MaterialPageRoute(builder: (context) => MyApp())).then((value) {
      setState(() {});
      }
    );
  }
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
    //_db =FirebaseDatabase.instance.reference().child('Contacts');
  }

  //late DatabaseReference _db;
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
        child:Form(
        key: _formKey,
        child: Column(
          children: [
            CircleAvatar(
              child: Align(
                alignment: Alignment.topCenter,
              ),
              radius: 50,
              backgroundColor: Colors.cyan[100],
              backgroundImage: NetworkImage('https://www.pinclipart.com/picdir/middle/55-555141_join-us-comments-add-person-icon-png-clipart.png'),
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
                labelText: 'Enter First Name',
                prefixIcon: Icon(
                  Icons.account_circle,
                  size: 30,
                ),
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.all(15),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Your First Name';
                }
                return null;
              },
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Your Last Name';
                }
                return null;
              },
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Your Primary Number';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _numbercontroller2,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Second Number (Optional)',
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
                labelText: 'Enter Third Number (Optional)',
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
              child: ElevatedButton(child: Text('Save', style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),),
                onPressed: () {
                  setState(() {
                    if(_formKey.currentState!.validate()){
                      addContact();
                    }
                  });
                },
              ),
            )
          ],
        ),
      ),
      )
    );
  }
}


/*void addContact(){
//Save them as Strings
    String first_name = _firstnameController.text;
    String last_name = _lastnameController.text;
    String number1 = _numbercontroller1.text;
    String number2 = _numbercontroller2.text;
    String number3 = _numbercontroller3.text;
//"Loads" up the strings and prepares a Map which can be used to send to the Database
    Map<String,String> contactmap = {
      'first_name':first_name,
      'last_name':last_name,
      'number1': number1,
      'number2': number2,
      'number3 ': number3,
    };
//Send and 'pop' back to previous screen
    //_db.push().set(contactmap).then((value) {
     // Navigator.pop(context);
   // });
*/


