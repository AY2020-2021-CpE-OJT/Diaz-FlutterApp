import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_contactsapp/screens/Contact_Add.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  List _items=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.fetchUser();
  }
  fetchUser() async {
    Uri url = Uri.http('contactsapptask.herokuapp.com', '/students');
    var res = await http.get(url);
    print ("test");
    if (res.statusCode == 200){
      var items = json.decode(res.body);
      print ("testsuccess");
      print (items);
      setState(() {
        _items= items;
      });
    }else {
      setState(() {
        _items =[];
        print ("testfail");
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Contacts'),
      ),
        floatingActionButton: buildNavigateButton(),
        body: _buildcontactlist(context)
      );
  }


  Widget _buildcontactlist (BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            _items.length > 0
                ? Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.all(10),
                    child: ListTile(
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.delete_outline,
                              size: 15.0,
                              color: Colors.brown[900],
                            ),
                            onPressed: () {
                              http.delete(Uri.parse('https://contactsapptask.herokuapp.com/students/${_items[index]['_id']}'));
                            },
                          ),
                        ],
                      ),
                        leading: CircleAvatar(
                          backgroundColor: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                          child: Text(_items[index]['first_name'].substring(0,1).toUpperCase()+_items[index]['last_name'].substring(0,1).toUpperCase()),
                        ),
                        title: Text(_items[index]['first_name']+' '+_items[index]['last_name']),
                        subtitle: Text(_items[index]["number1"]+','+_items[index]["number2"]+','+_items[index]["number3"])
                    ),
                  );
                  },
              ),
            )
                : Container()
          ],
        ),
      ),
    );
  }
  Widget buildNavigateButton()=>FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: (){
        Navigator.push(context,MaterialPageRoute(builder: (context) => AddContacts()));
      }
  );
}



