import 'package:flutter/material.dart';
import '../database/getdata.dart';
import '../auth/auth_screen.dart';

class Stud extends StatefulWidget {
  final email;
  Stud(this.email);
  @override
  _StudState createState() => _StudState();
}

class _StudState extends State<Stud> {
  List users = [];
  Future<void> refreshUsers()async{
    users.clear();
    var result = await http_get_users('form');
    if(result.ok){
      setState(() {
        for(var user in result.data){
          if(user['email']==widget.email){
            users.add(user);
          }
        }
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Text("Quickout"),
            ),
        body: RefreshIndicator(
          onRefresh: refreshUsers,
          child: ListView.separated(
          itemBuilder: (context,i)=>ListTile(
            leading: Icon(Icons.person),
            title: Column(children: <Widget>[
              Text('Student Name: ${users[i]['studentname'].toString()}'),
              Text('Department: ${users[i]['department'].toString()}'),
              Text('Room num: ${users[i]['roomno'].toString()}'),
              Text('Indate: ${users[i]['indate'].toString()}'),
              Text('Outdate: ${users[i]['outdate'].toString()}')
            ],),
            trailing: Text(users[i]['status']),
          ),
          separatorBuilder: (context,i)=>Divider(),
          itemCount: users.length,
        ),
        )
      )
    );
  }
}
