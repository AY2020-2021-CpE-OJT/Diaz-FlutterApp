import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_contactsapp/screens/Contact_Add.dart';
import 'package:flutter_contactsapp/screens/Contact_Edit.dart';
import 'package:flutter_contactsapp/screens/Contact_Login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class ContactList extends StatefulWidget {
  final String token;
  ContactList({Key? key, required this.token}) : super(key: key);
  @override
  Contacts createState() => Contacts();
}
class Contacts extends State<ContactList> {
  bool refresh = true;
  List _items=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.fetchUser();

  }
  fetchUser() async {
    Uri url = Uri.http('contactsapptask.herokuapp.com', '/students');
    var res = await http.get(url, headers: {"token":widget.token});
    print ("test");
    if (res.statusCode == 200){
      var items = json.decode(res.body);
      print ("testsuccess");
      print (items);
      setState(() {
        refresh = false;
        _buildcontactlist(context);
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
        //if Refresh = false then load circular progress indicator, else load _buildcontactlist widget
        body: refresh ?  Center(
            child: CircularProgressIndicator()
        )
           :_buildcontactlist(context),
    );
  }
  Widget _buildcontactlist (BuildContext context) {
    return Scaffold(
        body: Column(
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
                              Icons.drag_indicator_outlined,
                              size: 20.0,
                              color: Colors.brown[900],
                            ),
                            onPressed: () {
                              Navigator.push(context,MaterialPageRoute(builder: (context) =>
                                  EditContacts(id:_items[index]['_id'],first_name:_items[index]['first_name'],last_name:_items[index]['last_name'],
                                      number1:_items[index]['number1'],number2:_items[index]['number2'],number3:_items[index]['number3'],token:widget.token,
                                  ))
                               ).then((value) => setState(() {
                                 fetchUser();
                               }));
                             }
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
    );
  }

  // Add Floating Button to move to the Add Contacts Screen
  Widget buildNavigateButton()=>FloatingActionButton(
      child: Icon(Icons.person_add_rounded),
      onPressed: (){
        Navigator.push(context,MaterialPageRoute(builder: (context) => AddContacts(token: widget.token,))).then((value) => setState(() {
          fetchUser();
        }));
      }
  );
}



