import 'package:flutter/cupertino.dart';
import 'package:flutter_contactsapp/screens/Contact_List.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';
// IDEA  =
// RUN FUNCTION: Initialize = GET Password from Master ID.
// WHEN USER INPUTS DATA, Check if Password Matches with Inputted Password,
// if Correct, POST TIME AND DATE OF SESSION(Sessions+1) LOGIN, GET TOKEN, PASS TOKEN TO OTHER SCREENS.
// If Incorrect, Display ToastMessage

//# 2
//initialize: get password,
// On button press: compare  password and inputted Password, If correct, get response which is our token, get token and assign it to a variable which can be passed to the other screens
// and Navigator.push to the other screen.
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build (BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title:'Contacts Application with Flutter',
      home:LoginScreen(),
    );
  }
}
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreen createState() => _LoginScreen();
}
class _LoginScreen extends State<LoginScreen> {
  late TextEditingController _passwordController, _usernameController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _passwordController = TextEditingController();
    _usernameController = TextEditingController();
  }
  fetchpassword() async {
    Uri url = Uri.http('contactsapptask.herokuapp.com', '/passwords');
    var res = await http.get(url);
    print ("test");
    if (res.statusCode == 200){
      var password = json.decode(res.body);
      print ("testsuccess");
      setState(() {
        var databasepassword = (password[0]["password"]);
        print(databasepassword);
      });
    }else {
      print ("testfail");
    }
  }
    ConfirmPassword()async{
      Uri url = Uri.http('contactsapptask.herokuapp.com', '/passwords');
      var getresponse = await http.get(url);
      String username= _usernameController.text;
      String userpassword= _passwordController.text;
        var password = json.decode(getresponse.body);
        print(password);
        var databasepassword = (password[0]["password"]);
        if (userpassword == databasepassword) {
          var postresponse = await post(Uri.http('contactsapptask.herokuapp.com', '/sessions'),
              body: {
                'username': username,
                'password': userpassword
              });
          var accesstoken = json.decode(postresponse.body);
          var token = (accesstoken["accessToken"]);
          print(token);
          Navigator.push(context,MaterialPageRoute(builder: (context) =>
              ContactList(token:token),
          )
          );
        }else{
          print("AUTH FAILED");
        }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: buildLoginScreen(context)
    );
  }
  @override
  Widget buildLoginScreen (BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextFormField(
            controller: _usernameController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Enter your Username',
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
            controller: _passwordController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Enter the Password',
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
                  ConfirmPassword();
                }
            ),
          )
        ],
      ),
    );
  }
}