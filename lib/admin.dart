import 'package:flutter/material.dart';
import './auth/auth_screen.dart';
import './screens/form.dart';
import './database/getdata.dart';

var g = req;
class AdminState extends StatefulWidget {
  @override
  _AdminStateState createState() => _AdminStateState();
}

class _AdminStateState extends State<AdminState> {
  
  List users = [];
  Future<void> refreshUsers()async{
    users.clear();
    var result = await http_get_users('form');
    if(result.ok){
      setState(() {
        for(var user in result.data){
          users.add(user);
        }
      }
      );
    }
  }
  Future<void> accept(int i)async{
    var datas = {
      'email': users[i]['email'],
      'status':'Accepted'
    };
    var result = await http_put_admin('formdata',datas);
    if(result.ok){
      users.clear();
      setState(() {
        for(var user in result.data){
          users.add(user);
        }
        }
      );
    }
  }
  Future<void> reject(int i)async{
    var datas = {
      'email': users[i]['email'],
      'status':'Rejected'
    };
    var result = await http_put_admin('formdata',datas);
    if(result.ok){
      users.clear();
      setState(() {
        for(var user in result.data){
          users.add(user);
        }
      }
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Text("Quickout"),
            actions: <Widget>[
              GestureDetector(
                child: Icon(
                  Icons.exit_to_app,
                  size: 30.0,
                ),
                onTap: (){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext)=>AuthScreen()));
                },
              )
            ],
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
              Text('Outdate: ${users[i]['outdate'].toString()}'),
              users[i]['status'].toString()=='pending'?
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                FlatButton(
                  child:Text('Accept'),
                  color: Colors.green,
                  onPressed: (){accept(i);},
                ),
                FlatButton(
                  child:Text('Reject'),
                  color: Colors.red,
                  onPressed: (){reject(i);},
                )
              ],):FlatButton(child: Text(users[i]['status'].toString()),color: Colors.blue,onPressed: (){},)
            ],),
          ),
          separatorBuilder: (context,i)=>Divider(),
          itemCount: users.length,
        ),
        ),
        )
    );
  }
}
