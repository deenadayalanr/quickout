import 'package:flutter/material.dart';
import './view.dart';
import '../database/getdata.dart';

List req = [];
class Home extends StatefulWidget {
  final email;
  Home(this.email);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<FormState> _formK = GlobalKey();
  Map<String, String> auth= {
    'studentname': '',
    'department': '',
    'roomno': '',
    'indate': '',
    'outdate': '',
    'reason': '',
    'status':'pending',
  };
  String response='';
  formData () async{
    var data = {
      "email":widget.email,
      "studentname": auth['studentname'],
      "department": auth['department'],
      "roomno": auth['roomno'],
      "indate": auth["indate"],
      "outdate": auth["outdate"],
      "reason": auth["reason"],
      "status": auth["status"]
    };
    var result = await http_post_register("formdata",data);
    if(result.ok){
      setState(() {
        response = result.data['status'];
      });
    }
  }

  var _isLoading = false;

  void _submit() {
    if (!_formK.currentState.validate()) {
      // Invalid!
      return;
    }
    _formK.currentState.save();
    formData();
    Navigator.pushReplacement(context,MaterialPageRoute(builder: (BuildContext context) =>Display(widget.email)));
    setState(() {
      _isLoading = true;
    });

    setState(() {
      _isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Quickout'),
        ),
        body:SingleChildScrollView(
          child: Form(
            key: _formK,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Student Name'),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your name';
                      }
                    },
                    onSaved: (value) {
                      auth['studentname']=value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Department'),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your department name';
                      }
                    },
                    onSaved: (value) {
                      auth['department']=value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Room No'),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your room no';
                      }
                    },
                    onSaved: (value) {
                      auth['roomno']=value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Address of visit'),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter the address of visit';
                      }
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'In Date'),
                    keyboardType: TextInputType.datetime,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter in date';
                      }
                    },
                    onSaved: (value) {
                      auth['indate']=value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Out Date'),
                    keyboardType: TextInputType.datetime,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter out date';
                      }
                    },
                    onSaved: (value) {
                      auth['outdate']=value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Reason for Leave'),
                    keyboardType: TextInputType.multiline,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a reason for leave';
                      }
                    },
                    onSaved: (value) {
                      auth['reason']=value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Phone No'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your mobile Number';
                      }
                    },
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  RaisedButton(
                    child: Text('Request'),
                    color: Colors.blueAccent,
                    onPressed: _submit,
                  )
                ],
              ),
            ),
            ),
          ),
        ),),
    );
  }
}
